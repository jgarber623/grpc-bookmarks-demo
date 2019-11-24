# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'

rows = CSV.read(Rails.root.join('db', 'seeds', 'bookmarks.csv'), headers: true)

rows.each do |row|
  Bookmark.create(
    bookmarked_url: row['bookmark_url'],
    canonical_url: row['canonical_url'],
    archive_org_snapshot_url: row['archive_org_snapshot_url'],
    initial_http_status_code: row['initial_http_status_code'],
    final_http_status_code: row['final_http_status_code'],
    note: row['note'],
    created_at: DateTime.parse(row['date_saved'])
  )
end
