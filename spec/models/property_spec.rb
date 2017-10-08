require 'rails_helper'

RSpec.describe Property, type: :model do
  context "teste" do
  	it "teste" do
  		property = Property.new
  		

  		expect(property.valid?).to be_truthy
  	end
  end
end
