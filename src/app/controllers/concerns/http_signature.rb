module HttpSignature
  def create_http_signature(body:, private_key:, to_url:, from_url:, type: '')
    to_host = URI.parse(to_url).host
    current_time = Time.now.utc.httpdate
    digest = Digest::SHA256.base64digest(body.to_json)
    case type
    when 'join'
      to_be_signed = [
        "(request-target): post #{URI.parse(to_url).path}",
        "date: #{current_time}",
        "host: #{to_host}",
        "digest: SHA-256=#{digest}"].join("\n")
    when 'enter'
      to_be_signed = "(request-target): post #{URI.parse(to_url).path}
      date: #{current_time}
      host: #{to_host}
      digest: SHA-256=#{digest}"
    else
      to_be_signed = "(request-target): post #{URI.parse(to_url).path}\ndate: #{current_time}\nhost: #{to_host}\ndigest: SHA-256=#{digest}"
    end
    signature = generate_signature(private_key, to_be_signed)
    return current_time, digest, to_be_signed, signature
  end
  def verify_http_signature
    # verify here
  end

  private
  def build_signed_string(headers, signed_headers, path)
    signed_headers.map do |signed_header|
      case signed_header
      when 'path'
        "(request-target): post #{path}"
      else
        "#{signed_header}: #{headers[to_header_name(signed_header)]}"
      end
    end.join("\n")
  end
end