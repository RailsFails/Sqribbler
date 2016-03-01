class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :image, polymorphic: true
  belongs_to :comment, polymorphic: true
  belongs_to :album, polymorphic: true

  validates :item_type, :item_id, :presence => true
  validates :item_id, :uniqueness => { :scope => [:user_id, :item_type] }
  validates_inclusion_of :value, in: [-1, 1]
end
