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
        # Where does the human user click on an edit button?
        @figure = Figure.find(params[:id])
        erb :'figures/edit'
    end

    post '/figures' do
        # ??? Why does this show the root url /figures ... is it supposed to go back to the index page? 
        @figure = Figure.create(params[:figure])

            if !params[:title][:name].empty?
                @figure.titles << Title.create(params[:name])
            end
            
            if !params[:landmark][:name].empty?
                @figure.landmarks << Landmark.create(params[:landmark])
            end
        
        @figure.save     
        redirect "/figures/#{@figure.id}"
    end

    patch '/figures/:id' do
        # binding.pry
        @figure = Figure.find(params[:id])
        @figure.update(params[:figure])
        @figure.save
        @figure.landmark = Landmark.find(params[:id])
        @figure.landmark.update(params[:landmark])
        @figure.landmark.save
        @figure.title.update(params[:title])
        @figure.landmark.save

        # if !params[:figure][:name].empty?
        #     @figure = Figure.create(params[:figure])
        # end
        
        if !params[:title][:name].empty?
            @figure.titles << Title.create(params[:name])
        end
        
        if !params[:landmark][:name].empty?
            @figure.landmarks << Landmark.create(params[:landmark])
        end
        redirect "/figures/#{@figure.id}"
    end
end