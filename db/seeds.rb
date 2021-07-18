# frozen_string_literal: true

@user = User.create(username: 'note', email: 'note@mail.com', password_digest: '123456789asdfghxA')
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
