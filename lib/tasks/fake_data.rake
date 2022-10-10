
namespace :link do
  desc '建立初始資料'
  task init: :environment do
    # init user, blog, and articles
    5.times do
      u = User.create(email: Faker::Internet.email, password: 'password')
      puts "user #{u.email} created"
      20.times do
        link = u.links.create!(
          orginurl: "https://www.youtube.com/results?search_query=OnePiece #{Faker::JapaneseMedia::OnePiece.character}"
        )
        puts "links #{link.orginurl} created"
      end
    end
  end
end
