class PaymentPolicy
  attr_reader :user, :payment

  def initialize(user, payment)
    @user = user
    @payment = payment
  end

  #def index?
  #  false
  #end
  #
  #def show?
  #  scope.where(:id => record.id).exists?
  #end
  #
  #def create?
  #  false
  #end
  #
  #def new?
  #  create?
  #end

  def update?
    user.is_admin?
  end

  def edit?
    user.is_admin?
  end

  def destroy?
    user.is_admin?
  end

  #def scope
  #  Pundit.policy_scope!(user, payment.class)
  #end
end

