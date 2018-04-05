require 'pry'

class FiguresController < ApplicationController

    get '/figures' do
        @figures = Figure.all
        erb :'figures/index'
    end
        
    get '/figures/new' do
        erb :'figures/new'
    end

    get '/figures/:id' do
        @figure = Figure.find(params[:id])
        erb :'figures/show'
    end

    get '/figures/:id/edit' do 
        @figure = Figure.find(params[:id])
        erb :'figures/edit'
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
        # @figure.title_ids = params[:titles]

        # ??? how does params[:landmarks] work?
        @figure.save          
        redirect "/figures/#{@figure.id}"
    end

    patch '/figures/:id' do
        @figure = Figure.find(params["id"])
        @figure.update(params["figure"]["name"])
        @figure.save
        @figure.landmark = Landmark.find(params["id"])
        @figure.landmark.update(params["landmark"]["name"])
        @figure.landmark.save
        @figure.title.update(params["title"]["name"])
        @figure.landmark.save
        redirect "/figures/#{@figure.id}"
    end

    post '/figures/:id' do 
        @figure = Figure.find(params[:id])
        @figure.update(params[:figure])
        
        if !params[:landmark][:name].empty?
        @figure.landmarks << Landmark.create(params[:landmark])
        end

        if !params[:title][:name].empty?
        @figure.titles << Title.create(params[:title])
        end
        
        @figure.save
        redirect to "/figures/#{@figure.id}"
    end
end