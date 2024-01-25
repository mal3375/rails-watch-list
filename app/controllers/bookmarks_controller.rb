class BookmarksController < ApplicationController
  #before_action set_list, only: [:new, :create, :destroy]
  def new
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new
  end

  def create
    @list = List.find(params[:list_id])
    @movie = Movie.find(params[:bookmark][:movie_id])
    #@movie = Movie.find(params[:movie_id])
    #@bookmark = Bookmark.new(bookmark_params)
    #@bookmark.list = @list
   # @bookmark.movie = @movie
   #@bookmark = Bookmarks.new(bookmark_params)
   @bookmark = Bookmark.new(movie: @movie, list: @list)
    if @bookmark.save
      redirect_to list_path(@bookmark.list), notice: 'Bookmark was successfully added to the list.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = @list.bookmarks.find(params[:id])
     @bookmark.destroy
    redirect_to list_path(@bookmark.list), notice: 'Bookmark was successfully removed from the list.'
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
