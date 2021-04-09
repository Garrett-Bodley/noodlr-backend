class AddVolumeAndTempoToVamps < ActiveRecord::Migration[6.1]
  def change
    add_column :vamps, :volume, :float
    add_column :vamps, :tempo, :int
  end
end
