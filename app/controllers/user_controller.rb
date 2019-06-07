class UserController < ApplicationController

  def index
    if params[:query].present?
      sql_query = "first_name ILIKE :query OR last_name ILIKE :query"
      @users = User.where(sql_query, query: "%#{params[:query]}%").page params[:page]
    else
       @users = User.all.order(:first_name).page params[:page]
    end
  end

  def consult_api
    response =  RestClient.get "https://randomuser.me/api/?results=1000&seed=giga&nat=br" #consult the API with seed = giga & 30 results & nationality = br
    byebugs
    repos = JSON.parse(response) # "parse das informações em JSON
    repos["results"].each do |result| #create a new instance of the model user
      #byebug
      search = User.where(first_name: "#{result["name"]["first"]}" , last_name: "#{result["name"]["last"]}")
      if search.count == 0
        user = User.new
        user.genre = result["gender"] #select gender
        if user.genre == "male"
          user.genre = "masculino"
          else
          user.genre = "feminino"
        end
        user.title = result["name"]["title"] #select title
        user.first_name = result["name"]["first"] #select first name
        user.last_name = result["name"]["last"] #select last name
        user.email = result["email"] #select email
        user.picture = result["picture"]["large"] #picture address
        user.remote_avatar_url = user.picture #saving picture locally
        user.save!
      end
    end
    redirect_to action:'index'
  end

  def erase_db
    User.all.each do |user|
      user.remove_avatar!
      user.save!
      user.delete
    end
    redirect_to action:'index'
  end

end
