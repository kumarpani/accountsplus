class BackupPolicy
  attr_reader :user, :backup

  def initialize(user, backup)
    @user = user
    @backup = backup
  end

  def backup_data?
    user.is_admin?
  end

end

