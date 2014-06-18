class BookingController < ApplicationController
  def create
    # auth_token        = params[:booking][:auth_token]
    seater_number     = params[:booking][:seater_number]
    address           = params[:booking][:address]
    domain = Rails.application.config.domain
    response = Curl.post("#{domain}/api/v1/bookings/", {
                                                  :auth_token     => session[:auth_token],
                                                  :seater_number  => seater_number,
                                                  :address        => address
                                                }
                    )
    data = JSON.parse(response.body)
    if data["status"].to_i == 200
      redirect_to booking_show_path(:booking_id => data["booking"]["id"])
    else
      redirect_to root_path, notice: data["errors"]
    end
  end

  def show
    id = params[:booking_id]
    domain = Rails.application.config.domain
    response = Curl.get("#{domain}/api/v1/bookings/get_booking?auth_token=#{session[:auth_token]}&booking_id=#{id}")
    data = JSON.parse(response.body)
    if data["status"].to_i == 200
      @booking = data["booking"]
    else
      redirect_to root_path, notice: "System error"
    end
  end

  def yourbooking
    domain = Rails.application.config.domain
    response = Curl.get("#{domain}/api/v1/bookings/user_booking?auth_token=#{session[:auth_token]}")
    data = JSON.parse(response.body)
    if data["status"].to_i == 200
      @bookings = data["bookings"]
    else
      redirect_to root_path, notice: "System error"
    end
    
  end

end