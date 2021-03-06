class SupportsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show]


  def index
    @supports = Support.all
  end

  def new
    @support = Support.new
  end

  def create
    @support = Support.new(support_params)
    if @support.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @support = Support.find(params[:id])
  end


  private
    def support_params
      params.require(:support).permit(:item,:price,:reason,:status,:image).merge(user_id: current_user.id)
    end

end