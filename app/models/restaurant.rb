class Restaurant < ApplicationRecord
  belongs_to :category
  mount_uploader :image, PhotoUploader
  validates_presence_of :name
end
