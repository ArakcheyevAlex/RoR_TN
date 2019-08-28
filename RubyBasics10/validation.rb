module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attr_name, rule, params = nil)
      @validations ||= []
      @validations << {
        attr_name: attr_name,
        rule: :"validation_rule_#{rule}",
        params: params
      }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations&.each do |v|
        attr_value = instance_variable_get("@#{v[:attr_name]}")
        puts v.inspect
        send v[:rule], v[:attr_name], attr_value, v[:params]
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
    def validation_rule_presence(attr_name, attr_value, _)
      raise ArgumentError, "@#{attr_name} can`t be nil" unless attr_value
    end

    def validation_rule_format(attr_name, attr_value, format_regexp)
      unless attr_value =~ format_regexp
        raise ArgumentError, "Invalid format for @#{attr_name}"
      end
    end

    def validation_rule_type(attr_name, attr_value, req_class)
      unless attr_value.instance_of?(req_class)
        raise ArgumentError, "Invalid class for @#{attr_name}"
      end
    end

    def validation_rule_allowed_values(attr_name, attr_value, values)
      unless values.include?(attr_value)
        raise ArgumentError, "@#{attr_name} can be only from #{values}"
      end
    end
    # rubocop:enable Style/GuardClause
  end
end
