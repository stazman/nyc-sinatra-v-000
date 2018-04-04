require 'pry'

class FiguresController < ApplicationController

    get '/figures' do
        @figures = Figure.all
        erb :'/figures/index'
    end
        
    get '/figures/new' do
        erb :'/figures/new'
    end

    get '/figures/:id' do
        @figure = Figure.find_or_create_by(params(:id))
        erb :'/figures/show'
    end

    post '/figures' do
        @figure = Figure.create(:name => params["name"])
        # ??? why figure and not name in solution?
        if !params["landmark"]["name"].empty?
            @figure.landmarks << Landmark.create(:name => params["landmark"]["name"], :year_completed => params["landmark"]["year_completed"])
        end
        if !params["title"]["name"].empty?
            @figure.titles << Title.create(:name => params["title"]["name"])
        end

        # @figure.landmark = Landmark.find_or_create_by(:name => params['landmark']['name'])
        # @figure.title = Title.find_or_create_by(:name => params['title']['name'])
        # binding.pry
        # ??? why not this in solution?

       
        # @figure.landmark_ids = params[:landmarks]
        # ??? why in other labs and not this one acc. to solution?
        # ??? how does params[:landmarks] work?
        # @figure.title_ids = params[:titles]
        @figure.save          
        redirect "/figures/#{@figure.id}"
    end

    
end