class User < ApplicationRecord
    validates :fullName, presence: true
end
