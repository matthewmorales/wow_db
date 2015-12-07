class Character < ActiveRecord::Base
	belongs_to :guild
	belongs_to :armor
	belongs_to :tabard
	belongs_to :mainhand
	belongs_to :offhand
	has_one :stat
end
