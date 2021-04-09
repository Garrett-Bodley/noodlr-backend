class CreateVamps < ActiveRecord::Migration[6.1]
  def change
    create_table :vamps do |t|
      t.string :name
      t.belongs_to :user
      t.text :notation
      t.timestamps
    end
  end
end
