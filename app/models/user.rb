class User < ApplicationRecord
  has_secure_password
  has_many :patients

  validates :email, presence: true, uniqueness: true
  validates :password, length: {minimum:8, maximum:16}, allow_nil: true, presence: true
  validates :role, inclusion: { in: %w(receptionist doctor) }

end
