class Bookmark < ApplicationRecord
  def to_proto
    Rpc::Bookmark.new(
      id: id,
      bookmarked_url: bookmarked_url,
      canonical_url: canonical_url,
      archive_org_snapshot_url: archive_org_snapshot_url,
      initial_http_status_code: initial_http_status_code,
      final_http_status_code: final_http_status_code,
      note: note,
      created_at: created_at.to_time
    )
  end
end
