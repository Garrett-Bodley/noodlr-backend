class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]


  def create
    user = User.create(user_params)
    if user.valid?
      token = encode_token(user_id: user.id)
      render json: {user: UserSerializer.new(user), token: token}, status: :created
    else
      render json: { messages: ['Invalid username or password'] }, status: :not_acceptable
    end
  end

  def update
    user = User.find_by(id: user_params[:id])
    if user == current_user && user.authenticate(user_params[:password])
      if !user_params[:new_password].empty? && !user_params[:new_password_confirmation].empty?
        user.update(username: user_params[:username], password: user_params[:new_password], password_confirmation: user_params[:new_password_confirmation])
        if user.valid?
          render json: user, status: :ok
        else
          render json: { messages: user.errors.full_messages }, status: :not_acceptable
        end
      else 
        user.update(username: user_params[:username])
        if user.valid?
          render json: user, status: :ok
        else
          render json: { messages: user.errors.full_messages}, status: :not_acceptable
        end
      end
    else
      render json: { messages: ['Invalid username or password'] }, status: :not_acceptable
    end
  end

  def destroy
    user = current_user
    user.destroy
    render json: {messages: ['Account deleted']}, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:id, :username, :password, :password_confirmation, :new_password, :new_password_confirmation)
  end
  
end
