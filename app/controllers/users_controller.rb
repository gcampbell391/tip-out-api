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

    def create
        @user = User.new(name: params[:name], email: params[:email])
        @user.password_digest = BCrypt::Password.create(params["password"])
        if @user.valid?
            @user.save
            render json: {
                status: :created,
                user: @user,
            }
        else
            render json: { status: 401 }
        end
    end

end
