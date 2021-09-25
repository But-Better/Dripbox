# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.create(username: 'note', email: 'note@mail.com', password: '123456789asdfghxA', email_confirmed: true,
                    confirm_token: nil)

@res = @user.user_resources.new(name: 'file', desc: 'eleven', created_at: '2021-09-06 11:42:29.946328')
@res.file.attach(io: File.open('app/assets/images/placeholder.svg'), filename: 'file.jpg')
@res.save

5.times do |i|
  @res = @user.user_resources.new(name: Faker::Beer.name, desc: Faker::Lorem.sentence(word_count: 20),
                                  created_at: "2021-09-#{i} 11:42:29.946328")
  @res.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: "#{Faker::File.name}.jpg")
  @res.save
end
@res = @user.user_resources.new(name: 'file7', desc: 'cool', created_at: '2021-08-15 11:42:29.946328')
@res.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'file.jpg')
@res.save

Tag.create(name: 'Images')
Tag.create(name: 'Sound')
Tag.create(name: 'File')
Tag.create(name: 'Game')
Tag.create(name: 'Listing')
Tag.create(name: 'Find')
# @res.file.attach(io: File.open('/path/to/file'), filename: 'file.jpg')

@res.tags = Tag.all
@res.save

User.create(username: 'Peter', email: 'Enis@mail.com', password: 'Admin123', email_confirmed: true,
            confirm_token: nil, contact_status: true)

User.create(username: 'Admin', email: 'Admin@Admin.admin', password: 'Admin123', email_confirmed: true,
            confirm_token: nil, contact_status: true)

20.times do
  Contact.create(name: Faker::Name.name, email: Faker::Internet.email, message: Faker::Lorem.sentence(word_count: 20))
end
