class CanvasesController < ApplicationController
  before_action :logged_in_account

  def index
    @canvases = Canvas.all
  end
  def show
    @canvas = Canvas.find_by(aid: params[:aid], deleted: false)
  end
  def new
    @canvas = Canvas.new
  end
  def create
    # JSONファイルを読み込む
    array_data = JSON.parse(params[:canvas][:canvas_data])

    # 画像の幅と高さを設定
    width = 320
    height = 120

    # 新しいPNG画像を作成
    png = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::WHITE)

    # JSONデータを元に画像を生成
    array_data.each_with_index do |value, index|
      x = index % width
      y = index / width
      color = value == 1 ? ChunkyPNG::Color::BLACK : ChunkyPNG::Color::WHITE
      png[x, y] = color
    end

    # 画像を保存
    canvas_image = Tempfile.new(['canvas_image','.png'])
    png.save(canvas_image.path, interlace: true)

    @canvas = Canvas.new(canvas_params)
    @canvas.account = @current_account
    @canvas.aid = generate_aid(Canvas, 'aid')
    @canvas.image_path = canvas_image.path
    Rails.logger.info("=1==============cavana===========")
    if @canvas.save!
      flash[:success] = "保存できました"
      redirect_to canvases_path
    else
      flash[:danger] = "保存できませんでした"
      redirect_to canvases_path
    end
    canvas_image.close
  end
  def update
  end
  def destroy
  end

  private

  def set_canvas
  end
  def canvas_params
    params.require(:canvas).permit(
      :canvas_data,
      :name,
      :description
    )
  end
end