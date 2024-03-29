module Tools
  def generate_aid(model, column)
    loop do
      aid = ('a'..'z').to_a.concat(('0'..'9').to_a).shuffle[1..17].join
      if !model.exists?(column.to_sym => aid)
        return aid
        break
      end
    end
  end
  def generate_rsa_key_pair
    rsa_key = OpenSSL::PKey::RSA.new(2048)
    private_key_pem = rsa_key.private_to_pem
    public_key_pem = rsa_key.public_to_pem
    return {
      private_key: private_key_pem,
      public_key: public_key_pem
    }
  end
  def generate_signature(data, private_key_pem)
    private_key = OpenSSL::PKey::RSA.new(private_key_pem)
    signature = private_key.sign(OpenSSL::Digest::SHA256.new, data)
    return Base64.strict_encode64(signature)
  end
  def verify_signature(data, signature, public_key_pem)
    public_key = OpenSSL::PKey::RSA.new(public_key_pem)
    decoded_signature = Base64.strict_decode64(signature)
    return public_key.verify(OpenSSL::Digest::SHA256.new, decoded_signature, data)
  end
end