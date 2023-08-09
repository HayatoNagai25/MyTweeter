class Customer < ApplicationRecord
    has_many :tweets
    has_many :relationships, foreign_key: "follower_id", dependent: :destroy
    has_many :followed_users, through: :relationships, source: :followed
    has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
    has_many :followers, through: :reverse_relationships, source: :follower
    
    has_secure_password

    validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "must be a valid email address" }

    def feed
        Micropost.from_customers_followed_by(self)
    end
    
    def following?(other_customer)
        relationships.find_by(followed_id: other_customer.id)
    end
    
    def follow!(other_customer)
        relationships.create!(followed_id: other_customer.id)
    end
    
    def unfollow!(other_customer)
        relationships.find_by(followed_id: other_customer.id).destroy
    end
    
    private
    
        def create_remember_token
          self.remember_token = Customer.digest(Customer.new_remember_token)
        end
    end