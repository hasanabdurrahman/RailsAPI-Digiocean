# app/lib/json_web_token.rb
class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, secret_key)
    end

    def decode(token)
      body = JWT.decode(token, secret_key)[0]
      HashWithIndifferentAccess.new(body)
    rescue JWT::ExpiredSignature => e
      # biar pesan expired muncul sesuai ekspektasi spec
      raise ExceptionHandler::InvalidToken, e.message
    rescue JWT::DecodeError => e
      raise ExceptionHandler::InvalidToken, e.message
    end

    private

    def secret_key
      # Rails 5.2+ pakai credentials; fallback ke secret_key_base
      Rails.application.secret_key_base ||
        Rails.application.credentials.secret_key_base
    end
  end
end
