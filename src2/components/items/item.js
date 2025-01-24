import Link from 'next/link'
import ItemAccount from '@/components/items/item_account'
import ItemReactions from '@/components/items/item_reactions'
import ItemConsole from '@/components/items/item_console'

const formatDate = (isoString) => {
  const date = new Date(isoString)
  const year = date.getFullYear()
  const month = ('0' + (date.getMonth() + 1)).slice(-2)
  const day = ('0' + date.getDate()).slice(-2)
  const hours = date.getHours()
  const minutes = ('0' + date.getMinutes()).slice(-2)
  const seconds = ('0' + date.getSeconds()).slice(-2)
  return `${year}年 ${month}月 ${day}日 ${hours}時 ${minutes}分 ${seconds}秒`
}
export default function Item({ item }) {
  return (
    <>
      <div className="item">
        <ItemAccount account={item.account} />
        <div className='item-info item-top-info'>
          <div className='iti-left'>
            <Link href={'/items/' + item.aid}>
              返信/引用
            </Link>
          </div>
          <div className='iti-right'>
            <Link href={'/items/' + item.aid}>
              { formatDate(item.created_at) }
            </Link>
          </div>
        </div>
        <div className="item-content">
          {item.content}
          {(() => {
            if (item.images && item.images.length > 0) {
              return item.images.map(image => (
                <div key={image.image_id}>
                  <img src={image.url} className="item-content-image"></img>
                </div>
              ))
            } else {
              return
            }
          })()}
        </div>
        <div className='item-info item-bottom-info'>
          <div className='ibi-left'>
            <Link href={'/items/' + item.aid}>
              全体公開
            </Link>
          </div>
          <div className='ibi-right'>
            <Link href={'/items/' + item.aid}>
              1000回表示
            </Link>
          </div>
        </div>
        <ItemConsole className="margin-top-4px" />
        <ItemReactions reactions={item.reactions} className="margin-top-4px" />
      </div>
      <style jsx>{`
        .item {
          padding: 10px 5px;
          border-bottom: 1px var(--border-color) solid;
        }
        /* INFO */
        .item-info {
          display: flex;
          justify-content: space-between;
          font-size: 12px;
          line-height: 12px;
        }
        .item-top-info {
          margin-top: 4px;
        }
        .iti-left {}
        .iti-right {
          color: #939393;
        }
        .item-bottom-info{
          color: #939393;
          margin-bottom: 4px;
        }
        .ibi-left {}
        .ibi-right {}

        /* CONTENT */
        .item-content {
          min-height: 40px;
          padding: 5px;
          overflow-wrap: break-word;
        }
      `}</style>
    </>
  )
}