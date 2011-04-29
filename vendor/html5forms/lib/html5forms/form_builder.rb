require 'action_view'
module Html5Forms

  class FormBuilder < ::ActionView::Helpers::FormBuilder

    def initialize(object_name, object, template, options, proc)
      @options_generator = HtmlAttributesForValidation.new(object)
      super(object_name, object, template, options, proc)
    end

    %w[password_field
       text_field
       text_area
       search_field telephone_field
       url_field
       email_field
       number_field
       range_field].each do |word|
      define_method(word.to_sym) do |*args|
        method, options = if args.last.kind_of? Hash
                            args
                          else
                            [args.first, {}]
                          end
        super(method, get_html_options(method, options))
      end
    end
    
    alias phone_field telephone_field

    def check_box(method, options = {}, checked_value = "1", unchecked_value = "0")
      super(method, get_html_options(method, options), checked_value, unchecked_value)
    end

    private

    def get_html_options(method, options)
      @options_generator.html_options_for(method).merge(options)
    end
    
  end
  
end
