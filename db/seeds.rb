# frozen_string_literal: true

@user = User.create(username: 'note')
@res = @user.user_resources.create(name: 'file', desc: 'eleven')
Tag.create(name: "Images")
Tag.create(name: "Sound")
Tag.create(name: "File")
Tag.create(name: "Game")
Tag.create(name: "Listing")
Tag.create(name: "Find")
