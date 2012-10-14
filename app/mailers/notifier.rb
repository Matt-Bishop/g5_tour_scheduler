class Notifier < ActionMailer::Base
  def self.base_url
    "http://" + default_url_options[:host]
  end
  
  def tour_activation(tour_request)
    @tour_request = tour_request
    mail(to:       "#{@tour_request.email}",
         subject:  "You have requested a tour. Please click the confirmation link",
         reply_to: "")
  end
  
  def tour_confirmation(tour_request)
    @tour_request = tour_request
    mail(to:       "#{@tour_request.email}",
         subject:  "Thank you for requesting a tour",
         reply_to: "")
  end
  
  def tour_scheduled(tour_request)
    @tour_request = tour_request
    mail(to:       "tours@example.com",
         subject:  "A tour has been scheduled")
  end
        
end