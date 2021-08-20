# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.create(username: 'note', email: 'note@mail.com', password: '123456789asdfghxA', email_confirmed: true, confirm_token: nil)
@res = @user.user_resources.create(name: 'file', desc: 'eleven')
Tag.create(name: "Images")
Tag.create(name: "Sound")
Tag.create(name: "File")
Tag.create(name: "Game")
Tag.create(name: "Listing")
Tag.create(name: "Find")
#@res.file.attach(io: File.open('/path/to/file'), filename: 'file.jpg')

@res.tags = Tag.all
@res.save
