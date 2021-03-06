class UsersController < ApplicationController

    def index 
        users = User.all
        render json: users, include: [:shifts]
    end

    def show
        user = User.find(params[:id])
        if user
            render json: {
                user: user,
                totalTips: user.total_tips,
                totalShifts: user.total_shifts,
                totalHours: user.total_hours,
                avgTipsPerShift: user.average_tips_per_shift,
                avgTipsPerNight: user.average_tips_per_night,
                avgTipsPerDay: user.average_tips_per_day,
                avgPerHour: user.average_per_hour,
                avgPerHourNight: user.average_per_hour_at_night,
                avgPerHourDay: user.average_per_hour_at_day,
                bestShift: user.best_shift,
                worstShift: user.worst_shift,

            }, include: [:shifts]
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
        @shift = Shift.find_by(user_id: params[:userID],shift_date: params[:shift_date], shift_type: params[:shift_type])
        #If date and shift type exists..return error
        if @shift != nil
            return render json: {error: "Shift Already Exists"}
        else
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


    def delete_shift
        puts 'Delete shift'
        @shift = Shift.find_by(user_id: params[:userID], shift_date: params[:shiftDate], shift_type: params[:shiftType])
        if @shift == nil
            render json: { status: "Shift Doesn't Exist!" }
        else
            render json: { shift: @shift }
            @shift.destroy
        end
    end


    def update_name
        @user = User.find(params[:id])
        @user.name = params[:name]
        if @user.valid?
            @user.save
            render json: { user: @user }
        else
            render json: { error: "Update Error!" }, status: 404
        end
    end

    def update_email
        @user = User.find(params[:id])
        @user.email = params[:email]
        if @user.valid?
            @user.save
            render json: { user: @user }
        else
            render json: { error: "Update Error!" }, status: 404
        end
    end

    def update_password
        @user = User.find(params[:id])
        if @user && @user.authenticate(params[:oldPassword])
            @user.password_digest = BCrypt::Password.create(params[:newPassword])
            @user.save
            render json: { user: @user }
        else
            render json: {error: "Current Password Is Incorrect. Please Try Again."}, status: 404
        end
    end

    def delete_account
        @user = User.find(params[:id])
        if @user 
            @user.destroy
            render json: { message: "User Account Successfully Terminated" }

        else
            render json: {error: "Error occured. Please Try Again."}, status: 404

        end
    end


end
