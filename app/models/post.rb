# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Post < ApplicationRecord
end
