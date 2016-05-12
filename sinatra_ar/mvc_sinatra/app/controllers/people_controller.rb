#CRUD = Create, Read, Update, Delete methods and routes.
#a PUT route is for UPDATING/EDITING a record; a POST route is for CREATING a new record.

#READ all people
get '/people' do
	@people = Person.all
  erb :"/people/index"
end

#CREATE a person
get '/people/new' do  
  @person = Person.new	
  erb :"/people/new"
end	

#CREATE a person
post '/people' do
  if params[:birthdate].include?("-")
    birthdate = params[:birthdate]
  else
    birthdate = Date.strptime(params[:birthdate], "%m%d%Y")
  end

  @person = Person.create(first_name: params[:first_name], last_name: params[:last_name], birthdate: params[:birthdate])
  if @person.valid?
     @person.save
    redirect "/people/#{@person.id}"
  else
    @person.errors.full_messages.each do |msg|
     @errors = "#{@errors} #{msg}."
    end
    erb :"/people/new"
  end
end  

#UPDATE/EDIT a person
get '/people/:id/edit' do
  @person = Person.find(params[:id])
  erb :"/people/edit"
end

#UPDATE/EDIT a person
put '/people/:id' do
# get the record (create a variable using an instance variable. Use the find method on the class.)
  @person = Person.find(params[:id])
# update the first_name, last_name, and birthdate of anyone in the ActiveRecord database  
  @person.update(first_name: params[:first_name], last_name: params[:last_name], birthdate: params[:birthdate])
  if @person.valid?
    @person.save
    redirect "/people/#{@person.id}"
  else
    @person.errors.full_messages.each do |msg|
      @errors = "#{@errors} #{msg}."
    end
    erb :"/people/edit"    
  end
end

#DELETE a person
delete '/people/:id' do
  @person = Person.find(params[:id])
  @person.delete
  redirect "/people"
end

get '/people/:id' do
  @person = Person.find(params[:id])
  birthdate_string = @person.birthdate.strftime("%m%d%Y")
  birth_path_num = Person.get_birth_path_num(birthdate_string)
  @message = Person.get_message(birth_path_num)	
  erb :"/people/show"
end
