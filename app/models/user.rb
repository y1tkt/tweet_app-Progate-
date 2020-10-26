# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  image_name      :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  account_id      :string(255)
#
class User < ApplicationRecord
  has_secure_password

  validates :name,
    presence: true,
    length: { maximum: 20 }
  validates :email,
    presence: true,
    uniqueness: true
  validates :account_id,
    presence: true,
    uniqueness: true,
    length: { maximum: 16 },
    format: {
      with: /\A@\w+\z/,
      message: 'は英数字で入力してください。使える記号はアンダースコア(_)のみです。'
    }
  validates :password,
    length: { minimum: 8 }

  def posts
    return Post.where(user_id: self.id)
  end
end
