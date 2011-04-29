require 'active_support'
require 'active_model'
require 'action_view'
require 'action_view/base'
require 'action_view/template/handlers/erb'

class TestModel

  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Naming  

  include ActionView::Context


  attr_accessor :password_attr, :text_attr, :required_attr, :length_attr
  attr_reader   :errors

  def persisted?
    false
  end

  def initialize
    @errors = ActiveModel::Errors.new(self)
  end

  validates_format_of :password_attr, :with => /123/
  validates_format_of :text_attr, :with => /123/
  validates_presence_of :required_attr
  validates_length_of :length_attr, :minimum => 2, :maximum => 5

end

=begin
libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)
include ActionView::Helpers
include ActionView::Context

def test_models_path
  "path"
end

def protect_against_forgery?
  false
end


o = TestModel.new

result =  form_for o do |f|
end

puts result
=end
