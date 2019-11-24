class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.string :bookmarked_url
      t.string :canonical_url
      t.string :archive_org_snapshot_url
      t.string :initial_http_status_code
      t.string :final_http_status_code
      t.text :note

      t.timestamps
    end
  end
end
