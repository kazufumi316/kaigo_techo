class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :care_records, dependent: :destroy
  has_many :family_members, dependent: :destroy
  has_many :families, through: :family_members
  has_many :care_users, through: :families

  validates :name,       presence: true
  validates :tel_number, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
