class FiguresController < ApplicationController

    get '/figures/' do
        @figure = Figure.all
        erb :'/figures/index'
    end
        
    get '/figures/new' do
        erb :'/figures/new'
    end

    post '/figures/' do
        @figure = Figure.create(params(:name))
        @figure.save
        erb :'figures/show'
    end

end