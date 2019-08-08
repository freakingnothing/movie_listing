class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: %i[edit update destroy]

  def index
    @pagy, @lists = pagy(current_user.lists.all)
    @list = current_user.lists.new
  end

  def show
    @list = List.find(params[:id])
    @pagy_movies_all, @movies_all = pagy(@list.movies,
                                         page_param: :page_movies_all,
                                         params: { active_tab: 'movies_all' })
    @pagy_movies_completed, @movies_completed = pagy(@movies_all.completed,
                                                     page_param: :page_movies_completed,
                                                     params: { active_tab: 'movies_completed' })
    @pagy_movies_in_progress, @movies_in_progress = pagy(@movies_all.active,
                                                         page_param: :page_movies_in_progress,
                                                         params: { active_tab: 'movies_in_progress' })
  end

  def create
    @list = current_user.lists.create(list_params)

    redirect_to @list if @list.save
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
    @list.destroy
    redirect_to lists_path
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:title)
  end
end
