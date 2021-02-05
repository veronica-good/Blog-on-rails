class User < ApplicationRecord
    has_secure_password
    has_many :posts, dependent: :nullify
    has_many :comments, dependent: :nullify
    VALID_EMAIL= /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL}
end
