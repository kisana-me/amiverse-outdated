import { useEmojisContext } from '@/contexts/emojis_context'
import { useEffect } from 'react'

export default function EmojisMenu({clicked = () =>{}}) {
  const {emojis, fetchEmojis} = useEmojisContext()

  useEffect(() => {
    fetchEmojis()
  },[])

  return (
    <>
      <div className="emojis-menu">
        <div className="emojis-grid">
          {emojis.map((emoji, index) => (
            <div key={index} className="emoji-item" onClick={() => {
              console.log(`Emoji ${emoji.name} selected`)
              clicked(emoji.aid)
            }}>
              {emoji.name}
            </div>
          ))}
        </div>
        <div className="emoji-footer">
          <div className="emoji-recent">
            <span className="emoji-recent-icon">🕒</span>
            <span>最近使用</span>
          </div>
          <div className="emoji-search">検索</div>
        </div>
      </div>
      <style jsx>{`
        .emojis-menu {
          width: 300px;
          padding: 10px;
          background-color: #222;
          border-radius: 8px;
        }
        
        .emojis-grid {
          display: grid;
          grid-template-columns: repeat(6, 1fr);
          gap: 10px;
          margin-bottom: 15px;
        }
        
        .emoji-item {
          font-size: 24px;
          display: flex;
          justify-content: center;
          align-items: center;
          height: 40px;
          cursor: pointer;
          border-radius: 5px;
          transition: background-color 0.2s;
        }
        
        .emoji-item:hover {
          background-color: #333;
        }
        
        .emoji-footer {
          display: flex;
          justify-content: space-between;
          align-items: center;
          padding-top: 10px;
          border-top: 1px solid #444;
          color: #aaa;
          font-size: 14px;
        }
        
        .emoji-recent {
          display: flex;
          align-items: center;
          gap: 5px;
        }
        
        .emoji-recent-icon {
          font-size: 16px;
        }
        
        .emoji-search {
          cursor: pointer;
        }
      `}</style>
    </>
  )
}