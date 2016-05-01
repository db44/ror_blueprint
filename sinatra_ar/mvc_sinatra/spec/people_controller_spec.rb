require 'spec_helper'

describe "Our Person Controller" do
  include SpecHelper

  before (:all) do
    @person = Person.create(first_name: "Miss", last_name: "Piggy", birthdate: DateTime.now - 40.years )
  end
  
  after (:all) do
    @person.delete
  end
  
  it "displays a link to a person's show page on the index view" do
    get("/people")
    expect(last_response.body.include?("/people/#{@person.id}")).to be(true)
  end
    
  it 'responds with a view titled "People" when we visit /people' do
    get('/people')
    expect(last_response.body.include?("People")).to be(true)
  end
  
  it "displays a page with the person's name when we visit /people/:id" do
    get("/people/#{@person.id}")
    expect(last_response.body.include?("#{@person.first_name} #{@person.last_name}")).to be(true)
  end  
end