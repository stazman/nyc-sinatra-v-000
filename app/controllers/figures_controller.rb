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
        @figure = Figure.create(name: params["figure_name"], title_ids: params["figure"]["title_ids"], landmark_ids: params["figure"]["landmark_ids"])
        
        # ??? why figure and not name in solution?
        if !params["new_title"].empty?
            @figure.titles << Title.create(name: params["new_title"])
        end

        if !params["landmark"]["name"].empty?
            @figure.landmarks << Landmark.create(:name => params["landmark"]["name"], :year_completed => params["landmark"]["year_completed"])
        end
        @figure.save          
        # @figure.titles.save
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

    # post '/figures/:id' do 
    #     @figure = Figure.find(params[:id])
    #     @figure.update(params[:figure])
        
    #     if !params[:landmark][:name].empty?
    #         @figure.landmarks << Landmark.create(params[:landmark])
    #     end

    #     if !params[:title][:name].empty?
    #         @figure.titles << Title.create(params[:title])
    #     end
        
    #     @figure.save
    #     redirect to "/figures/#{@figure.id}"
    # end
end