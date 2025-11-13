import { useEffect } from 'react'
import Link from 'next/link'
import { formatRelativeTime } from '@/lib/format_time'

export default function Trend({ category, last_updated_at, trend }) {

  useEffect(() => {
  }, [])

  return (
    <>
      <div className="trend">
        <div className="trend-top">
          <div className="trend-top-content">
            <div className="trend-top-title">トップタイトル</div>
            <div className="trend-top-summary">トップ要約</div>
          </div>
        </div>

        <div className="trend-list">
          {trend.map((t, index) => (
            <Link href={`/search?query=${t.word}`} key={index} legacyBehavior>
              <a className="trend-item">
                <div className="trend-item-top">{index + 1}位</div>
                <div className="trend-item-word">{t.word}</div>
                <div className="trend-item-bottom">{t.count}件</div>
              </a>
            </Link>
          ))}
        </div>

        <div className="trend-bottom">
          <span>Category: {category || 'general'}</span><br />
          <span>Last updated at: {formatRelativeTime(new Date(last_updated_at))}</span>
        </div>
      </div>

      <style jsx>{`
        .trend-top {
          position: relative;
          background: linear-gradient(45deg, transparent, #a7eb88);
          aspect-ratio: 2 / 1;
        }
        .trend-top-content {
          width: 100%;
          height: 50%;
          padding: 15px;
          box-sizing: border-box;
          position: absolute;
          bottom: 0;
          box-sizing: border-box;
          display: flex;
          flex-direction: column;
          justify-content: flex-end;
          background: linear-gradient(0deg, #000000, #00000000);
        }
        .trend-top-title {
          font-weight: bold;
        }

        .trend-list {
          padding: 15px 0;
        }
        .trend-item {
          padding: 10px 15px;
          color: var(--font-color);
          text-decoration: none;
          display: flex;
          flex-direction: column;
        }
        .trend-item:hover {
          background: var(--hover-color);
        }
        .trend-item-top, .trend-item-bottom {
          color: var(--inconspicuous-font-color);
          font-size: small;
        }
        .trend-item-word {
          font-weight: bold;
        }

        .trend-bottom {
          padding: 15px;
          color: var(--inconspicuous-font-color);
          font-size: small;
        }
      `}</style>
    </>
  )
}
