class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar
    has_one_attached :contract
    has_one_attached :document
end
