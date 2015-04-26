class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :address
      t.boolean :status, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
