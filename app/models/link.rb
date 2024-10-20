class Link < ApplicationRecord
  belongs_to :user
  # URL形式のバリデーションを追加
  validates :link_name, length: { maximum: 20 }
  validates :link_url, allow_blank: true, format: {
    with: /\Ahttps?:\/\/(?:www\.)?[^\/\s]+\S*\z/,
    message: 'の形式が正しくありません'
  }
  validates :link_order, presence: true
end
