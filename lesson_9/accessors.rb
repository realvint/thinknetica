 module Accessors
  def attr_accessor_with_history(*args)
    args.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
      end
      history_var = history_getter(name)
      history_setter(name, var_name, history_var)
    end
  end

  def strong_attr_accessor(name, class_name)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }
    define_method("#{name}=".to_sym) do |value|
      raise TypeError unless value.is_a?(class_name)
      instance_variable_set(var_name, value)
    end
  end

  private

  def history_getter(name)
    history_var = "@#{name}_history".to_sym
    define_method("#{name}_history".to_sym) { instance_variable_get(history_var) }
  end

  def history_setter(name, var_name, history_var)
    define_method("#{name}_history=".to_sym) do |value|
      instance_variable_set(var_name, value)
      history =
        if instance_variable_defined?(history_var)
          instance_variable_get(history_var)
        else
          instance_variable_set(history_var, [])
        end
      history << value
    end
  end
end