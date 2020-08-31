class SightingsController < ApplicationController
    # As before with only and except, include is actually just another option that we can pass into the to_json method. Rails is just obscuring this part:
    def index
        sightings = Sighting.all
        render json: sightings.to_json(include: [:bird, :location])
      end
       
      def show
        sighting = Sighting.find_by(id: params[:id])
        if sighting
          render json: sighting.to_json(include: [:bird, :location])
        else
          render json: { message: 'No sighting found with that id' }
        end
      end
    ########Code with .to_json explicitly shown above######
    # def index
    #     sightings = Sighting.all
    #     render json: sightings, include: [:bird, :location]
    # end

    # def show
    #     sighting = Sighting.find_by(id: params[:id])
    #     render json: { id: sighting.id, bird: sighting.bird, location: sighting.location }
    #     #alternative:  render json: sighting, include: [:bird, :location], except: [:updated_at]
    # end

end

# When nesting models in JSON the way we saw in this lab, it is entirely possible to use include in conjunction with only and exclude.
# But this begins to complicate things significantly as we work with nested resources and try to limit what they display.
# Using the fully written to_json render statement can help keep things a bit more readable here:

# def show
#     sighting = Sighting.find_by(id: params[:id])
#     render json: sighting.to_json(:include => {
#       :bird => {:only => [:name, :species]},
#       :location => {:only => [:latitude, :longitude]}
#     }, :except => [:updated_at])
#   end

# While that is neat, it seems silly to have to include such a complicated render line in our action. In addition, in this example we're only dealing with three models. Customizing what is rendered in a larger set of nested data could quickly turn into a major headache.

# Now that we have covered how to customize and shape Rails model data into JSON, we can start to look at options for keeping that data well organized when building more complicated APIs.