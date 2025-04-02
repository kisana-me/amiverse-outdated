import { createContext, useContext, useState, useEffect } from 'react'
import axios from '@/lib/axios'
import { useToastsContext } from '@/contexts/toasts_context'

const ItemsContext = createContext()
const itemsType=[
  {
    aid: 'aid',
    content: 'content',
    fetched_at: new Date(),
    replies: ['rep-aid', 'rep-aid'],
    quoters: ['quo-aid', 'quo-aid'],
    reactions: [{'reaction':'aid', 'emoji':'aid'}],
  }
]
const feedsType=[
  {
    category: 'index or following or current',
    page: 0,
    feed: [
      {
        object: 'item or diffuse',
        item_aid: '{aid: ...}',
        account_aid: 'diffuseの場合のみ'
      }
    ],
    fetched_at: new Date()
  }
]

export const ItemsContextProvider = ({ children }) => {
  const { addToast } = useToastsContext()
  const [itemsLoading, setItemsLoading] = useState(false)
  const [items, setItems] = useState([])
  const [feeds, setFeeds] = useState([])

  function updateItems(item) {
    const updatedItem = {
      ...item,
      fetched_at: Date.now()
    }
    setItems(prevItems => {
      let newItems = [...prevItems]
      const index = newItems.findIndex(i => i.aid === item.aid)
      if (index === -1) {
        newItems.push(updatedItem)
      } else {
        newItems[index] = { ...newItems[index], ...updatedItem }
      }
      return newItems
    })
    return updatedItem
  }

  function updateItemsFromFeed(feed) {
    setItems(prevItems => {
      let newItems = [...prevItems]
      feed.forEach(f => {
        const index = newItems.findIndex(item => item.aid === f.item.aid)
        const updateItem = {
          ...f.item,
          fetched_at: Date.now()
        }
        if (index === -1) {
          newItems.push(updateItem)
        } else {
          newItems[index] = { ...newItems[index], ...updateItem }
        }
      })
      return newItems
    })
  }

  function updateFeeds(category, page, feed) {
    const formed_feed = feed.map(({ object, item, diffuser }) => ({
      object,
      item_aid: item.aid,
      ...(object === 'diffuse' && diffuser ? { diffuser_aid: diffuser.aid } : {})
    }))

    setFeeds(prevFeeds => {
      const existingFeedIndex = prevFeeds.findIndex(feed => feed.category === category && feed.page === page)
      if (existingFeedIndex !== -1) {
        const updatedFeeds = [...prevFeeds]
        updatedFeeds[existingFeedIndex] = {
          ...updatedFeeds[existingFeedIndex],
          feed: formed_feed,
          fetched_at: new Date()
        }
        return updatedFeeds
      } else {
        return [...prevFeeds, { category, page, feed: formed_feed, fetched_at: new Date() }]
      }
    })
  }

  async function fetchFeeds(category = "index", page = 0) {
    try {
      const res = await axios.post(`/feeds/${category}`, { page })
      return res.data
    } catch (err) {
      if (err.response) {
        addToast("タイムライン取得エラー:未ログイン")
      } else {
        addToast("タイムライン取得エラー:不明")
      }
      console.error("fetchFeedsエラー:", err)
      return []
    }
  }

  async function loadFeeds(category='index', page=0, update=false) {
    if (itemsLoading) {return}
    setItemsLoading(true)
    let result = feeds.find(feed => feed.category === category && feed.page === page)
    if (result) {
      if (update) {
        if (new Date() - new Date(result.fetched_at) > 1000 * 5) {
          const fetched_feed = await fetchFeeds(category, page)
          updateFeeds(category, page, fetched_feed)
          updateItemsFromFeed(fetched_feed)
        } else {
          addToast('エラー/間隔をあけてください')
        }
      }
    } else {
      const fetched_feed = await fetchFeeds(category, page)
      updateFeeds(category, page, fetched_feed)
      updateItemsFromFeed(fetched_feed)
    }
    setItemsLoading(false)
  }

  function getFeeds(category = 'index') {
    const itemMap = new Map(items.map(item => [item.aid, item]))

    const allPageFeed = []
    let page = 0
    while (true) {
      const feedData = feeds.find(feed => feed.category === category && feed.page === page)
      if (!feedData) break
      allPageFeed.push(...feedData.feed)
      page++
    }

    return allPageFeed.map(entry => {
      return {
        ...entry,
        item: itemMap.get(entry.item_aid) || null
      }
    }).filter(entry => entry.item !== null)
  }

  async function fetchItems(aid) {
    setItemsLoading(true)
    let result = null
    if(false){
      // フェッチしない条件(短時間など)
      return result
    }
    try {
      const res = await axios.post('/items/' + aid)
      updateItems(res.data)
      result = res.data
    } catch (err) {
      const errTxt = err.response ? 'アイテム取得エラー/クライアント' : 'アイテム取得エラー/サーバー'
      console.log(errTxt)
      addToast(errTxt)
    }
    setItemsLoading(false)
    return result
  }

  async function getItems(aid) {
    const cached_item = items.find(item => item.aid === aid)
    if (cached_item) {
      if(new Date() - new Date(cached_item.fetched_at) > 1000 * 5){
        // 5秒以上経過
      } else {}
      return cached_item
    } else {
      const fetched_item = await fetchItems(aid)
      return updateItems(fetched_item)
    }
  }

  return (
    <ItemsContext.Provider value={{
      itemsLoading,
      items, feeds,
      updateItems,
      loadFeeds, getFeeds,
      getItems
    }}>
      {children}
    </ItemsContext.Provider>
  )
}

export const useItemsContext = () => useContext(ItemsContext)
