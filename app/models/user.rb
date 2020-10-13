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

    def total_tips
        totalTips = 0
        self.shifts.each do |shift|
            totalTips = totalTips + shift.pay_total.to_f 
        end
        return totalTips.round(2)
    end

    def total_shifts
        return self.shifts.count
    end

    def average_tips_per_shift
        return (total_tips/total_shifts).round(2)
    end

    def average_tips_per_night
        totalTips = 0
        nightShifts = 0
        self.shifts.each do |shift|
            if shift.shift_type == "night"
                nightShifts = nightShifts + 1
                totalTips = totalTips + shift.pay_total.to_f 
            end
        end
        return (totalTips/nightShifts).round(2)
    end

    def average_tips_per_day
        totalTips = 0
        dayShifts = 0
        self.shifts.each do |shift|
            if shift.shift_type == "day"
                dayShifts = dayShifts + 1
                totalTips = totalTips + shift.pay_total.to_f 
            end
        end
        return (totalTips/dayShifts).round(2)
    end




    
end
