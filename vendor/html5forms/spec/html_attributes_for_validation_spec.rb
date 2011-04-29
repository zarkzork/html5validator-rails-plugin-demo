require File.dirname(__FILE__) + '/spec_helper'

class TestValidator < ActiveModel::EachValidator
  def initialize(*attributes)
    super :attributes => attributes
  end
end

class TestValidator1 < TestValidator; end
class TestValidator2 < TestValidator; end
class TestValidator3 < TestValidator; end

class TestValidator1Hook 

  def self.validator
    TestValidator1
  end

  def get_options
    { "pattern" => 'pattern1', "field1" => 'value1' }
  end

  include ValidatorHook
  
    
end


class TestValidator2Hook 


  def self.validator
    TestValidator2
  end

  def get_options
    { "pattern" => 'pattern2', "field2" => 'value2'}    
  end

  include ValidatorHook
  
end

class TestValidator3Hook 


  def self.validator
    TestValidator3
  end

  def get_options
    { "field2" => 'value3'}
  end

  include ValidatorHook
    
end

describe HtmlAttributesForValidation do

  before :each do
    @model_class = double('ModelClass')
    @model_class.stub(:validators){
      [
       TestValidator1.new(:one),
       TestValidator2.new(:one, :two, :four),
       TestValidator3.new(:one, :four)
      ]
    }
    @model = double('model')
    @model.stub(:class){ @model_class }
    @html_options =
      Html5Forms::HtmlAttributesForValidation.new(@model)
  end

  it 'shoud return empty hash for non matching attributes' do
    @html_options.html_options_for(:six).should == {}
  end

  it 'should return filled hash for matching attribute' do
    @html_options.html_options_for(:two).should ==  {
      "pattern" => 'pattern2', "field2" => 'value2' }
  end
  
  it 'should replace all attributes except "pattern" when merging' do
    @html_options.html_options_for(:four).should ==  {
      "pattern" => 'pattern2', "field2" => 'value3'}
  end

  it 'should merge pattern attribute' do
    @html_options.html_options_for(:one).should == {
      "pattern" => '(?=pattern1)(?=pattern2)',
      "field1" => 'value1',
      "field2" => 'value3'}      
  end

  it 'should give validator instance to the hook block' do 
  end
  

end
