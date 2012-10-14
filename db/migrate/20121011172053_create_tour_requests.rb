class CreateTourRequests < ActiveRecord::Migration
  def change
    create_table :tour_requests do |t|
      t.string    :email
      t.string    :first_name
      t.string    :last_name
      t.string    :phone_number
      t.text      :amenities
      t.string    :additional_questions
      t.string    :ip_address
      t.string    :token
      t.timestamp :preferred_tour_date
      t.integer   :rating
      t.timestamps
    end
  end
end
