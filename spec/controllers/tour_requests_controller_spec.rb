require 'spec_helper'

describe TourRequestsController do
  
  describe "get_partial" do
    it "returns a name for a partial" do
      @tour =TourRequest.create(email: "maggie@simpson.com", ip_address: "127.0.0.1", token: "f5810e18e410df10baa3e3f751c9e007")
      @controller = TourRequestsController.new()
      @controller.get_partial(@tour).should == "user"
      
      @tour.update_attributes(first_name: "Maggie", last_name: "Simpson", phone_number: "5415415411")
      @controller.get_partial(@tour).should == "tour"
      
      #can't use update or it tries to fire off emails - simpler to just create new tour request
      @tour = TourRequest.create(email: "maggie@simpson.com", ip_address: "127.0.0.1", token: "f5810e18e410df10baa3e3f751c9e007", first_name: "Maggie", last_name: "Simpson", phone_number: "5415415411", preferred_tour_date: "2012-10-12 00:00:00")
      @controller.get_partial(@tour).should == "rating"
    end
  end
  
end