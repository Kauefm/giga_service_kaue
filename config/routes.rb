Rails.application.routes.draw do

root 'user#index'

get 'user/index'
get 'user/consult_api'
get 'user/erase_db'

end
