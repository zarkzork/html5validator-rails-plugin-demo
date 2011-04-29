module Html5Forms  
  class HtmlAttributesForValidation

    def initialize(model)
      @model, @model_class, @validators = model,  model.class, model.class.validators
      @attributes_validators = attributes_validators
    end

    def html_options_for(field_name)
      validators = @attributes_validators[field_name] || []
      validators.inject({}) do |acc, validator|
        options = html_options_for_validator field_name, validator
        merge_options(acc, options)        
      end
    end

    private

    def merge_options(old, new)
      old.merge(new) { |k, val1, val2|
        if k == 'pattern'
          "(?=#{val1})(?=#{val2})"
        else 
          val2
        end
      }
    end

    def each_validators
      @validators.select{ |v| v.kind_of? ::ActiveModel::EachValidator }
    end

    def attributes_validators
      each_validators.inject({}){ |acc, o|
        o.attributes.each { |a| (acc[a] ||= []) << o  }
        acc
      }
    end

    def html_options_for_validator(field_name, validator)
      hook_class = ValidatorHook.hooks[validator.class]
      hook = hook_class.new(@model, field_name, validator)
      hook.get_options
    end

  end
end
