class Milestone < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  has_many :children, through: :entries

  validates :title, presence: true, uniqueness: true
  validates :milestone_type, presence: true
end
