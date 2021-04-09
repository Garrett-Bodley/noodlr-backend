class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]


  def create
    user = User.create(user_params)
    if user.valid?
      token = encode_token(user_id: user.id)
      render json: {user: UserSerializer.new(user), token: token}, status: :created
    else
      render json: { message: 'Invalid username or password' }, status: :not_acceptable
    end
  end

  def update
    user = User.find_by(id: user_params[:id])
    if user == current_user && user.authenticate(user_params[:password])
      if !!user_params[:new_password] && !!user_params[:new_password_confirmation]
        begin 
          user.update(username: user_params[:username], password: user_params[:new_password], password_confirmation: user_params[:password_confirmation])
        rescue
          render json: { message: 'New password and password confirmation fields must match' }, status: :not_acceptable
        else
          render json: user, status: :ok
        end
      elsif 
        begin
          user.update(username: user_params[:username])
        rescue
          render json: { message: 'Invalid username supplied'}
        else
          render json: user, status: :ok
        end
      end
    else
      render json: { message: 'Invalid username or password' }, status: :not_acceptable
    end
  end

  def show
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:id, :username, :password, :password_confirmation, :new_password, :new_password_confirmation)
  end
  
end
