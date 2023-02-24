class BookmarksController < ApplicationController
  before_action :set_list, only: %i(new index create)

  def new
    @bookmark = Bookmark.new
    # @list = List.find(params[:list_id])
  end

  def index
    # @list = List.find(params[:list_id])
    @bookmarks = @list.bookmarks
  end

  def create
    movies = params[:bookmark][:movie].drop(1).each do |movie|
      @bookmark = Bookmark.new(bookmark_params)
      @bookmark.movie = Movie.find(movie)
      # we can get the list id from the url, theres no need to worry about
      # funny business in a form and therefore no need to permit list_id
      @bookmark.list = @list
      unless @bookmark.save
        return render :new, status: :unprocessable_entity
      end
    end
    redirect_to list_path(@list)
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy

    redirect_to list_path(bookmark.list), status: :see_other
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:comment)
  end
end
