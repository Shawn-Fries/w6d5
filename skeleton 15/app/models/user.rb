class User < ApplicationRecord
    #before_validation :ensure_session_token
    after_initialize :ensure_session_token

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    def reset_session_token!
        self.session_token ||= SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def password
        @password
    end

    def password=(password)
        self.password_digest = BCrypt::password.create(password)
        @password = password
    end
end
