module ApplicationHelper
  include AccountsHelper
  include ImagesHelper
  include TrendManagement
  require 'aws-sdk-s3'
  def full_title(page_title = '')
    base_title = Rails.application.config.x.server_property.server_name
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
  def full_url(path)
    return File.join(ENV["API_URL"], path)
  end
  def to_page(current_page, where_to_go)
    current_page = current_page.to_i
    page = where_to_go == 'next' ? [current_page + 1, 2].max : where_to_go == 'prev' ? [current_page - 1, 1].max : 2
    return page
  end
  def tab_trend
    current_trend(limit: 5)
  end
  private
  def object_url(path_key)
    bucket_key = File.join(ENV["S3_BUCKET"], path_key)
    url = File.join(ENV["S3_PUBLIC_ENDPOINT"], bucket_key)
    return url
  end
  def signed_object_url(path_key)
    s3 = Aws::S3::Client.new(
      endpoint: ENV["S3_PUBLIC_ENDPOINT"],
      region: ENV["S3_REGION"],
      access_key_id: ENV["S3_USER"],
      secret_access_key: ENV["S3_PASSWORD"],
      force_path_style: true
    )
    signer = Aws::S3::Presigner.new(client: s3)
    url = signer.presigned_url(
      :get_object,
      bucket: ENV["S3_BUCKET"],
      key: "#{path_key}",
      expires_in: 12
    )
    return url
  end
end
