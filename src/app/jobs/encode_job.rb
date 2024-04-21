class EncodeJob < ApplicationJob
  require 'aws-sdk-s3'
  queue_as :default

  def perform(aid:, key:, video:)#video, account)
    Dir.mktmpdir do |dir|
      downloaded_video = Tempfile.new(['downloaded_video', '.mp4'])
      encoded_video = Tempfile.new(['encoded_video', '.mp4'])
      s3 = Aws::S3::Client.new(
        endpoint: ENV["S3_ENDPOINT_0"],
        region: ENV["S3_REGION"],
        access_key_id: ENV["S3_USER"],
        secret_access_key: ENV["S3_PASSWORD"],
        force_path_style: true
      )
      s3.get_object(bucket: ENV["S3_BUCKET"], key: key, response_target: downloaded_video.path)

      movie = FFMPEG::Movie.new(downloaded_video.path)
      options = {
        video_codec: 'libx264',
        audio_codec: 'aac',
        custom: %w(-vf scale=1280:-2 -preset medium)
      }
      movie.transcode(encoded_video.path, options) {
        |progress| video.update(description: (progress * 100).round(2))
        Rails.logger.info("======#{(progress * 100).round(2)}===encode")
      }
      
      key = "/variants/videos/mp4/#{aid}.mp4"
    
      s3_upload(key: key, file: encoded_video.path, content_type: 'video/mp4')

      downloaded_video.close
      encoded_video.close
    end
  end
  private
  
  def s3_upload(key:, file:, content_type:)
    s3 = Aws::S3::Resource.new(
      endpoint: ENV["S3_ENDPOINT_0"],
      region: ENV["S3_REGION"],
      access_key_id: ENV["S3_USER"],
      secret_access_key: ENV["S3_PASSWORD"],
      force_path_style: true
    )
    obj = s3.bucket(ENV["S3_BUCKET"]).object(key)
    obj.upload_file(file, content_type: content_type, acl: 'readonly')
  end
end
