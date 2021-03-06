class UsersController < ApplicationController

  before_action :authorize, only: [:login, :root_path]

  def index
  @users = User.all
end

def show
  @user = User.find(params[:id])
end

def new
  @user = User.new
end

def create

  @user = User.new(user_params)
  if @user.save!
    flash[:notice]= "Welcome to SheDev! Please sign in."
    redirect_to login_path
  else
    redirect_to new_user_path
  end
end

def edit
  @user = User.find(params[:id])

end

def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    flash[:success]= "Profile Updated"
    redirect_to user_path(@user)
  else
    flash[:error]="Something went wrong. Please try again."
    redirect_to edit_user_path
  end
end

def destroy
  @user = User.find(params[:id])
  @user.destroy
  session[:user_id] = nil
  redirect_to root_path
end



private
  def user_params
    params.require(:user).permit(:name, :email, :bio, :pic_url, :location, :job_title, :password, :password_confirmation)
  end
end
