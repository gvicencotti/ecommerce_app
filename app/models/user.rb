class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :products, dependent: :destroy

  ROLES = %w[regular admin vendor].freeze
  validates :role, inclusion: { in: ROLES }

  before_validation :set_default_role, if: :new_record?

  def admin?
    role == "admin"
  end

  def vendor?
    role == "vendor"
  end

  def regular?
    role == "regular"
  end

  private

  def set_default_role
    self.role ||= "regular"
  end
end
