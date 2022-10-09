# == Schema Information
#
# Table name: links
#
#  id         :bigint           not null, primary key
#  click      :integer
#  deleted_at :datetime
#  orginurl   :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_links_on_deleted_at  (deleted_at)
#  index_links_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Link, type: :model do
  
end
