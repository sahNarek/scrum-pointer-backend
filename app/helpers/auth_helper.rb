module AuthHelper
  def crypt
    ActiveSupport::MessageEncryptor.new(
      Rails.application.secrets.secret_key_base.byteslice(0..31)
    )
  end

  def user_sign_in(email, password)
    user = User.find_by(email: email)
    unless user.nil? && user.authenticate(password)
      token = crypt.encrypt_and_sign("user-id#{user.id}")
    end
    {user: user, token: token}
  end

  def find_user_by_token(token)
    unless token.blank?
      user_id = crypt.decrypt_and_verify(token).gsub('user-id', '').to_i
      User.find(user_id)
    end
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      nil
  end

  module_function :crypt, :find_user_by_token, :user_sign_in
end