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

    def add_shift
        @shift = Shift.new(user_id: params[:userID], employment_place: params[:employment_place], shift_date: params[:shift_date], shift_type: params[:shift_type], shift_hours: params[:shift_hours], pay_total: params[:pay_total])
        if params[:shift_comments] != ""
            @shift.shift_comments = params[:shift_comments]
        end
        if @shift.valid?
            @shift.save
            render json: {
                status: :created,
                newShift: @shift,
            }
        else
            render json: { status: 401 }
        end
    end

end
