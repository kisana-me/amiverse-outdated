export default function ItemReactions({ reactions }) {
  return (
    <>
      <div className="reactions">
        <div className="rating">
          <button className='reaction-button rb-left'>
            <div className="reaction-icon">
              <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M48.2111 17.5777C48.9482 16.1036 51.0518 16.1036 51.7889 17.5777L83.9299 81.8598C84.7138 83.4275 83.2452 85.1736 81.5664 84.6699L50.5747 75.3724C50.1998 75.2599 49.8002 75.26 49.4253 75.3724L18.4336 84.6699C16.7548 85.1736 15.2862 83.4275 16.0701 81.8598L48.2111 17.5777Z" fill="currentColor"/>
              </svg>
            </div>
            <div className="reaction-number">0</div>
          </button>
          <button className='reaction-button rb-right'>
            <div className="reaction-icon">
              <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M51.7889 82.4223C51.0518 83.8964 48.9482 83.8964 48.2111 82.4223L16.0701 18.1402C15.2862 16.5725 16.7548 14.8264 18.4336 15.3301L49.4253 24.6276C49.8002 24.7401 50.1998 24.74 50.5747 24.6276L81.5664 15.3301C83.2452 14.8264 84.7138 16.5725 83.9299 18.1402L51.7889 82.4223Z" fill="currentColor"/>
              </svg>
            </div>
            <div className="reaction-number">0</div>
          </button>
        </div>
        {reactions.map(reaction => (
          <button className="reaction-button">
            <div className="reaction-icon">
              {reaction.emoji.name}
            </div>
            <div className="reaction-number">
              {reaction.reaction_count}
            </div>
          </button>
        ))}
      </div>
      <style jsx>{`
        .reactions {
          display: flex;
          flex-direction: row;
          width: 100%;
          height: 20px;
          margin-bottom: 4px;
          flex-wrap: wrap;
          overflow-x: hidden;
          overflow-y: hidden;
        }
        .reaction-button {
          display: flex;
          align-items: center;
          color: #bcbcbc;
          overflow: hidden;
          background: inherit;
          border: 1px solid #bcbcbc;
          box-sizing: border-box;
          border-radius: 6px;
          padding: 0 7px 0 4px;
          margin-right: 4px;
          cursor: pointer;
          white-space: nowrap
        }
        .reaction-button:hover {
          background: #fff3;
        }
        .reaction-icon {
          width: 18px;
          height: 18px;
          flex-shrink: 0;
          display: flex;
          justify-content: flex-start;
          align-items: center;
          overflow: hidden;
        }
        .reaction-number {
          display: flex;
          justify-content: flex-start;
          align-items: center;
          overflow: hidden;
        }
        .rating {
          display: flex;
          margin-right: 4px;
        }
        .rb-left, .rb-right {
          margin: 0;
        }
        .rb-left {
          border: 1px solid #bcbcbc;
          border-right: 0.5px solid;
          border-radius: 6px 0 0 6px;
        }
        .rb-right {
          border: 1px solid #bcbcbc;
          border-left: 0.5px solid;
          border-radius: 0 6px 6px 0;
        }
      `}</style>
    </>
  )
}