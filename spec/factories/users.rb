# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null

require 'faker'
FactoryBot.define do
  factory :user do
    email 
    password {"password"}
    
  end
  sequence :email do |n|
    "#{n}-#{Faker::Internet.email}"
  end
end
