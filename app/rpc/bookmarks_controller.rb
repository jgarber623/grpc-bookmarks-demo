class BookmarksController < Gruf::Controllers::Base
  bind Rpc::Bookmarks::Service

  def get_bookmark
    bookmark.to_proto
  rescue StandardError
    fail! :not_found, :bookmark_not_found, "Couldn't find Bookmark with 'id'=#{request.message.id}"
  end

  def list_bookmarks
    limit = request.message.limit.positive? ? request.message.limit : 100

    bookmarks.limit(limit).offset(request.message.offset).map(&:to_proto)
  end

  private

  def bookmark
    @bookmark ||= Bookmark.find(request.message.id)
  end

  def bookmarks
    @bookmarks ||= Bookmark.all
  end
end
