# == Schema Information
#
# Table name: links
#
#  id         :bigint           not null, primary key
#  click      :integer
#  orginurl   :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
FactoryBot.define do
  factory :link do
    user { nil }
    orginurl { "https://www.google.com/search?q=#{Faker::Movies::HarryPotter.character}" }
  end
end
