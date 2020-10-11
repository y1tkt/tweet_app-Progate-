# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
end
