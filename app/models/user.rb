class User < ApplicationRecord
  has_secure_password
  has_secure_token :token
  belongs_to :account

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :invoices, dependent: :destroy
  has_many :access_keys, dependent: :destroy
  has_many :shifts, dependent: :destroy
  # has_many :user_branches
  # has_many :branches
  validates :email, :first_name, :last_name, presence: true
  validates :email, format: /@/, uniqueness: true
  # after_create :generate_new_access_key
end
