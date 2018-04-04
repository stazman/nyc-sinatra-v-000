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
        @landmark = Landmark.create(:name => params['landmarks']['name'])
        @landmark.figure = Figure.find_or_create_by(:name => params['figures']['name'])
        @landmark.title = Title.find_or_create_by(:title => params['titles']['name'])
        @landmark.figure_ids = params[:figures]
        @landmark.title_ids = params[:titles]
        @landmark.save          
        redirect "/landmarks/#{@landmark.id}"
        # ??? What's going on here with params[:figures]?
        # ??? Where does figure_ids come from?
    end

end
