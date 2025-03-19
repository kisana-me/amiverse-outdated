import Link from 'next/link'
import { useState } from 'react'
import ItemAccount from '@/components/items/item_account'
import ItemReactions from '@/components/items/item_reactions'
import ItemConsole from '@/components/items/item_console'
import { formatRelativeTime } from '@/lib/format_time'

export default function Item({ item }) {
  const [consoleDisabled, setConsoleDisabled] = useState(false)

  return (
    <>
      <div className="item">
        <ItemAccount account={item.account} />
        <div className='item-info item-top-info'>
          <div className='iti-left'>
            <Link href={'/items/' + item.aid} style={{color: 'inherit', textDecoration: 'none'}}>
              返信/引用
            </Link>
          </div>
          <div className='iti-right'>
            <Link href={'/items/' + item.aid} style={{color: 'inherit', textDecoration: 'none'}}>
              { formatRelativeTime(new Date(item.created_at)) }
            </Link>
          </div>
        </div>
        <div className="item-content">
          {item.content}
          {(() => {
            if (item.images && item.images.length > 0) {
              return item.images.map(image => (
                <div key={image.aid}>
                  <img src={image.url} className="item-content-image"></img>
                </div>
              ))
            } else {
              return
            }
          })()}
          {(() => {
            if (item.videos && item.videos.length > 0) {
              return item.videos.map(video => (
                <div key={video.aid}>
                  <video src={video.url} className="item-content-video" controls="controls"></video>
                </div>
              ))
            } else {
              return
            }
          })()}
        </div>
        <div className='item-info item-bottom-info'>
          <div className='ibi-left'>
            <Link href={'/items/' + item.aid} style={{color: 'inherit', textDecoration: 'none'}}>
              全体公開
            </Link>
          </div>
          <div className='ibi-right'>
            <Link href={'/items/' + item.aid} style={{color: 'inherit', textDecoration: 'none'}}>
              1000回表示
            </Link>
          </div>
        </div>
        <ItemReactions reactions={item.reactions} />
        <ItemConsole
          item_aid={item.aid}
          disabled={consoleDisabled} 
          toggleDisabled={() => {
            setConsoleDisabled(true);
            setTimeout(() => {
              setConsoleDisabled(false);
            }, 1000);
          }}
        />
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
          color: #939393;
        }
        .item-top-info {
          margin-top: 4px;
        }
        .iti-left {}
        .iti-right {}
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
        .item-content-image {
          width: 100%;
        }
        .item-content-video {
          width: 100%;
        }
      `}</style>
    </>
  )
}