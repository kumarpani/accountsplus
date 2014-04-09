class QuotationPolicy
  attr_reader :user, :quotation

  def initialize(user, quotation)
    @user = user
    @quotation = quotation
  end

  def edit?
    false
  end

  def destroy?
    user.is_admin?
  end

end

