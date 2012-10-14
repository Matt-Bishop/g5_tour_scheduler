class TourRequest < ActiveRecord::Base
  attr_accessible :additional_questions, :amenities, :email, :first_name, :ip_address, :last_name, :phone_number, :preferred_tour_date, :token, :rating
  
  AMENITIES = ["pool", "rec room", "movie theater", "on site doctor", "time machine"]
  serialize :amenities
  
  validates :email, presence: true 
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates :ip_address, presence: true
  
  validates :first_name, presence: true, :on => :update 
  validates :last_name, presence: true, :on => :update 
  validates :phone_number, presence: true, :on => :update
  
  
  after_create :send_activation_email
  after_update :send_confirmation_email
  
  def has_contact_info?
    !first_name.blank? && !last_name.blank? && !phone_number.blank? && !email.blank?
  end 
  
  def request_complete?
    has_contact_info? && !preferred_tour_date.blank?
  end
  
  def send_activation_email
    Notifier.tour_activation(self).deliver
  end
  
  def send_confirmation_email
    if request_complete? && rating.blank?
      Notifier.tour_confirmation(self).deliver
      Notifier.tour_scheduled(self).deliver
    end
  end
end
