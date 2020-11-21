class User < ApplicationRecord
    has_secure_password
  validates :name, {uniqueness: true}
  validates :email, {uniqueness: true}
  validates :password_digest, {presence: true}

  def post
    return Post.where(user_id: self.id)
  end


end
