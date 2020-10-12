class User < ApplicationRecord
    has_many :shifts, dependent: :destroy
    has_secure_password
    before_save :downcase_email 
    validates_uniqueness_of :email, case_sensitive: false
    validates_format_of :email, with: /@/
    attr_accessor :password


    def downcase_email
        self.email = self.email.delete(' ').downcase
    end

    def authenticate(plaintext_password)
        if BCrypt::Password.new(self.password_digest) == plaintext_password
            self
        else
            false
        end
    end
    
end
