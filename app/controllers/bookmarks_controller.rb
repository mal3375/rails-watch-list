class BookmarksController < ApplicationController
  #before_action set_list, only: [:new, :create, :destroy]
  def new
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @bookmark = Bookmarks.new(bookmark_params)
    #@movie = Movie.find(params[:movie_id])
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
   # @bookmark.movie = @movie
    if @bookmark.save
      redirect_to list_path(@list), notice: 'Bookmark was successfully added to the list.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])

  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
