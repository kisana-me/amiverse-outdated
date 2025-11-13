import { useEffect } from 'react'
import { useTrendsContext } from '@/contexts/trends_context'
import { formatRelativeTime } from '@/lib/format_time'

export default function TrendsMiniList() {
  const { trends, trendsLoading, fetchTrends } = useTrendsContext()

  useEffect(() => {
    fetchTrends()
  }, [])

  return (
    <>
      {trendsLoading ? (
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
          {trends.map(({ category, last_updated_at, data }) => (
            <div key={category}>
              <h2>c:{category}</h2>
              <p>Last updated at: {formatRelativeTime(new Date(last_updated_at))}</p>
              <ul className="trends-list">
                {data.map((t, index) => (
                  <li key={index} className="trends-item">
                    <span className="trends-word">{t.word}</span>
                    <span className="trends-count">{t.count}</span>
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </>
      )}
      <style jsx>{`
        
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
        
        .trends-item {
          display: flex;
          justify-content: space-between;
          padding: 10px 0;
          border-bottom: 1px solid #eff3f4;
        }
        
        .trends-word {
          font-weight: 500;
        }
        
        .trends-count {
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
