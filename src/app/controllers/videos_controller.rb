class VideosController < ApplicationController
  before_action :logged_in_account
  before_action :set_video, only: %i[ show_video ]

  def show
    # send_stream(filename: @video.video_id, type: @video.encoded_video.content_type) do |stream|
    #   @video.encoded_video.download do |chunk|
    #     stream.write(chunk)
    #   end
    # end
  end
  def create
    @video = Video.new(video_params)
    @video.aid = generate_aid(Video, 'aid')
    @video.account = @current_account
    if @video.save
      EncodeJob.perform_later(
        video: @video,
        aid: @video.aid,
        key: "/videos/#{@video.aid}.#{@video.video_data.original_filename.split('.').last.downcase}"
      )
      flash[:success] = "アップロードしました"
    else
      flash[:danger] = "アップロードできませんでした#{@video.errors.full_messages.join(", ")}"
    end
    redirect_to settings_storage_path
  end
  def update
  end
  def destroy
  end
  private
  def set_video
    @video = Video.find_by(
      aid: params[:aid],
      deleted: false
    )
  end
  def video_params
    params.require(:video).permit(
      :name,
      :description,
      :video_data
    )
  end
end