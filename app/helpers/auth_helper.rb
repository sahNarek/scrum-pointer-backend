module AuthHelper

  SECRET_KEY = Rails.application.credentials.secret_key_base.freeze

  def user_sign_in(email, password)
    user = User.find_by(email: email)
    errors = []
    if user.present? && user.authenticate(password)
      begin
        exp_time = Time.now + 24.hours
        payload = {
          user_id: user.id,
          exp_time: exp_time
        }
        token = JWT.encode payload, SECRET_KEY, 'HS256'
        {user: user, token: token, exp_time: exp_time.strftime("%m-%d-%Y %H:%M"), errors: errors}
      rescue JWT::EncodingError => e
        errors << e.message
        {user: user, token: nil, exp_time: nil, errors: errors}
      end
    else
      errors << I18n.t('wrong_credentials')
      {user: user, token: nil, exp_time: nil, errors: errors}
    end
  end

  def find_user_by_token(token)
    return if token.blank?
    begin 
      payload = JWT.decode token, SECRET_KEY, true, algorithm: 'HS256'
      user_id = payload.first["user_id"]
      exp_time = payload.first["exp_time"]
      User.find(user_id) if exp_time >= Time.now
    rescue JWT::DecodeError
      nil
    end
  end

  module_function :find_user_by_token, :user_sign_in
end