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

    def total_hours
        totalHours = 0
        self.shifts.each do |shift|
            totalHours = totalHours + shift.shift_hours.to_f.round(1)
        end
        return totalHours
    end

    def average_tips_per_shift
        if total_shifts == 0 
            return 0
        end
        return (total_tips/total_shifts).round(2)
    end

    def average_tips_per_night
        totalTips = 0
        nightShifts = 0
        if total_shifts == 0 
            return 0
        end
        self.shifts.each do |shift|
            if shift.shift_type == "night"
                nightShifts = nightShifts + 1
                totalTips = totalTips + shift.pay_total.to_f 
            end
        end
        if nightShifts == 0 
            return 0
        end
        return (totalTips/nightShifts).round(2)
    end

    def average_tips_per_day
        totalTips = 0
        dayShifts = 0
        if total_shifts == 0 
            return 0
        end
        self.shifts.each do |shift|
            if shift.shift_type == "day"
                dayShifts = dayShifts + 1
                totalTips = totalTips + shift.pay_total.to_f 
            end
        end
        if dayShifts == 0 
            return 0
        end
        return (totalTips/dayShifts).round(2)
    end

    def best_shift
        bestShift = 0
        if total_shifts == 0 
            return 0
        end
        self.shifts.each do |shift|
            if bestShift < shift.pay_total.to_f.round(2)
                bestShift = shift.pay_total.to_f.round(2)
            end
        end
        return bestShift
    end

    def worst_shift
        if total_shifts == 0 
            return 0
        end
        worstShift = self.shifts.first.pay_total.to_f.round(2)
        self.shifts.each do |shift|
            if worstShift > shift.pay_total.to_f.round(2)
                worstShift = shift.pay_total.to_f.round(2)
            end
        end
        return worstShift
    end

    def average_per_hour
        if total_shifts == 0 
            return 0
        end
        return (total_tips/total_hours).round(2)
    end

    def average_per_hour_at_night
        if total_shifts == 0 
            return 0
        end
        nightTips = 0
        nightHours = 0
        self.shifts.each do |shift|
            if shift.shift_type == "night"
                nightHours = nightHours + shift.shift_hours.to_f.round(1)
                nightTips = nightTips + shift.pay_total.to_f 
            end
        end
        if nightHours == 0 
            return 0
        end
        return (nightTips/nightHours).round(2)
    end

    def average_per_hour_at_day
        if total_shifts == 0 
            return 0
        end
        dayTips = 0
        dayHours = 0
        self.shifts.each do |shift|
            if shift.shift_type == "day"
                dayHours = dayHours + shift.shift_hours.to_f.round(1)
                dayTips = dayTips + shift.pay_total.to_f 
            end
        end
        if dayHours == 0 
            return 0
        end
        return (dayTips/dayHours).round(2)
    end
    
end
