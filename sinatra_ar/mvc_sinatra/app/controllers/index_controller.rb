require 'sinatra'

get '/' do
  erb :form
end

get '/:birthdate' do
  birthdate = params[:birthdate].to_i
  birth_path_num = Person.get_birth_path_num(birthdate)
  @message = Person.get_message(birth_path_num)
  erb :index
end

get '/message/:birth_path_num' do
  birth_path_num = params[:birth_path_num].to_i
  @message = Person.get_message(birth_path_num)
  erb :index
end 

post '/' do
    birthdate = params[:birthdate]
    if Person.valid_birthdate(birthdate)
      birth_path_num = Person.get_birth_path_num(birthdate)
      redirect "/message/#{birth_path_num}"
    else
      @error = "You should enter a valid birthdate in the form of mmddyyyy."
      erb :form
    end
end








