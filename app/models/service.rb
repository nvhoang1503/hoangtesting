# require 'rubygems'
require 'httparty'
class Service
  # require 'httparty'
  # include HTTParty
  def self.create_user(email,password,confirm_password,address)
    domain = Rails.application.config.domain
    response = HTTParty.post("#{domain}/api/v1/users/", 
        :body => { 
                    :email => email,
                    :password => password,
                    :password_confirmation => confirm_password,
                    :address => address
                 }.to_json,
        :headers => { 'Content-Type' => 'application/json' } 
      )
    data = JSON.parse(response.body)
  end

  def self.sign_in(email,password)
    domain = Rails.application.config.domain
    response = HTTParty.post("#{domain}/api/v1/users/sign_in/", 
      :body => { 
                  :email => email,
                  :password => password
               }.to_json,
      :headers => { 'Content-Type' => 'application/json' } )
    data = JSON.parse(response.body)
  end

end