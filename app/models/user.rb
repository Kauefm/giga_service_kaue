class User < ApplicationRecord
  paginates_per 9
  mount_uploader :avatar, AvatarUploader
end
