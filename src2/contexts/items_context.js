import { createContext, useContext, useState, useEffect } from 'react'
import axios from '@/lib/axios'
import { useToastsContext } from '@/contexts/toasts_context'

const ItemsContext = createContext()
const feedsType=[
  {
    category: 'index or following or current',
    page: 0,
    feed: [
      {
        object: 'item or difuse',
        item: '{aid: ...}'
      }
    ],
    fetched_at: 'Date.?'
  }
]

export const ItemsContextProvider = ({ children }) => {
  const { addToast } = useToastsContext()
  const [itemsLoading, setItemsLoading] = useState(false)
  const [items, setItems] = useState([])
  const [feeds, setFeeds] = useState([])

  async function fetchFeeds(category = "index", page = 0) {
    try {
      const res = await axios.post(`/feed/${category}`, { page })
      return res.data
    } catch (err) {
      if (err.response) {
        addToast("タイムライン取得エラー:未ログイン")
      } else {
        addToast("タイムライン取得エラー:不明")
      }
      console.error("fetchFeedsエラー:", err)
      return null
    }
  }

  async function getFeeds(category='index', page=0, update=false) {
    if (itemsLoading) {return}
    setItemsLoading(true)
    let result = feeds.find(feed => feed.category === category && feed.page === page)
    if (result) {
      if (update) {
        if (new Date() - new Date(result.fetched_at) > 1000 * 5) {
            result.feed = await fetchFeeds(category, page)
            result.fetched_at = new Date()
            setFeeds(prevFeeds => prevFeeds.map(feed => 
              feed.category === category && feed.page === page ? result : feed
            ))
        } else {
          addToast('エラー/間隔をあけてください')
        }
      }
    } else {
      result = await fetchFeeds(category, page)
      setFeeds(prevFeeds => [...prevFeeds, {category, page, feed: result, fetched_at: new Date()}])
    }
    setItemsLoading(false)
  }

  async function fetchItems(category = '') {
    setItemsLoading(true)
    if(false){
      // フェッチしない条件(短時間など)
      return
    }
    try {
      const res = await axios.post('/emojis', {category: '1'})
      setItems(res.data)
      
    } catch (err) {
      console.log(err.response ? 'アイテム取得エラー/クライアント' : 'アイテム取得エラー/サーバー')
    }
    setItemsLoading(false)
  }

  function getItems(aid) {// aidから取得
    // cache確認
    // なければfetchItem
  }

  return (
    <ItemsContext.Provider value={{
      itemsLoading, setItemsLoading,
      items, setItems,
      feeds, setFeeds,
      getFeeds, getItems
    }}>
      {children}
    </ItemsContext.Provider>
  )
}

export const useItemsContext = () => useContext(ItemsContext)
