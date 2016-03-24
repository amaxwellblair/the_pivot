class Item < ActiveRecord::Base
  has_many :category_items, dependent: :destroy
  has_many :categories, through: :category_items
  has_many :line_items, dependent: :destroy
  has_many :orders, through: :line_items

  belongs_to :store

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :categories, presence: true
  has_attached_file :image,
    default_url: "default.png",
    path: ":url",
    url: "/:filename"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def self.find_gold
    find_by(title: "Pot O' Gold").id
  end

  def self.find_sunshine
    find_by(title: "Four-Leaf Clover").id
  end

  def self.find_leprechaun
    find_by(title: "Uncatchable Leprechaun").id
  end
end
