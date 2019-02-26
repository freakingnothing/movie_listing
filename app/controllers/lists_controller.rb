class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: %i[show edit update destroy]

  def index
    @lists = current_user.lists.all
  end

  def show
  end

  def new
    @list = current_user.lists.new
  end

  def create
    @list = current_user.lists.create(list_params)
    
    if @list.save
      redirect_to @list
    else
      render 'new'  
    end
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to @list
    else
      render 'edit'
    end
  end

  def destroy
    if @list.destroy
      redirect_to 'index'
    else
      flash[:danger] = 'Error'
    end    
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:title)
  end
end
