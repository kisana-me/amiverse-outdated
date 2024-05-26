import Link from 'next/link'
const formatDate = (isoString) => {
  const date = new Date(isoString);
  const year = date.getFullYear();
  const month = ('0' + (date.getMonth() + 1)).slice(-2);
  const day = ('0' + date.getDate()).slice(-2);
  const hours = date.getHours();
  const minutes = ('0' + date.getMinutes()).slice(-2);
  const seconds = ('0' + date.getSeconds()).slice(-2);

  return `${year}年 ${month}月 ${day}日 ${hours}時 ${minutes}分 ${seconds}秒`;
}
export default function Item({ item }) {



  return (
    <>
      <div className="item">
        <div className='item-account'>
          <div className='item-account-badges'>
            {/*item.account.badges*/}
            <div>✨</div><div>🍭</div><div>💕</div><div>😊</div>
          </div>
          <div className='item-account-data'>
            <Link href={'/@' + item.account.name_id}>
            <div className="iad-plate">
              <img src={item.account.icon_url} className='iad-plate-icon' />
              <div className="iad-plate-names">
                <div className="iadp-names-name">
                  {item.account.name}
                </div>
                <div className="iadp-names-name_id">
                  {'@' + item.account.name_id}
                </div>
              </div>
            </div>
            </Link>
            <div className='iad-others'>
              <div className="iad-others-container">
                <button className="iado-container-button">フォローする</button>
              </div>
            </div>
          </div>
        </div>

        <div className='item-info'>
          <div className='item-info-date'>
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
        <div className="item-reaction">
          {item.reactions.map(reaction => (
            <div key={reaction.reaction_id}>
              <button>{reaction.content}</button>
              <div>{reaction.count}</div>
            </div>
          ))}
        </div>
      </div>
      <style jsx>{`
        .item {
          padding: 10px 5px;
          border-bottom: 1px var(--border-color) solid;
        }

        /* ACCOUNT */

        .item-account {

        }
        .item-account-badges {
          display: flex;
        }
        .item-account-data {
          display: flex;
        }
        .iad-plate {
          display: flex;
        }
        .iad-plate-icon {
          width: 50px;
          height: 50px
        }
        .iad-plate-names{
          margin-left: 10px;
        }
        .iadp-names-name {
          font-size: 25px;
          line-height: 25px;
        }
        .iadp-names-name_id {
          font-size: 16px;
          line-height: 25px;
        }
        .iad-others {
          display: flex;
          flex-grow: 1;
          justify-content: flex-end;
        }
        .iad-others-container {
          display: flex;
          align-items: center;
        }
        .iado-container-button {
          height: 80%;
        }

        /* INFO */
        .item-info {
          display: flex;
        }
        .item-info-date {
          margin-left: auto;
          font-size: 12px;
          line-height: 12px;
        }

        /* CONTENT */

        .item-content {
          min-height: 40px;
          padding: 5px;
          overflow-wrap: break-word;
        }
        .item-reaction {
          display: flex;
          padding: 4px;
          flex-wrap: wrap;
        }
        .item-image {
          width: 100%
        }
      `}</style>
    </>
  )
}