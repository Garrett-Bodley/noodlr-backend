class VampSerializer < ActiveModel::Serializer
  attributes :id, :name, :notation, :volume, :tempo
end
