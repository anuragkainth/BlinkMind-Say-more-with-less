class User < ApplicationRecord
    has_secure_password
    # Enable file uploads for profile_pic using Active Storage
    has_one_attached :profile_pic
    
    after_commit :add_default_profile_pic, on: %i[create update]

    # Virtual attribute for the token
    attr_accessor :reset_token

    # Generates a new reset token and saves its digest and timestamp to the database.
    def create_reset_digest
      self.reset_token = SecureRandom.urlsafe_base64
      update_columns(reset_digest: BCrypt::Password.create(reset_token),
                    reset_sent_at: Time.zone.now)
    end

    # Sends the password reset email.
    def send_password_reset_email
      UserMailer.password_reset(self).deliver_now
    end

    # Checks if the password reset request has expired (e.g., after 2 hours).
    def password_reset_expired?
      reset_sent_at < 2.hours.ago
    end

    def add_default_profile_pic
      unless profile_pic.attached?
        profile_pic.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default_profile.png')), filename: 'default_profile.png', content_type: 'image/png')
      end
    end

    # Posts
    has_many :posts, dependent: :destroy

    has_many :likes, dependent: :destroy

    # Friendships where the user initiated the request
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships
    
    # Friendships where the user received the request
    has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy
    has_many :inverse_friends, through: :inverse_friendships, source: :user
  
    # Returns all confirmed friends (both directions)
    def all_friends
      sent = friendships.where(status: "accepted").map(&:friend)
      received = inverse_friendships.where(status: "accepted").map(&:user)
      sent + received
    end
  
    # Pending friend requests received by the user
    def pending_friend_requests
      inverse_friendships.where(status: "pending")
    end
  
    # Friend requests sent by the user (still pending)
    def sent_friend_requests
      friendships.where(status: "pending")
    end
  
    validates :email, presence: true, uniqueness: true
  end
  