class RecruitComment < ApplicationRecord

  belongs_to :user
	belongs_to :recruit
	has_many :notifications, dependent: :destroy
	validates :comment, presence: true
end
