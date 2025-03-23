class PromptSession < ApplicationRecord
  validates :system_prompt, presence: true
  validates :like_count, :dislike_count, numericality: { greater_than_or_equal_to: 0 }
  validates :uid, uniqueness: true, presence: true  
  has_many :good_feedbacks
  has_many :bad_feedbacks

  belongs_to :user  # Ensure this line exists
end
