require 'active_record'

class Login < ActiveRecord::Base
	attr_accessible :name, :password, :fname, :lname, :phnumber, :email
	 validates_presence_of :name
	 validates_uniqueness_of :name
end
