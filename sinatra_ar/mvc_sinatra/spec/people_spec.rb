require 'spec_helper'

describe 'Our Person Class' do
  include SpecHelper

  it 'creates a Person' do
    person = Person.create(first_name: "Miss", last_name: "Piggy", birthdate: DateTime.now - 40.years )
    expect(person.present?).to be(true)
    person.delete
  end
  
end