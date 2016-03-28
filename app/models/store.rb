class Store < ActiveRecord::Base
  has_many :items, dependent: :destroy
  belongs_to :user

  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: true

  before_validation :generate_slug

  enum status: %w(pending suspended approved)

  def generate_slug
    self.slug = name.parameterize if name
  end
end
