class Child < ActiveRecord::Base
  has_many :entries, dependent: :destroy
  has_many :milestones, through: :entries

  validates :name, presence: true
  validates :birthdate, presence: true
end
