class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :display,
                       resize_to_limit: [Settings.size.img.size_500,
Settings.size.img.size_500]
  end

  validates :content, presence: true,
length: {maximum: Settings.digit.digit_140}
  validates :image, content_type: {in: %w(image/jpeg image/gif image/png)},
                    size: {less_than: Settings.size.img.mb_5.megabytes}

  scope :newest, ->{order created_at: :desc}
end
