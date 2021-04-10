class VampsController < ApplicationController

  def create
    vamp = Vamp.new(vamp_params)
    vamp.user = current_user
    vamp.save
    render json: vamp, status: :ok
  end

  def index
    user_vamps = Vamp.where(user_id: current_user.id)
    render json: user_vamps, status: :ok
  end

  def show
    vamp = Vamp.find_by(user_id: current_user.id, id: params[:id])
    if !!vamp
      render json: vamp, status: :ok
    else
      render json: {message: 'Vamp not found'}, status: :not_acceptable
    end
  end

  def update
    vamp = Vamp.find_by(user_id: current_user.id, id: params[:id])
    vamp.update(vamp_params)
    render json: vamp, status: :ok
  end

  def destroy
    vamp = Vamp.find_by(user_id: current_user, id: params[:id])
    vamp.destroy
    render json: params[:id], status: :ok
  end
  
  private

  def vamp_params
    params.require(:vamp).permit(:name, :notation, :tempo, :volume)
  end

end
