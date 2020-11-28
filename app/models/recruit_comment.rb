class RecruitComment < ApplicationRecord

  belongs_to :user
	belongs_to :recruit

	validates :comment, presence: true
end
