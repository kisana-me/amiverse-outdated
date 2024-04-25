module HttpSignature

  # 署名

  def create_http_signature(body:, private_key:, to_url:, from_url:)
    to_host = URI.parse(to_url).host
    current_time = Time.now.utc.httpdate
    digest = Digest::SHA256.base64digest(body.to_json)
    to_be_signed = [
      "(request-target): post #{URI.parse(to_url).path}",
      "date: #{current_time}",
      "host: #{to_host}",
      "digest: SHA-256=#{digest}"].join("\n")
    signature = generate_signature(private_key, to_be_signed)
    return current_time, digest, to_be_signed, signature
  end
  def verify_http_signature(actor:, signature:, body:)
    # verify here
  end

  # ヘッダー

  def create_signed_headers(actor:, body:, to_url:, from_url:)
    http_signature = create_http_signature(body: body, private_key: actor.private_key, to_url: to_url, from_url: from_url)
    statement = [
      "keyId=\"https://#{URI.parse(from_url).host}/@#{actor.name_id}#main-key\"",
      'algorithm="rsa-sha256"',
      'headers="(request-target) date host digest"',
      "signature=\"#{http_signature[3]}\""
    ].join(',')
    headers = {
      'Host': URI.parse(to_url).host,
      'Date': http_signature[0],
      'Digest': "SHA-256=#{http_signature[1]}",# いらないときもある
      'Signature': statement,
      'Authorization': "Signature #{statement}",
      #'Accept': 'application/json',
      #'Accept-Encoding': 'gzip',
      #'Cache-Control': 'max-age=0',
      'Content-Type': 'application/activity+json',
      'User-Agent': "Amiverse v0.0.1 (+https://#{URI.parse(from_url).host}/)"
    }
    return headers, statement, http_signature
  end
  def verify_signed_headers(headers:)
    # verify here
  end

  def build_signed_string(headers:, statement_headers:, request_target:, path:)
    array = statement_headers.split(" ")
    signed_headers.map do |signed_header|
      case signed_header
      when '(request-target)'
        "(request-target): #{request_target}} #{path}"
      else
        "#{signed_header}: #{headers[to_header_name(signed_header)]}"
      end
    end.join("\n")
  end
  def to_header_name(str)
    str.split('-').map(&:capitalize).join('-')
  end
end