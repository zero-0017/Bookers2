class Book < ApplicationRecord
  belongs_to :user

  validates :title, presence: true# titleが空ではないことを確認
  validates :body, presence: true,# bodyが空ではないことを確認
  length: { maximum: 200 }#length = 文字数の制限を設定　#maximum = 文字数の下限を200文字に設定
end