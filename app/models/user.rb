class User < ApplicationRecord
  has_many :vamps, dependent: :destroy
  has_secure_password
  validates :username, uniqueness: true
  validates :password, length: {in: 6...30}, if: :password
end
