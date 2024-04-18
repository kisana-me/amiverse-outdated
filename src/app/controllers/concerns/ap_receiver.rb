module ApReceiver
  include ActivityPub

  def ap_receive(data)
    headers = data['headers']
    body = data['body']
    # BODY #
    context = body['@context']
    id = body['id']
    object = body['object'] unless body['object'].nil?
    activity_type = body['type'] unless body['type'].nil?

    status = 'Info:処理開始'
    received_params = {
      activitypub_id: id,
      received_at: data['received_at'],
      headers: headers.to_json,
      body: body.to_json,
      status: status,
      object: object,
      activity_type: activity_type
    }
    saved_data = ActivityPubReceived.create!(received_params)
    ########
    # 解析 #
    ########
    case activity_type
    when 'Follow'
      followed = account(object)
      follower = account(body['actor'])
      if followed && follower
        follow_params = {
          followed: followed,
          follower: follower,
          uuid: id # uuidではなくid
        }
        if Follow.exists?(follow_params)
          status = 'Info:フォロー済み'
        else
          follow_params.merge!(accepted: true)
          Follow.create(follow_params)
          status = 'Success:フォロー完了'
        end
        ap_accept_follow(
          followed: followed,
          follower: follower,
          id: body['id']
        )
      else
        status = 'Error:アカウントが存在しない'
      end
    when 'Like'
      #actorがobjectをいいねする
    when 'Dislike'
    ## リアクション系
    when 'Accept'
      case object['type']
      when 'Follow'
        followed = account(object['object'])
        follower = account(object['actor'])
        follow_params = {
          followed: followed,
          follower: follower
        }
        if follow = Follow.find_by(follow_params)
          if follow.accepted
            status = 'Info:フォロー承認済み'
          else
            follow.update(accepted: true)
            status = 'Success:フォロー承認完了'
          end
        else
          status = 'Error:指定のフォローが見つからない'
        end
      when 'Undo'
        Rails.logger.info('----------')
        Rails.logger.info('-----Undo-----')
        case object['object']['type']
        when 'Follow'
          Rails.logger.info('-----Undo---Follow--')
          #Follow.where(this_follow_params).delete_all
        else
        end
      else
      end
    when 'Reject'
    when 'Undo'
      case object['type']
      when 'Follow'
        followed = account(object['object'])
        follower = account(body['actor'])
        if followed && follower
          follow_params = {
            followed: followed,
            follower: follower
          }
          if Follow.exists?(follow_params)
            Follow.where(follow_params).delete_all
            status = 'S0'
          else
            status = 'E4'
          end
        else
          status = 'E0'
        end
      else
        #その他
      end
    ## CRUD系
    when 'Create'
      #actorアカウントがあるか確認
      case object['type']
      when 'Note'
        attributed_to = account(object['attributedTo'])
        item = Item.new(
          content: object['content'].force_encoding('UTF-8'),
          sensitive: object['sensitive']
        )
        item.account = attributed_to
        item.aid = generate_aid(Item, 'aid')
        item.kind = 'plane'
        if item.save
          status = 'Success:投稿完了'
        end
      else
        #その他
      end
      #objectを作成する
    when 'Update'
    when 'Delete'
      case object
      when String
        #objectがuser形式であれば
        #find_account_by_nidして
        #あればdeleted = true
        #なければ終わり
        saved_data.delete
        #煩わしいので↑
        if account = Account.find_by(activitypub_id: object)
          account.update(deleted: true) 
          status = 'S0'
        else
          status = 'S1'
        end
      else
      end
    else
      #その他
    end
    # status更新
    saved_data.status = status
    saved_data.save
    return status
  end
end