class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visitor_id
      t.integer :short_url_id
      t.timestamps
      # t.datetime :updated_at
      # t.datetime :created_at
    end

    add_index(:visits, :visitor_id)
    add_index(:visits, :short_url_id)
    add_index(:visits, :updated_at)
    add_index(:visits, :created_at)
  end
end
