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
    data = Service.create_user(email,password,confirm_password,address)
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
    data = Service.sign_in(email,password)
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
