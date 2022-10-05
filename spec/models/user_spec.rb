require 'rails_helper'

RSpec.describe User, type: :model do
  subject { 
    described_class.new(password: "some_password",
                        email: "john@doe.com")}

  
  context "when user create" do 
    it "create user " do 
      expect(subject).to eq(User.last)
    end
  end 
end
