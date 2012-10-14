class TourRequestsController < ApplicationController
  
  before_filter :find_tour_by_token, only: [:edit, :update]

  def new
    @tour_request = TourRequest.new
  end

  def edit
    @partial = get_partial(@tour_request)    
  end

  def create
    @tour_request = TourRequest.new(params[:tour_request])
    @tour_request.ip_address = request.remote_ip
    @tour_request.token = Digest::MD5.hexdigest("#{@tour_request.email}+#{Time.now.to_s}")
    if @tour_request.save
      redirect_to root_url, notice: "Please check your email. We've sent an activation link to #{@tour_request.email}."
    else
      render action: "new"
    end
  end


  def update
    @tour_request.amenities = params[:amenities] if params[:amenities]
    if @tour_request.update_attributes(params[:tour_request])
      unless @tour_request.request_complete?
        redirect_to edit_tour_request_path(id: @tour_request.id , t: @tour_request.token)  
      else  
        params[:tour_request][:rating] ? (redirect_to root_url, notice: "Thank you for rating your tour") : (redirect_to action: "success")
      end
    else
      render action: "edit"
    end
  end
  
  def success 
  end  
  
  def get_partial(tour_request)
    if !tour_request.has_contact_info?  
      return "user"
    elsif tour_request.preferred_tour_date.blank?
      return "tour"
    else
      return "rating"
    end
  end
  
  private
  
  def find_tour_by_token
    redirect_to root_url, :error => "Tour request not found. Please click the link in the email you received." unless @tour_request = TourRequest.find_by_token(params[:t])
  end
end
