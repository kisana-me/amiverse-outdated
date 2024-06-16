class V1::ActivityPubController < V1::ApplicationController
  include ApReceiver

  def inbox
    # frontで受け取ったactivityを解析・保存
    data = JSON.parse(request.body.read)
    # frontから来たか検証 if data['key'] == ENV['key']
    # digestやsignなど検証 check_sign(data)
    # データ処理
    status = ap_receive(data)
    render json: { status: status }
  end
  def nodeinfo
    # データ出力
  end
  def nodeinfo_2_0
    # データ出力
  end
  def nodeinfo_2_1
    # データ出力
  end
  def webfinger
    # /v1/webfinger/:name_id
    account = find_local_account(name_id)
    if account
      available = true
    else
      available = false
    end
    url = File.join(ENV('APP_URL'), "@#{account.name_id}")
    uri = File.join(ENV('APP_URL'), "accounts/#{account.aid}")
    render json: {
      available: available,
      data: {
        subject: `acct:${name_id}@amiverse.net`,
        aliases: [url, uri],
        links: [
          {
            "rel": "http://webfinger.net/rel/profile-page",
            "type": "text/html",
            "href": url
          },
          {
            "rel": "self",
            "type": "application/activity+json",
            "href": uri
          }
        ]
      }
    }
  end
end