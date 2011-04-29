module Html5Forms

  # Module to add validator class hooks. Validator hook describes how
  # to get html options from certain type of Validator. For descripion
  # of Validator take a look at rails ::ActiveModel::Validator.
  #
  # Example validator hook:
  #
  #    class ExclusionValidatorHook
  #    
  #      include ValidatorHook
  #    
  #      def self.validator
  #        ::ActiveModel::Validations::ExclusionValidator
  #      end
  #    
  #      def get_options
  #        values = validator.options[:in].to_a
  #        message = model_error_message(:exclusion)
  #        {'pattern' => "(?!#{values.join('|')})", 'title' => message} 
  #      end
  #    
  #    end
  module ValidatorHook

    class << self

      def hooks
        @hooks ||= {}
      end

      def included(subclass)
        _hooks = hooks
        if subclass.respond_to? :validator
          hooks[subclass.validator] = subclass 
        end
        
        subclass.instance_eval do
          define_singleton_method :singleton_method_added do |name|
            _hooks[subclass.validator] = subclass  if name == :validator
          end
        end
        
      end
      
    end
    
    attr_accessor :model, :attribute, :validator
    
    def initialize(model, attribute, validator)
      @model, @attribute, @validator = model, attribute, validator
    end

    def get_options
      raise NotImplementedError
    end

    def model_error_message(message_sym)
      model.errors.generate_message(attribute, message_sym, validator.options.dup)
    end
    
  end

  
end


