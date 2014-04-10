class ClientPolicy
  attr_reader :user, :client

  def initialize(user, client)
    @user = user
    @client = client
  end

  def destroy?
    user.is_admin?
  end

end

