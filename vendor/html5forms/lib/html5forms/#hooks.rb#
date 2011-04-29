require 'active_model'

class Object
  def define_singleton_method(name, &block)
    (class<<self;self;end).send(:define_method, name, &block)
  end
end unless Object.respond_to? :define_singleton_method

module Html5Forms

  # Wraps a validator and code block to anonymous class that includes
  # Validator hook.
  def self.add_validator_hook_for(validator, &block)
    Class.new do

      define_singleton_method :validator do
        validator
      end

      define_method :get_options, &block

      include ValidatorHook
      
    end
  end

  add_validator_hook_for ::ActiveModel::Validations::PresenceValidator do
    { 'required' => 'required', 'title' => model_error_message(:blank)}
  end
  
  add_validator_hook_for ::ActiveModel::Validations::AcceptanceValidator do 
    { 'required' => 'required', 'title' => model_error_message(:accepted) }
  end

  add_validator_hook_for ::ActiveModel::Validations::ExclusionValidator do 
    values = validator.options[:in].to_a
    message = model_error_message(:exclusion)    
    {'pattern' => "(?!#{values.join('|')})", 'title' => message}
  end

  add_validator_hook_for ::ActiveModel::Validations::FormatValidator do 

    with = validator.options[:with].source if validator.options[:with]
    without = validator.options[:without].source if validator.options[:without]
    
    pattern = if with && without
                "(?=#{with})(?!#{without})"
              else
                with or "(?!#{without})"
              end
    {'pattern' => pattern, 'title' => model_error_message(:invalid) }    
  end

  add_validator_hook_for ::ActiveModel::Validations::InclusionValidator do 
    values = validator.options[:in].to_a
    message = model_error_message(:inclusion)        
    {'pattern' => values.join('|'), 'title' => message  }
  end

  # as html 5 for now supports only maxlength attribute it will pass
  # to html options only maximum value 
  add_validator_hook_for ::ActiveModel::Validations::LengthValidator do 
    {'maxlength' => validator.options[:maximum]}
  end

  add_validator_hook_for ::ActiveModel::Validations::NumericalityValidator do 
    opts = validator.options
    { 'type' => 'number'}.tap do  |hash|
      hash['max'] = opts[:less_than] -1 if opts[:less_than]
      hash['max'] = opts[:less_than_or_equal_to] if opts[:less_than_or_equal_to]
      hash['min'] = opts[:greater_than] -1 if opts[:greater_than]
      hash['min'] = opts[:greater_than_or_equal_to] if opts[:greater_than_or_equal_to]      
      hash['min'] = hash['max'] = opts[:equal_to] if opts[:equal_to]
    end
  end
  
  add_validator_hook_for ::ActiveModel::Validations::ConfirmationValidator do 
    {'data-confirmation-validator' => 'true' }    
  end
  
end
