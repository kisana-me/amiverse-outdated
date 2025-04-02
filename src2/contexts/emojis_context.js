import { createContext, useContext, useState, useEffect } from 'react'
import axios from '@/lib/axios'

const EmojisContext = createContext()

export const EmojisContextProvider = ({ children }) => {
  const [emojisLoaded, setEmojisLoaded] = useState(false)
  const [emojisLoading, setEmojisLoading] = useState(false)
  const [emojis, setEmojis] = useState([])

  async function fetchEmojis(category = '') {
    if(emojisLoading || emojisLoaded){
      return
    }
    setEmojisLoading(true)
    try {
      const res = await axios.post('/emojis', {category: '1'})
      setEmojis(res.data)
      setEmojisLoaded(true)
    } catch (err) {
      console.log(err.response ? '絵文字取得エラー/クライアント' : '絵文字取得エラー/サーバー')
    }
    setEmojisLoading(false)
  }

  function getEmoji(aid) {
    const cached_emoji = emojis.find(emoji => emoji.aid === aid)
    return cached_emoji
  }

  useEffect(() => {
    
  },[])

  return (
    <EmojisContext.Provider value={{
      emojisLoaded, setEmojisLoaded,
      emojisLoading, setEmojisLoading,
      emojis, setEmojis,
      fetchEmojis, getEmoji
    }}>
      {children}
    </EmojisContext.Provider>
  )
}

export const useEmojisContext = () => useContext(EmojisContext)
