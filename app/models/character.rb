class Character < ActiveRecord::Base
	attr_accessible :name, :address, :longitude, :latitude, :gmaps
	acts_as_gmappable

	def gmaps4rails_address
	#describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
	  address
	end

	def gmaps4rails_infowindow
      "<h1>#{name}</h1>
      <img src='http://cdn.eventfinder.com.au/uploads/events/transformed/243726-72319-6.jpg'>"
    end

    def gmaps4rails_sidebar
  		name
	end
end
