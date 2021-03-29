class CreateVamps < ActiveRecord::Migration[6.1]
  def change
    create_table :vamps do |t|
      t.belongs_to :user
      t.json :notation
      t.timestamps
    end
  end
end
