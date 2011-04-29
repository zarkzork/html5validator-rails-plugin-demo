module Html5Forms

  autoload :ValidatorHook, 'html5forms/validator_hook'  
  autoload :HtmlAttributesForValidation, "html5forms/html_attributes_for_validation"
  autoload :FormBuilder, 'html5forms/form_builder'
  autoload :FormFor, 'html5forms/form_for'

  require "html5forms/railtie" if defined? Rails
  require 'html5forms/hooks'
  
end
