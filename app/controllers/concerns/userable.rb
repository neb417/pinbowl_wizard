module Userable
  extend ActiveSupport::Concern
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.expect(user: [ :first_name, :last_name, :email_address, :password, :password_confirmation ])
  end
end
