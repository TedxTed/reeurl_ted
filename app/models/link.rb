# == Schema Information
#
# Table name: links
#
#  id         :bigint           not null, primary key
#  click      :integer
#  orginurl   :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null

class Link < ApplicationRecord
  after_create :process_slug
  belongs_to :user

  validates :orginurl, presence: true

  private
  def process_slug
    update(slug:  Digest::CRC32.hexdigest("#{id}") )
  end
end
