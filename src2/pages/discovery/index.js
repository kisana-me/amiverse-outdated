import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'
import axios from 'axios'

export default function index() {
  const { loggedIn } = useMainContext()
  const [trends, setTrends] = useState([])
  const [lastUpdated, setLastUpdated] = useState('')
  const [loading, setLoading] = useState(true)
  let ignore = false
  
  useEffect(() => {
    // 非同期関数を定義して即時実行
    const fetchData = async () => {
      if (!ignore) {
        setLoading(true)
        // fetch POST
        await axios.post('/discovery', {'page': 'page'})
        .then(res => {
          setTrends(res.data.trends || [])
          setLastUpdated(res.data.last_updated_at || '')
          setLoading(false)
        })
        .catch(err => {
          setLoading(false)
        })
      }
    }
    fetchData()
    return () => {ignore = true}
  },[])

  // 日付をフォーマットする関数
  const formatDate = (dateString) => {
    if (!dateString) return '';
    const date = new Date(dateString);
    return `${date.getFullYear()}年${date.getMonth() + 1}月${date.getDate()}日 ${date.getHours()}:${String(date.getMinutes()).padStart(2, '0')}`;
  }

  return (
    <>
      <h1>みつける</h1>
      <div className="div_1">
        <h2>検索</h2>
        <p>未実装</p>
      </div>
      
      <div className="trends-container">
        <h2>トレンド</h2>
        {loading ? (
          <>
            <div className="skeleton-last-updated"></div>
            <ul className="trends-list">
              {[...Array(5)].map((_, index) => (
                <li key={index} className="trend-item skeleton-item">
                  <span className="skeleton-word"></span>
                  <span className="skeleton-count"></span>
                </li>
              ))}
            </ul>
          </>
        ) : (
          <>
            {lastUpdated && (
              <p className="last-updated">最終更新: {formatDate(lastUpdated)}</p>
            )}
            <ul className="trends-list">
              {trends.map((trend, index) => (
                <li key={index} className="trend-item">
                  <span className="trend-word">{trend.word}</span>
                  <span className="trend-count">{trend.count}</span>
                </li>
              ))}
            </ul>
          </>
        )}
      </div>
      
      <style jsx>{`
        .div_1 {
        }
        
        .trends-container {
          margin-top: 20px;
          padding: 15px;
          border-radius: 12px;
        }
        
        .trends-container h2 {
          font-size: 18px;
          margin-bottom: 10px;
          color: #1d9bf0;
        }
        
        .last-updated {
          font-size: 12px;
          color: #536471;
          margin-bottom: 15px;
        }
        
        .trends-list {
          list-style-type: none;
          padding: 0;
          margin: 0;
        }
        
        .trend-item {
          display: flex;
          justify-content: space-between;
          padding: 10px 0;
          border-bottom: 1px solid #eff3f4;
        }
        
        .trend-word {
          font-weight: 500;
        }
        
        .trend-count {
          color: #536471;
          font-size: 14px;
        }
        
        .skeleton-last-updated {
          height: 12px;
          width: 150px;
          background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
          background-size: 200% 100%;
          animation: shimmer 1.5s infinite;
          border-radius: 4px;
          margin-bottom: 15px;
        }
        
        .skeleton-item {
          display: flex;
          justify-content: space-between;
          padding: 10px 0;
          border-bottom: 1px solid #eff3f4;
        }
        
        .skeleton-word {
          height: 16px;
          width: 120px;
          background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
          background-size: 200% 100%;
          animation: shimmer 1.5s infinite;
          border-radius: 4px;
        }
        
        .skeleton-count {
          height: 14px;
          width: 40px;
          background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
          background-size: 200% 100%;
          animation: shimmer 1.5s infinite;
          border-radius: 4px;
        }
        
        @keyframes shimmer {
          0% { background-position: 200% 0; }
          100% { background-position: -200% 0; }
        }
      `}</style>
    </>
  )
}
