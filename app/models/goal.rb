class Goal < ActiveRecord::Base
  attr_accessible :name, :user_id, :is_private

  belongs_to :user



end
