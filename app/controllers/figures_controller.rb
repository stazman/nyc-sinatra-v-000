class FiguresController < ApplicationController

    get '/figures/' do
        @figure = Figure.all
        erb :'/figures/index'
    end
        
    get '/figures/new' do
        erb :'/figures/new'
    end

    post '/figures/' do
        @figure = Figure.find_or_create_by(params(:name))
        @figure.save
    end

end