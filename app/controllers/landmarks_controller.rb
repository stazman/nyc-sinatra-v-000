class LandmarksController < ApplicationController

    get '/landmarks' do
        @landmarks = Landmark.all
        erb :'/landmarks/index'    
    end

    get '/landmarks/new' do
        erb :'/landmarks/new'
    end

    get '/landmarks/:id' do
        @landmark = Landmark.find(params[:id])
        erb :'/landmarks/:id/show'
    end

    get '/landmarks/:id/edit' do
        @landmark = Landmark.find(params[:id])
        erb :'/landmarks/:id/show'
    end

    post '/landmarks' do
        @landmark = Landmark.create(params[:landmark])
        @landmark.save          
        redirect "/landmarks/#{@landmark.id}"
        # ??? What's going on here with params[:figures]?
        # ??? Where does figure_ids come from?
    end

    post '/landmarks/:id' do
        @landmark = Landmark.find(params[:landmark])
        
    
    end

end
