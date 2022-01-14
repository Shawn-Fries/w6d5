class User < ApplicationRecord
    #before_validation :ensure_session_token
    after_initialize :ensure_session_token

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    def self.find_by_credentials(user_name, password)
        user.find_by(username: user_name) if is_password?(password)
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64 #reset if nil
    end

    def password
        @password
    end

    def password=(password)
        self.password_digest = BCrypt::password.create(password)
        @password = password
    end

    def is_password?(password)
        password_object = BCrypt::Password.new(self.password_digest) # creates a BCrypt::Password object from the password_digest
        password_object.is_password?(password) # this is calling is_password on the BCrypt::Password Object
    end
end
