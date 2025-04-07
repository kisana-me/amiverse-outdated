export default function AccountPlate({ account }) {
  return (
    <>
      <div className="account-plate">
        <div className="ap-icon-container">
          <div className="ap-icon">
            <div className="ap-icon-status"></div>
            <img
              className="ap-icon-image"
              src={account.icon_url || "/ast-imgs/icon.png"}
              alt='アイコン'
            />
          </div>
        </div>

        <div className="ap-nameplate">
          <div>{account.name}</div>
          <div>@{account.name_id}</div>
        </div>

        <div className="ap-buttons">
          <button className="ap-button">🍭</button>
          <button className="ap-button">❤️</button>
          <button className="ap-button">🤞</button>
          <button className="ap-button">Follow</button>
        </div>

        <div className="ap-badges">
          {account.badges && account.badges.map(badge => (
            <div className="ap-badge">
              <div className="ap-badge-icon">
                <img
                  className="ap-badge-icon-image"
                  src={badge.url}
                  alt={badge.name + " badge icon"}
                />
              </div>
              <div className="ap-badge-name">
                {badge.name}
              </div>
            </div>
          ))}
        </div>
      </div>

      <style jsx>{`
        .account-plate {
          margin: 0px 14px;
        }
        /* ICON */
        .ap-icon-container {
          display: flex;
        }
        .ap-icon {
          width: 80px;
          height: 80px;
        }
        .ap-icon-status {}
        .ap-icon-image {
          width: 80px;
          height: 80px;
          border-radius: 50%;
        }
        /* NAMEPLATE */
        .ap-nameplate {}
        /* BOTTOM */
        .ap-buttons {
          display: flex;
          align-items: center;
          gap: 4px;
          box-sizing: border-box;
        }
        .ap-button {
          height: 32px;
          margin: 4px 0;
          border: 2px solid;
          border-radius: 8px;
          background: inherit;
          color: var(--font-color);
          box-sizing: border-box;
          cursor: pointer;
        }
        /* BADGES */
        .ap-badges {
          display: flex;
          align-items: center;
          gap: 4px;
          box-sizing: border-box;
        }
        .ap-badge {
          height: 24px;
          margin: 4px 0;
          display: flex;
        }
        .ap-badge-icon {
          display: flex;
        }
        .ap-badge-icon-image {
          width: 24px;
          height: 24px;
          border-radius: 6px;
        }
        .ap-badge-name {
          margin: 0 0 0 4px;
          font-size: 13px;
          line-height: 24px;
        }
      `}</style>
    </>
  )
}