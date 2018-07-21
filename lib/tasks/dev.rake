namespace :dev do
  # 定義一個會引入目前rails專案環境的\":fake\" task
  task :fake => :environment do
    # 先清掉所有資料
    Restaurant.destroy_all

    30.times do |i|
      # "create" : 中途有錯不會停下來，待流程結束後由使用者自行判斷資料是否正常產生
      # "create!" : 中途有錯馬上停下來
      Restaurant.create!(
        # name: "restaurant#{i.to_s}", 
        # opening_hours: "7:00", 
        # tel: "2792-7818#1016", 
        # address: "Taipei City 101", 
        # description: "Tempor amet aute commodo tempor."

        # 以下改用"FFaker"做假資料
        name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph
      )
    end
  end  
end
