class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable, :trackable, :validatable

  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  def self.current_user
    Thread.current[:current_user]
  end

end
