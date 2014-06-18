class UserController < ApplicationController
  def register
  end

  def login
  end

  def create
    email             = params[:user][:email]
    password          = params[:user][:password]
    confirm_password  = params[:user][:confirm_password]
    address           = params[:user][:address]
    domain = Rails.application.config.domain
    # response = Curl.post("#{domain}/api/v1/users/", {
    #                                               :email => email,
    #                                               :password => password,
    #                                               :password_confirmation => confirm_password,
    #                                               :address => address
    #                                             }
                    # )

  response = HTTParty.post("#{domain}/api/v1/users/", 
    :body => { 
                :email => email,
                :password => password,
                :password_confirmation => confirm_password,
                :address => address
             }.to_json,
    :headers => { 'Content-Type' => 'application/json' } )


    data = JSON.parse(response.body)
    if data["status"].to_i == 201
      session[:auth_token]  = data["user"]["auth_token"]
      session[:email]       = data["user"]["email"]
      session[:address]     = data["user"]["address"]
      redirect_to root_path
    else
      redirect_to user_register_path, notice: data["errors"]
    end
  end

  def session_new
    email             = params[:user][:email]
    password          = params[:user][:password]
    domain = Rails.application.config.domain
    # response = Curl.post("#{domain}/api/v1/users/sign_in/", {
    #                                               :email => email,
    #                                               :password => password
    #                                             }
    #                 )
    
    response = HTTParty.post("#{domain}/api/v1/users/sign_in/", 
    :body => { 
                :email => email,
                :password => password
             }.to_json,
    :headers => { 'Content-Type' => 'application/json' } )
    
    data = JSON.parse(response.body)
    if data["status"].to_i == 200
      session[:auth_token]  = data["user"]["auth_token"]
      session[:email]       = data["user"]["email"]
      session[:address]     = data["user"]["address"]
      redirect_to root_path
    else
      redirect_to user_login_path, notice: data["errors"]
    end
  end

  def session_destroy
    session[:auth_token] = nil
    redirect_to root_path
  end

end
