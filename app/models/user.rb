class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ##Fields
  field :username, type: String
  ## Database authenticatable
  field :email, type: String
  field :encrypted_password, type: String
  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time
  ## Rememberable
  field :remember_created_at, type: Time
  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String
  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  #Associations
  has_many :hunts_as_leader, class_name: "Hunt", foreign_key: "leader_id", dependent: :destroy
  has_and_belongs_to_many :hunts_joined, class_name: "Hunt",inverse_of: :hunters
  #Validations
  validates :username, presence: true, uniqueness: true, length: {within: 3..20}
  validates :email, presence: true
  validates :password, presence: true, confirmation: true, length: {within: 6..30}, if: :password_required?
  validates :hunts_joined, hunt_list: true

  def already_joined?(hunt)
    self.hunts_joined.available.include?(hunt)
  end
end
