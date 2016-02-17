class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :image, polymorphic: true
  belongs_to :comment, polymorphic: true

  validates :item_type, :item_id, :presence => true
  validates :user_id, :uniqueness => { :scope => [:item_type, :item_id] }
  validates :value, presence: :true, inclusion: [-1, 1]
end
