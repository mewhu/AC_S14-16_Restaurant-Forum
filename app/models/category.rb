class Category < ApplicationRecord
  # 補加上dependent: :destroy --> 使rails在砍掉分類時，會先把該分類旗下的餐廳砍完
  # PS : 還有其它作法，例如改在restaurant.rb上在belongs_to後頭補上"optional: true" --> 代表對restaurant而言，沒有category_id也無彷
  # PS : 或是研究 "delegate" 的功能
  has_many :restaurants, dependent: :destroy
  # 以下from "ihower實戰聖經"
  # 其中:dependent可以有幾種不同的處理方式，例如：
  # :destroy 把依賴的attendees也一併刪除，並且執行Attendee的destroy回呼
  # :delete 把依賴的attendees也一併刪除，但不執行Attendee的destroy回呼
  # :nullify 這是預設值，不會幫忙刪除attendees，但會把attendees的外部鍵event_id都設成NULL
  # :restrict_with_exception 如果有任何依賴的attendees資料，則連event都不允許刪除。執行刪除時會丟出錯誤例外ActiveRecord::DeleteRestrictionError。
  # :restrict_with_error 不允許刪除。執行刪除時會回傳false，在@event.errors中會留有錯誤訊息。

  validates_presence_of :name
end
