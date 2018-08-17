class Hunt
  include Mongoid::Document

  field :title, type: String
  field :datetime, type: Time
  field :duration, type: Integer
  field :end_datetime, type: Time

  field :max_hunter, type: Integer
  field :full, type: Boolean, default:false
  field :platform, type: String
  field :description, type: String

  field :sid, type: String

  field :voice_chat, type: String
  field :lang, type: String
  field :mic, type: Boolean, default: false

  #Associations
  belongs_to :leader, class_name: "User", inverse_of: :hunts_as_leader
  has_and_belongs_to_many :hunters, class_name: "User", inverse_of: :hunts_joined

  #Validations
  validates :title, presence: true, length: {within: 6..50}
  validates :datetime, presence: true
  validates_inclusion_of :duration, :in => 1..24
  validates_inclusion_of :max_hunter, :in => 2..16
  validates_inclusion_of :platform, :in => %w(xbox ps4 pc)
  validates :description, length: {within: 15..500}, allow_nil: true, allow_blank: true
  validates :sid, presence: true, length: { is: 12 }, allow_nil: true
  validates :voice_chat, length: {within: 5..30}, allow_nil: true, allow_blank: true
  validates_inclusion_of :lang, :in => %w(fra eng spa deu ita pol rus jpn zho kor por ara), allow_nil: true, allow_blank: true
  validates :hunters, hunter_list: true

  #Scopes
  scope :available, -> { where(:end_datetime.gt => (Time.current + 45 * 60)) }
  scope :in_progress, -> { where(:end_datetime.gt => (Time.current + 45 * 60), :datetime.lt => (Time.current) ) }
  scope :on_coming, -> { where(:datetime.gt => (Time.current)) }
  scope :finished, -> { where(:end_datetime.lt => (Time.current)) }
  scope :sort_by_asc_datetime, -> { order_by(datetime: :asc) }
  scope :with_free_slot, -> { where(:full => false) }

  #Callbacks
  before_update :update_hunt_full, on: [:leave, :join]

  def duration= value
    write_attribute(:duration, value)
    return if self.duration.blank?
    if self.datetime.present?
      end_datetime = self.datetime + (self.duration * 60 * 60)
      write_attribute(:end_datetime, end_datetime)
    end
  end

  def lang= value
    write_attribute(:lang, value) unless self.voice_chat.blank?
  end

  def mic= value
    write_attribute(:mic, value) unless self.voice_chat.blank?
  end

  def update_hunt_full
    p 'coucou'
    (self.hunters.size + 1) >= self.max_hunter ? self.full = true : self.full = false
  end
end
