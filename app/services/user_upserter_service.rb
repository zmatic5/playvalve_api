class UserUpserterService
  def initialize(user:, ban_status:)
    @user = user
    @ban_status = ban_status
  end

  def call
    user.ban_status = ban_status
    user.save!
    user
  end

  private

  attr_reader :user, :ban_status
end
