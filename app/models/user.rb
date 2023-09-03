class User < ApplicationRecord
    include RatingAverage

    has_secure_password

    validates :username, uniqueness: true, length: {minimum: 3, maximum: 30}
    validates :password, length: { minimum: 4 }
    validate :password_complexity
  
    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
  
    private
  
    def password_complexity
      if password.present? && !password.match(/^(?=.*[A-Z])(?=.*\d)/)
        errors.add(:password, "must contain at least one uppercase letter and one number")
      end
    end
  end
