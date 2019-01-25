class Book < ApplicationRecord

	belongs_to :user

	validates :body, length: { maximum: 200 } # 「200文字以上」
  	validates :title, :body, presence: true #空でない事


end
