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

  def show
  end

  def edit
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
  
end
