class User < ApplicationRecord
  # keep the default scope first (if any)
  default_scope { where(active: true) }

  # constants come up next
  COLORS = %w(red green blue)

  # afterwards we put attr related macros
  attr_reader :read_only
  attr_writer :write_only
  attr_accessor :formatted_date_of_birth

  # Rails4+ enums after attr macros, prefer the hash syntax
  enum gender: { female: 0, male: 1 }
  store_accessor :jsonb, :config_a, :config_b

  delegate :name, to: :organization, prefix: true

  # followed by association macros
  belongs_to :organization
  has_one :something
  has_many :articles

  has_attached_file :avatar

  composed_of: :component

  accepts_nested_attributes_for :organization

  # and validation macros
  validates :email, presence: true

  # next we have callbacks
  after_initialize :after_initialize
  after_find :after_find
  after_touch :after_touch

  before_validation :before_validation
  before_create :before_create
  before_update :before_update
  before_save :before_save
  before_destroy :before_destroy

  after_validation :after_validation
  after_create :after_create
  after_update :after_update
  after_save :after_save
  after_destroy :after_destroy
  after_commit :after_commit
  after_rollback :after_rollback

  around_create :around_create
  around_update :around_update
  around_save :around_save
  around_destroy :around_destroy

  # other macros (like devise's) should be placed after the callbacks
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  geocoded_by :delivery_address
  multisearchable against: %i[full_name organization_name phone_number email id]

  # next we have scopes
  scope :active, -> { where(active: true) }

  def self.class_method
  end

  def instance_method
  end

  protected

    def protected_method
    end

  private

    def private_method
    end

  #...
end
