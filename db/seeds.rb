# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FileResource.create(name: 'image',
                    url: 'https://raw.githubusercontent.com/Ktechen/Dripbox/feature/MainPage/app/assets/images/desktop-1245714_1920.jpg',
                    desc: 'test this stuff out',
                    user_id: 0,
                    upload: '31-05-2021')
Category.create(title: 'Images', desc: 'files in this category are just images', img_url: 'https://github.com/Ktechen/Dripbox/raw/feature/dashboard/app/assets/images/category_background_images/Images/background.jpg')
FileResourceCategoryRelation.create(file_resource_id: 1, category_id: 1)

User.create(username: 'Kevin',
            email: 'test@email.de',
            password_digest: '1234')
