class Restaurant < ApplicationRecord
  belongs_to :category
  has_many  :comments
  mount_uploader :image, PhotoUploader
  validates_presence_of :name
end
