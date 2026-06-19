class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_mamy :family_members, dependent: :destroy
  has_mamy :families, through: :family_members

  validates :name,       presence: true
  validates :tel_number, presence: true, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
