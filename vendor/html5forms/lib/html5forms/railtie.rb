require 'rails'

module Html5Forms
  class Railtie < ::Rails::Railtie
    initializer "Html5Forms.setup" do
      (::ActionView::Helpers).send(:include, Html5Forms::FormFor)
    end
  end
end
