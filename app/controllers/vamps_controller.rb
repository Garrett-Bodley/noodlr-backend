class VampsController < ApplicationController

  def create
    vamp = Vamp.new(vamp_params)
    vamp.user = current_user
    vamp.save
    render json: vamp
  end

  def index
    user_vamps = Vamp.where(user_id: current_user.id)
    render json: user_vamps
  end

  def show
    vamp = Vamp.find_by(user_id: current_user.id, id: params[:id])
    render json: vamp
  end

  def update
    vamp = Vamp.find_by(user_id: current_user.id, id: params[:id])
    vamp.update(vamp_params)
    render json: vamp
  end

  def destroy
    vamp = Vamp.find_by(user_id: current_user, id: params[:id])
    vamp.destroy
    render json: params[:id]
  end
  
  private

  def vamp_params
    params.require(:vamp).permit(:name, :notation, :tempo, :volume)
  end

end
