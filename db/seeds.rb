# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

    puts "Destroying Old Seed Data..."
    User.destroy_all
    Shift.destroy_all

    puts 'Creating Users...'
    puts 'Creating Shifts...'
    user1 = User.create(name: 'Gene', email: "demo@gmail.com" , password_digest: BCrypt::Password.create("123"))
    Shift.create(user_id: user1.id, employment_place: 'MadLife Stage and Studio', shift_date: "10/2/20", shift_type: 'night', shift_hours: '4.3', pay_total: '102.34')
    Shift.create(user_id: user1.id, employment_place: 'MadLife Stage and Studio', shift_date: "10/3/20", shift_type: 'day', shift_hours: '8', pay_total: '190')
    Shift.create(user_id: user1.id, employment_place: 'MadLife Stage and Studio', shift_date: "10/5/20", shift_type: 'day', shift_hours: '8', pay_total: '111')
    Shift.create(user_id: user1.id, employment_place: 'MadLife Stage and Studio', shift_date: "10/6/20", shift_type: 'night', shift_hours: '8', pay_total: '87')
    Shift.create(user_id: user1.id, employment_place: 'MadLife Stage and Studio', shift_date: "10/8/20", shift_type: 'day', shift_hours: '8', pay_total: '34')
