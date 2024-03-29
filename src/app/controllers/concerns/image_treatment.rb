module ImageTreatment
  def treat_image(aid, type, model = Image, attachment = 'image')
    instance = model.where('BINARY aid = ?', aid).first
    image = instance.send(attachment.to_s)
    image.analyze if image.attached?
    image.variant(custom_optimization(type), type).processed
  end
  def delete_treated_image(aid, type)
  end
  private
  def custom_optimization(type)
    #   : 最高を指定
    # ! : 厳密に指定
    # ^ : 最低を指定
    # < : 指定より小さい場合
    # > : 指定より大きい場合
    resize = "2048x2048>"
    extent = "" # 切り取る
    case type
    # icon
    when 'icons'
      resize = "400x400^"
      extent = "400x400"
    when 'tb-icons'
      resize = "50x50^"
      extent = "50x50"
    # banner
    when 'banners'
      resize = "1600x1600^"
      extent = "1600x1600"
    when 'tb-banners'
      resize = "400x400^"
      extent = "400x400"
    # image
    when 'images'
      resize = "2048x2048>"
    when 'tb-images'
      resize = "700x700>"
    when '4k-images'
      resize = "4096x4096>"
    # emoji
    when 'emojis'
      resize = "200x200>"
    when 'tb-emojis'
      resize = "50x50>"
    end
    return {
      coalesce: true, # アニメーションシーケンスの最適化
      gravity: "center", # extent(切り取り)時の画像位置
      loader: { page: nil },
      # dither: true, #'+': true, # エイリアシングを無効化して処理を早くする(動かない)
      # layers: 'Optimize', # GIFアニメーションを最適化
      quality: '85',
      format: "webp",
      auto_orient: true,
      strip: true, # EXIF削除
      resize: resize,
      extent: extent
    }
  end
  def include_signature # 画像文字入れ、使用時mergeする
    {
      gravity: "south",
      background: "black",
      fill: "white",
      font: font,
      splice: "0x24",
      pointsize: "14",
      draw: "gravity southeast text 10,2 'Posted by #{name} @#{name_id} | ????' ",
      deconstruct: true # アニメーションシーケンスの最適化2 #動くwebpで2回目処理時に文字が消えるバグ対策
    }
  end
end