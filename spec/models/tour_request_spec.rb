require 'spec_helper'

describe TourRequest do
  
  describe "has_contact_info?" do
    it "returns false if any contact fields are blank, and true if they are filled in" do
      @tour =TourRequest.create(email: "maggie@simpson.com", ip_address: "127.0.0.1", token: "f5810e18e410df10baa3e3f751c9e007")
      @tour.has_contact_info?.should == false
      @tour.update_attributes(first_name: "Maggie")
      @tour.has_contact_info?.should == false
      @tour.update_attributes( last_name: "Simpson")
      @tour.has_contact_info?.should == false
      @tour.update_attributes( phone_number: "5415415411")
      @tour.has_contact_info?.should == true
    end
  end  
  
  describe "request_complete?" do
    it "returns true if the tour request is complete, and false if not" do
      @tour =TourRequest.create(email: "maggie@simpson.com", ip_address: "127.0.0.1", token: "f5810e18e410df10baa3e3f751c9e007",first_name: "Maggie", last_name: "Simpson", phone_number: "5415415411", preferred_tour_date: "2012-10-12 00:00:00")
      @tour.request_complete?.should == true
      @tour.update_attributes(preferred_tour_date: "")
      @tour.request_complete?.should == false    
    end
  end
  
  
end  