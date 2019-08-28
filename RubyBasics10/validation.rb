module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(attr_name, rule, params = nil)
      validations = instance_variable_get(:@validations)
      validations ||= Hash.new { |hash, key| hash[key] = {} }
      validations[attr_name]["validation_rule_#{rule}".to_sym] = params
      instance_variable_set(:@validations, validations)
    end
  end

  module InstanceMethods
    def validate!
      validations = self.class.instance_variable_get(:@validations)
      validations&.each do |attr_name, rules|
        rules.each { |rule, params| send rule, attr_name, params }
      end
    end

    def valid?
      validate!
      true
    rescue ArgumentError
      false
    end

    private

    # rubocop:disable Style/GuardClause
    def validation_rule_presence(attr_name, _)
      unless instance_variable_get("@#{attr_name}")
        raise ArgumentError, "@#{attr_name} can`t be nil"
      end
    end

    def validation_rule_format(attr_name, format_regexp)
      unless instance_variable_get("@#{attr_name}") =~ format_regexp
        raise ArgumentError, "Invalid format for @#{attr_name}"
      end
    end

    def validation_rule_type(attr_name, req_class)
      unless instance_variable_get("@#{attr_name}").instance_of?(req_class)
        raise ArgumentError, "Invalid class for @#{attr_name}"
      end
    end

    def validation_rule_allowed_values(attr_name, values)
      unless values.include?(instance_variable_get("@#{attr_name}"))
        raise ArgumentError, "@#{attr_name} can be only from #{values}"
      end
    end
    # rubocop:enable Style/GuardClause
  end
end
