export default function ItemReactions({ reactions }) {
  return (
    <>
      <div className="reactions">
        {reactions.map(reaction => (
          <button className="reaction">
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
          flex-wrap: wrap;
          overflow-x: hidden;
          overflow-y: hidden;
        }
        .reaction {
          display: flex;
          align-items: center;
          color: white;
          background: #f003;
          border: 1px solid red;
          border-radius: 8px;
          padding: 0 7px 0 4px;
          font-size: 13px;
          line-height: 22px;
          margin-right: 4px;
          box-sizing: border-box;
          height: 22px;
          cursor: pointer;
          white-space: nowrap
        }
      `}</style>
    </>
  )
}