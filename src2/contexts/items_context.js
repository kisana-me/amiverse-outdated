import { createContext, useContext, useState, useEffect } from 'react'
import axios from '@/lib/axios'

const ItemsContext = createContext()

export const ItemsContextProvider = ({ children }) => {
  const [itemsLoading, setItemsLoading] = useState(false)
  const [items, setItems] = useState([])

  async function fetchItems(category = '') {
    if(false){
      // フェッチしない条件(短時間など)
      return
    }
    setItemsLoading(true)
    try {
      const res = await axios.post('/emojis', {category: '1'})
      setItems(res.data)
      
    } catch (err) {
      console.log(err.response ? 'アイテム取得エラー/クライアント' : 'アイテム取得エラー/サーバー')
    }
    itemsLoading(false)
  }

  useEffect(() => {
    
  },[])

  return (
    <ItemsContext.Provider value={{
      itemsLoading, setItemsLoading,
      items, setItems
    }}>
      {children}
    </ItemsContext.Provider>
  )
}

export const useItemsContext = () => useContext(ItemsContext)
