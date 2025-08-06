class Entry < ActiveRecord::Base
  belongs_to :child
  belongs_to :milestone

  validates :date, presence: true
  validates :note, presence: true
  validates :age_months, presence: true
  validates :child_id, presence: true
  validates :milestone_id, presence: true
end
