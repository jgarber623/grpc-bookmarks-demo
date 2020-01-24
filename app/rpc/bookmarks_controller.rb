class BookmarksController < Gruf::Controllers::Base
  bind Rpc::Bookmarks::Service

  def get_bookmark
    id = request.message.id

    Bookmark.find(id).to_proto
  rescue ActiveRecord::RecordNotFound => exception
    fail! :not_found, :bookmark_not_found, exception.message
  rescue StandardError => exception
    fail! :internal, :unknown, exception.message
  end

  def list_bookmarks
    message = request.message
    limit = message.limit.positive? ? message.limit : 100
    offset = message.offset.positive? ? message.offset : 0

    Bookmark.limit(limit).offset(offset).map(&:to_proto)
  rescue StandardError => exception
    fail! :internal, :unknown, exception.message
  end
end
