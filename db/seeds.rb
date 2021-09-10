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

@res = @user.user_resources.create(name: 'file', desc: 'eleven', created_at: "2021-09-06 11:42:29.946328")
@res.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'file.jpg')
@res.save
@res = @user.user_resources.create(name: 'file2', desc: 'twelve', created_at: "2021-09-05 11:42:29.946328")
@res.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'file.jpg')
@res.save
@res = @user.user_resources.create(name: 'file3', desc: 'yeah', created_at: "2021-09-04 11:42:29.946328")
@res.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'file.jpg')
@res.save
@res = @user.user_resources.create(name: 'file4', desc: 'thast', created_at: "2021-09-03 11:42:29.946328")
@res.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'file.jpg')
@res.save
@res = @user.user_resources.create(name: 'file5', desc: 'asfn', created_at: "2021-09-02 11:42:29.946328")
@res.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'file.jpg')
@res.save
@res = @user.user_resources.create(name: 'file6', desc: 'com', created_at: "2021-09-01 11:42:29.946328")
@res.file.attach(io: File.open('app/assets/images/lost.jpg'), filename: 'file.jpg')
@res.save
@res = @user.user_resources.create(name: 'file7', desc: 'cool', created_at: "2021-08-15 11:42:29.946328")
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
