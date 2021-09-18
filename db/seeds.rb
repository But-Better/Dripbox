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

@res = @user.user_resources.create(name: 'file', desc: 'eleven')
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

Contact.create(name: 'Peter', email: 'Peter@Peter.de', message: 'opandasd0o312kd<%$&$§/§""')
Contact.create(name: 'Joachim', email: 'Joachim@Lol.com', message: 'Wir möchten Urgot buffen')
Contact.create(name: 'Uwe', email: 'Uwe-ewU@Toaster.org', message: 'Toaster Toaster Toaster Toaster kennen Sie schon denn Toaster')
Contact.create(name: 'Robin', email: 'WeMake@A.hood', message: '5 Gold auf dem Polenmarkt gefunden')
Contact.create(name: 'Peter Zwegar', email: 'Make@RTL.real', message: 'Wollen Sie nicht eine Staffe RTL folgen nur für 400€ machen !!!')
