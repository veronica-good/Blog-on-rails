class UsersController < ApplicationController
    before_action :find_user, only: [:edit, :update]
    def new
        @user=User.new
    end

    def create
        @user=User.new user_params
        if @user.save
            session[:user_id]=@user.id
            flash[:notice] = "Thank you for signing up!"
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
        # @user = User.find_by_id params[:id]
    end

    def update
        # @user = User.find_by_id params[:id]
        if @user.update user_info
            redirect_to root_path, notice: "Profile details updated"
        else
            render :edit
        end
    end

    def change_password
        @user = User.find_by_id params[:user_id]
        current_password=params[:current_password]
        new_password=params[:password]
        new_password_confirmation=params[:password_confirmation]
        valid_password= (current_password != new_password)
        valid_password_confirmation= (new_password == new_password_confirmation)
        if current_password && !@user.authenticate(current_password)
            flash[:alert]='Provided current password is wrong. Enter again!'
        end
        if @user && @user.authenticate(current_password)
            if valid_password && valid_password_confirmation
                @user.update password_params
                flash[:notice] = "Password updated successfully"
                redirect_to root_path                
            elsif !valid_password
                flash[:alert]="New password can not be the same as current password"
            elsif !valid_password_confirmation
                flash[:alert]="New password does match new password confirmation"
            end
        end
    end



    private
    def find_user
        @user = User.find_by_id params[:id]
    end
    def user_params
        params.require(:user).permit(:name,:email, :password, :password_confirmation)
    end

    def user_info
        params.require(:user).permit(:name,:email)
    end

    def password_params
        params.permit(:password, :password_confirmation)
    end
end
