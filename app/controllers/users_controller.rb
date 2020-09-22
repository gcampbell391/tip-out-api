class UsersController < ApplicationController

    def index 
        users = User.all
        render json: users, include: [:shifts]
    end

    def show
        user = User.find(params[:id])
        if user
            render json: user, include: [:shifts]
        else
            render json: { error: "Not found!" }, status: 404
        end 
    end

end
