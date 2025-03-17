import { createContext, useContext, useState, useEffect } from 'react'
import axios from '@/lib/axios'

const TrendsContext = createContext()

export const TrendsContextProvider = ({ children }) => {
  const [trendsLoading, setTrendsLoading] = useState(false)
  const [trends, setTrends] = useState([])

  async function fetchTrends(category = '') {
    const index = trends.findIndex((t) => t.category === category)
    if (index !== -1) {
      if((Date.now() - trends[index].fetched_time) < 5 * 60 * 1000){
        return
      }
    }
    setTrendsLoading(true)
    await axios.post('/discovery', {category})
    .then(res => {
      const fetched_time = Date.now()
      const last_updated_at = res.data.last_updated_at
      const data = res.data.trends
      setTrends((prevTrends) => {
        const index = prevTrends.findIndex((t) => t.category === category)
        if (index !== -1) {
          const updatedTrends = [...prevTrends]
          updatedTrends[index] = { fetched_time, category, last_updated_at, data }
          return updatedTrends
        } else {
          return [...prevTrends, { fetched_time, category, last_updated_at, data }]
        }
      })
    })
    .catch(err => {
      console.log(err.response ? 'トレンド取得エラー/クライアント' : 'トレンド取得エラー/サーバー')
    })
    setTrendsLoading(false)
  }

  return (
    <TrendsContext.Provider value={{
      trendsLoading, setTrendsLoading,
      trends, setTrends,
      fetchTrends
    }}>
      {children}
    </TrendsContext.Provider>
  )
}

export const useTrendsContext = () => useContext(TrendsContext)
