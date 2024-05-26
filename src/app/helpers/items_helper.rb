module ItemsHelper
  def paged_items(param)
    param = param.to_i
    page = param < 1 ? 1 : param
    offset_item = (page - 1) * 10 # 開始位置
    limit_item = 10 # 表示件数
    return Item.offset(offset_item.to_i).limit(limit_item.to_i).order(created_at: :desc)
  end
  def public_items
    return Item.where(
      silent: false,
      visibility: :public_share,
      status: :shared,
      deleted: false
    ).offset(offset_item.to_i).limit(limit_item.to_i).order(id: :desc)
  end
end