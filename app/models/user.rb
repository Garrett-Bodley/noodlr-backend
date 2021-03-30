class User < ApplicationRecord
  has_many :vamps, dependent: :destroy
  has_secure_password
end
