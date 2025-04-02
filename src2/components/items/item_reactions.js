import React, { useState, useRef } from 'react'
import { useEmojisContext } from '@/contexts/emojis_context'
import { useToastsContext } from '@/contexts/toasts_context'
import { useItemsContext } from '@/contexts/items_context'
import EmojisMenu from '@/components/emojis/emojis_menu'
import ToggleMenu from '@/components/common/toggle_menu'
import axios from 'axios'

export default function ItemReactions({ item, disabled = false }) {
  const { addToast } = useToastsContext()
  const emojiButtonRef = useRef(null)
  const [isEmojiMenuOpen, setIsEmojiMenuOpen] = useState(false)
  const {updateItems} = useItemsContext()
  const {emojis, fetchEmojis, getEmoji} = useEmojisContext()

  const itemReact = async (emoji_aid) => {
    // すでにリアクションを付けていないか調べる
    if (false) {
      console.log('emoji_aid: ' + emoji_aid + '. Button pressed!!')
    } else {
      const item_aid = item.aid
      let newItem = item
      newItem.control_disabled = true
      updateItems(newItem)
      let reactions = [...newItem.reactions]
      const reactionIndex = reactions.findIndex(r => r.emoji.aid === emoji_aid)
      await axios.post('items/react', { item_aid, emoji_aid })
        .then(res => {
          if (res.data.status == 'reacted') {
            newItem.reactions_counter += 1
            if (reactionIndex !== -1) {
              reactions[reactionIndex] = {
                ...reactions[reactionIndex],
                reacted: true,
                reaction_count: reactions[reactionIndex].reaction_count + 1
              }
            } else {
              reactions.push({
                emoji: getEmoji(emoji_aid),
                reacted: true,
                reaction_count: 1
              })
            }
          } else if (res.data.status == 'deleted'){
            newItem.reactions_counter -= 1
            if (reactionIndex !== -1) {
              const updatedReaction = {
                ...reactions[reactionIndex],
                reacted: false,
                reaction_count: reactions[reactionIndex].reaction_count - 1
              }
              if (updatedReaction.reaction_count > 0) {
                reactions[reactionIndex] = updatedReaction
              } else {
                reactions.splice(reactionIndex, 1)
              }
            }
          } else {
            console.log(res.data.status)
            addToast(`エラー/${res.data.status}`)
          }
        })
        .catch(err => {
          console.log(err.response)
        })
      newItem.reactions = reactions
      newItem.control_disabled = false
      updateItems(newItem)
    }
  }

  return (
    <>
      <div className="reactions">
        <div className="reactions-content">
          <button
            ref={emojiButtonRef}
            className='reaction-button rb-emojis'
            onClick={() => setIsEmojiMenuOpen(!isEmojiMenuOpen)}
            disabled={item.control_disabled === true}
          >
            <div className="reaction-icon">
              <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path fillRule="evenodd" clipRule="evenodd" d="M76 11H70V24H57V30H70V43H76V30H89V24H76V11ZM50 27C50 21.5581 51.8899 16.5576 55.0492 12.6192C52.7609 12.2123 50.4052 12 48 12C25.9086 12 8 29.9086 8 52C8 74.0914 25.9086 92 48 92C70.0914 92 88 74.0914 88 52C88 49.5948 87.7877 47.2391 87.3808 44.9508C83.4424 48.1101 78.4419 50 73 50C60.2975 50 50 39.7025 50 27ZM36 34C32.6863 34 30 36.6863 30 40C30 43.3137 32.6863 46 36 46C39.3137 46 42 43.3137 42 40C42 36.6863 39.3137 34 36 34ZM32.8247 59C32.3692 59 32 59.3693 32 59.8247C32 68.2058 38.7942 75 47.1753 75H51.8247C60.2058 75 67 68.2058 67 59.8247C67 59.3693 66.6308 59 66.1753 59H32.8247Z" fill="currentColor"/>
              </svg>
            </div>
            <div className="reaction-number">{item.reactions_counter}</div>
          </button>
        </div>

        <div className="reactions-content">
          {item.reactions.map(reaction => (
            <button className={"reaction-button rb-emoji" + (reaction.reacted ? " rb-reacted" : "")}
              key={reaction.emoji.aid}
              onClick={() => itemReact(reaction.emoji.aid)}
              disabled={item.control_disabled === true}
            >
              <div className="reaction-emoji">
                {reaction.emoji.name}
              </div>
              <div className="reaction-number">
                {reaction.reaction_count}
              </div>
            </button>
          ))}
        </div>
      </div>

      <ToggleMenu 
        isOpen={isEmojiMenuOpen && !disabled} 
        onClose={() => setIsEmojiMenuOpen(false)} 
        buttonRef={emojiButtonRef}
      >
        <EmojisMenu clicked={(emoji_aid) => {
          setIsEmojiMenuOpen(false)
          console.log(emoji_aid)
          itemReact(emoji_aid)
        }}/>
      </ToggleMenu>

      <style jsx>{`
        .reactions {
          height: 22px;
          margin-bottom: 4px;
          display: flex;
          flex-direction: row;
          flex-wrap: wrap;
          overflow: hidden;
        }
        .reactions-content {
          display: flex;
        }
        .reactions-content:first-child {
        }
        .reactions-content:last-child {
          scrollbar-width: none;
          overflow-x: scroll;
        }
        /* button */
        .reaction-button {
          padding: 0 4px;
          border: 1px solid #0000;
          border-radius: 6px;
          margin: 0 7px 0 0;
          color: var(--inconspicuous-font-color);
          background: inherit;
          display: flex;
          align-items: center;
          overflow: hidden;
          cursor: pointer;
        }
        .reaction-button:disabled {
          opacity: 0.5;
          cursor: not-allowed;
        }
        .reaction-button:hover:not(:disabled) {
          background: #fff3;
        }
        .rb-reacted {
          border: 1px solid #0f0;
        }
        /* button inside */
        .reaction-icon {
          width: 18px;
          height: 18px;
          flex-shrink: 0;
        }
        .reaction-number {
        }
      `}</style>
    </>
  )
}