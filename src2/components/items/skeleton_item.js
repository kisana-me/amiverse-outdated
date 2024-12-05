export default function SkeletonItem({  }) {
  return (
    <>
      <div className="item">
        <div className='item-account'>
          <div className='item-account-badges'>
            {/*item.account.badges*/}
            <div className='item-skeleton item-skeleton-badges'>{/* SKELETON OBJECT */}</div>
          </div>
          <div className='item-account-data'>
            <div className="iad-plate">
              <div className='iad-plate-icon'>
                  <div className='item-skeleton item-skeleton-icon'>{/* SKELETON OBJECT */}</div>
              </div>
              <div className="iad-plate-names">
                <div className="iadp-names-name">
                  <div className='item-skeleton item-skeleton-name'>{/* SKELETON OBJECT */}</div>
                </div>
                <div className="iadp-names-name_id">
                  <div className='item-skeleton item-skeleton-name_id'>{/* SKELETON OBJECT */}</div>
                </div>
              </div>
            </div>
            <div className='iad-others'>
              <div className="iad-others-container">
                <div className="iado-container-button">
                  <div className='item-skeleton item-skeleton-button'>{/* SKELETON OBJECT */}</div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className='item-info'>
          <div className='item-info-date'>
            <div className='item-skeleton item-skeleton-date'>{/* SKELETON OBJECT */}</div>
          </div>
        </div>

        <div className="item-content">
          <div className='item-skeleton item-skeleton-text'>{/* SKELETON OBJECT */}</div>
          <div className='item-skeleton item-skeleton-image'>{/* SKELETON OBJECT */}</div>
        </div>
        <div className="item-reaction">
          <div className='item-skeleton item-skeleton-reactions'>{/* SKELETON OBJECT */}</div>
        </div>
      </div>
      <style jsx>{`

        .item-skeleton {
          background: #373737;
          border-radius: 7px;
        }
        .no-item-skeleton {
          position: absolute;
          display: block;
          background: #373737;
          overflow: hidden;
          z-index: 3;
          margin-top: 10px;
          border-radius: 7px;
        }
        @keyframes skeleton-animation {
          0% {
            transform: translateX(-100%);
          }
          100% {
            transform: translateX(100%);
          }
        }
        .no-item-skeleton::before {
          position: absolute;
          top: 0;
          left: 0;
          z-index: 3;
          content: "";
          display: block;
          height: 100%;
          width: 100%;
          background: linear-gradient(
            90deg,
            transparent,
            rgba(255, 255, 255, 0.8),
            transparent
          );
          animation: skeleton-animation 1.2s linear infinite;
        }




        .item-skeleton-badges {
          width: 50px;
          height: 24px;
        }
        .item-skeleton-icon {
          width: 50px;
          height: 50px;
        }
        .item-skeleton-name {
          width: 50px;
          height: 25px;
        }
        .item-skeleton-name_id {
          width: 50px;
          height: 16px;
        }
        .item-skeleton-text {
          width: 50px;
          height: 16px;
        }




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