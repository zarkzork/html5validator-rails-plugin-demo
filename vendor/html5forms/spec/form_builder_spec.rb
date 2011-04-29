libdir = File.dirname(__FILE__)
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)
require 'spec_helper'
require 'test_model'
require 'active_support'
require 'active_model'
require 'action_pack'
require 'action_view'
require 'action_view/base'
require 'action_view/template/handlers/erb'

require  File.join(File.dirname(__FILE__), '..', 'lib', 'html5forms', 'form_builder')



describe Html5Forms::FormBuilder do

  include ActionView::Helpers
  include ActionView::Context
  
  #mock
  def test_models_path
    "path"
  end

  #mock
  def protect_against_forgery?
    false
  end

  before(:all) do 
    obj = TestModel.new
    form_for obj, :builder => Html5Forms::FormBuilder do |f|
      @required_attr_input = f.text_field :required_attr
      @text_attr_input = f.text_field :text_attr
      @length_attr_input = f.text_field :length_attr
    end
  end

  it "should generate proper html input for attribute with pattern validation" do
    (@text_attr_input.include? "pattern=\"123\"").should == true
  end

  it "should generate proper html input for required attribute" do
    (@required_attr_input.include? "required=\"required\"").should == true
  end

  it "should generate proper html input for attribute with max length" do
    #includes only max length since html5 validators supports only maxlength
    (@length_attr_input.include? "maxlength=\"5\"").should == true
  end

end
