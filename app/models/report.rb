class Report < ActiveRecord::Base
  belongs_to :user, polymorphic: true
  belongs_to :album, polymorphic: true
  belongs_to :image, polymorphic: true
  belongs_to :comment, polymorphic: true

  def reporter
    if self.user_id.nil?
      return nil
    else
      return User.find(self.user_id)
    end
  end
end
