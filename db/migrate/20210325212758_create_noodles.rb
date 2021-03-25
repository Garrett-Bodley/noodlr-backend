class CreateNoodles < ActiveRecord::Migration[6.1]
  def change
    create_table :noodles do |t|
      t.belongs_to :user
      t.json :notation
      t.timestamps
    end
  end
end
