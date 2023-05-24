class User < ApplicationRecord
  validates_presence_of :name,
                        :email,
                        :password_digest
  validates_presence_of :password, confirmation: {case_sensitive: true}
  validates_uniqueness_of :email

  has_many :party_users
  has_many :parties, through: :party_users

  has_secure_password

  # def name_and_email
  #   "#{name} (#{email})"
  # end
end