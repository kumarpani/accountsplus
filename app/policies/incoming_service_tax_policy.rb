class IncomingServiceTaxPolicy
  attr_reader :user, :incoming_service_tax

  def initialize(user, incoming_service_tax)
    @user = user
    @incoming_service_tax = incoming_service_tax
  end

  def update?
    user.is_admin?
  end

  def edit?
    user.is_admin?
  end

  def destroy?
    user.is_admin?
  end

end

