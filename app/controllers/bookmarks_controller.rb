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
    @bookmark = Bookmark.new(bookmark_params)
    # we can get the list id from the url, theres no need to worry about
    # funny business in a form and therefore no need to permit list_id
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
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
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
