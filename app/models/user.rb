class User < ActiveRecord::Base
  rolify
	has_and_belongs_to_many :matiere
	has_and_belongs_to_many :epreuve
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :default_role

  private
  def default_role
    self.roles << Role.where(:name => 'pending').first
  end

end
