# Dripbox

Dropbox-like Web-Service
by the "but-better"-Group

Heroku: https://dripbox.herokuapp.com/

created with "rails new" on an Arch Linux System

* Ruby version
    - ruby 3.0.2p64

* System dependencies
    - fresh installation
    - postgresql - version : 13.3
    - node - version :  v10.24.0
    - yarn - version : 1.22.10
    - rails - version : Rails 6.1.3.1


* Configuration
    - docker must be installed and in a workable state
    - for the "bundle" command to work, the local postgresql client must be installed
    - for the storage blob to work, you either need to add a .env file with the needed

      configurations or set the storage option of file in app/models/user_resource.rb to "local"
      - (env names found in config/storage.yml)


* Database creation (database runs over docker)
    - ```./scripts/debian-base/run_local_docker.sh```

    - (for the runner script to work,
        docker must be installed and in a workable state)


* Database initialization
    - rails db:prepare


* How to run the test suite
    - rails t


* Services (job queues, cache servers, search engines, etc.)
    - docker
    - postgresql


* Deployment instructions
    - rails s


