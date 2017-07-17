require 'bundler/setup'
Bundler.require

if development?
  ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
end

class Management < ActiveRecord::Base
end

class User < ActiveRecord::Base
    has_secure_password
    validates :username,
        length: {in: 5..20}
    validates :mail,
        presence: true,
        format: {with:/.+@.+/}
    validates :password,
        length: {in: 5..12}

    has_many :homeworks
    has_many :records
end

class Homework < ActiveRecord::Base
    belongs_to :category
    belongs_to :user
    has_many :records
end

class Record < ActiveRecord::Base
    belongs_to :user
    belongs_to :homework
end

class Category < ActiveRecord::Base
    has_many :homeworks
end
