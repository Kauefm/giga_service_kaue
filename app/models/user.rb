class User < ApplicationRecord
  paginates_per 9
  mount_uploader :avatar, AvatarUploader
  validates_uniqueness_of :first_name, scope: :last_name
end
