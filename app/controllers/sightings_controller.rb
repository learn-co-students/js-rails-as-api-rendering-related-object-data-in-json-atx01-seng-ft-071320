class SightingsController < ApplicationController
    def show 
        sightings = Sighting.all
        render json: sightings, include: [:bird, :location], except: [:updated_at] 
      end
      
end
