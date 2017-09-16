class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         #:registerable,
         :recoverable,
         #:rememberable, :trackable,
         :validatable,
         :timeoutable

  validates_presence_of :first_name


  def timeout_in
    30.minutes
  end

  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  def self.current_user
    Thread.current[:current_user]
  end

  def is_admin?
    role == 'ADMIN'
  end

end
