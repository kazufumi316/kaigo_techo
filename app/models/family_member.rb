class FamilyMember < ApplicationRecord
  belongs_to :user
  belongs_to :family

  enum role: { main: 0, family: 1 }
end