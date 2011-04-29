class RegistrationInformation < ActiveRecord::Base

  validates_presence_of :name, :email, :password, :phone, :age
  validates_inclusion_of :age, :in => 18..300, :message => "You must be from 18 to 300 years old!"
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Enter corect email address!"
  validates_format_of :phone, :with => /[0-9]{7}/, :message => "Only 7 didgits phone numbers supported!"
  validates_length_of :description, :maximum => 140, :message => "Must be tweetable!"

  attr_accessor :terms_of_service
  validates_acceptance_of :terms_of_service


end
