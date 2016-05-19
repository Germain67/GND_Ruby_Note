class User < ActiveRecord::Base
  rolify
	has_and_belongs_to_many :matiere
	has_many :notations
  has_many :epreuves, :through => :notations
  attr_accessor :nom_role
  attr_reader :raw_invitation_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :default_role

  private
  def default_role
    #self.roles << Role.where(:name => 'pending').first
    self.add_role "pending"
  end

end
