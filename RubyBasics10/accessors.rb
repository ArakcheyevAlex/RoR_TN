module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      attr_reader name

      attr_name = "@#{name}".to_sym
      attr_history_name = "@#{name}_history".to_sym

      # history reader
      define_method("#{name}_history") do
        instance_variable_get(attr_history_name)
      end

      # history attr_writer
      define_method("#{name}=") do |value|
        instance_variable_set(attr_name, value)
        history = instance_variable_get(attr_history_name)
        history ||= []
        history << value
        instance_variable_set(attr_history_name, history)
      end
    end
  end

  def strong_attr_accessor(name, req_class)
    attr_reader name

    define_method("#{name}=".to_sym) do |value|
      raise ArgumentError, 'Ivalid class' unless value.instance_of?(req_class)

      instance_variable_set("@#{name}".to_sym, value)
    end
  end
end
