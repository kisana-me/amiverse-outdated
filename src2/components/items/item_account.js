import Link from "next/link"

export default function ItemAccount({ account }) {
  return (
    <>
      <div className="item-account-info">
        <Link href={'/@' + account.name_id} className="iai-plate" style={{
          color: '#fff',
          minWidth: 0,
          display: 'flex',
          flexGrow: 1
        }}>
          <div className="iai-icon-wrap" style={{
            borderColor: account.ring_color || '#fff0'
          }}>
            <div className="iai-status" style={{
              bottom: 0,
              right: 0,
              background: account.status_rb_color || '#fff0'
            }}>
            </div>
              <img src={account.icon_url || "/ast-imgs/icon.png"} className="iai-icon" />
          </div>
          <div className="iai-nameplate">
            <div className="iai-name">
              {account.name}
            </div>
            <div className="iai-nameplate-under">
              <div className="iai-name_id">
                {'@' + account.name_id}
              </div>
            </div>
          </div>
        </Link>
        <div className="iai-others">
        <button className="iai-button" onClick={()=>console.log("button clicked!")}>フォロー</button>
        </div>
      </div>
      <style jsx>{`
        .item-account-info {
          display: flex;
          height: 50px;
          overflow-x: auto;
          overflow-y: hidden;
        }
        .iai-icon-wrap {
          border: 2px solid;
          border-radius: 44px;
          display: flex;
          align-items: center;
          aspect-ratio: 1 / 1;
          justify-content: center;
          height: 50px;
          box-sizing: border-box;
          position: relative;
        }
        .iai-status {
          width: 8px;
          height: 8px;
          border-radius: 4px;
          position: absolute;
        }
        .iai-icon {
          border-radius: 24px;
          height: 42px;
          aspect-ratio: 1/1;
          object-fit: cover;
          object-position: top center;
        }
        .iai-nameplate {
          margin-left: 6px;
          min-width: 0;
          display: flex;
          flex-direction: column;
          justify-content: center;
        }
        .iai-name {
          font-size: 15px;
          line-height: 22px;
          overflow: hidden;
          white-space: nowrap;
          text-overflow: ellipsis;
        }
        .iai-nameplate-under {
          display: flex;
          height: 20px;
        }
        .iai-name_id {
          font-size: 14px;
          line-height: 20px;
          overflow: hidden;
          white-space: nowrap;
          text-overflow: ellipsis;
        }
        .iai-others {
          display: flex;
          justify-content: flex-end;
          align-items: center;
        }
        .iai-button {
          padding: 7px 10px;
          border: 0;
          border-radius: 10px;
          white-space: nowrap;
          color: var(--button-font-color);
          background: var(--button-color);
          cursor: pointer;
        }
      `}</style>
    </>
  )
}