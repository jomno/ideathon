class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :url
      t.string :img
      t.string :teamName
      t.string :member

      t.timestamps null: false
    end
  end
end
