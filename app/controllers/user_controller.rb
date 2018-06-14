class UserController < ApplicationController

  def index

    User.all.each do |user|
      user.destroy
    end

    response =  RestClient.get "https://randomuser.me/api/?results=30&seed=giga&nat=br" #consult the API with seed = giga & 30 results & nationality = br
    repos = JSON.parse(response) # "parse das informações em JSON

    repos["results"].each do |result| #create a new instance of the model user
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
      user.save
    end
      @users = User.all.order(:first_name)
  end
end
