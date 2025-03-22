import React, { useEffect, useState, useContext } from 'react'
import { useRouter } from 'next/router'
import { useMainContext } from '@/contexts/main_context'
import MainHeader from '@/components/layouts/main_header'
import axios from 'axios'
import { formatRelativeTime } from '@/lib/format_time'
import { useStartupContext } from '@/contexts/startup_context'
import { useTrendsContext } from '@/contexts/trends_context'
import Trend from '@/components/trends/trend'
import SkeletonTrend from '@/components/trends/skeleton_trend'

export default function index() {
  const router = useRouter()
  const { initialLoading } = useStartupContext()
  const { trends, trendsLoading, fetchTrends } = useTrendsContext()
  const [lastUpdated, setLastUpdated] = useState('')
  const [searchInput, setSearchInput] = useState('')
  
  useEffect(() => {
    if (initialLoading) {return}
    fetchTrends()
  },[initialLoading])

  const handleSearchChange = (e) => {
    setSearchInput(e.target.value)
  }

  const handleSearchClick = () => {
    if (searchInput) {
      router.push(`/search?query=${searchInput}`)
    }
  }

  return (
    <>
      <MainHeader>
        <input
          type="search"
          value={searchInput}
          onChange={handleSearchChange}
          placeholder="検索ワードを入力"
          className="search-input"
        />
        <button onClick={handleSearchClick} className="search-button">
          🔎
        </button>
      </MainHeader>

      <div className="discovery">

          {trendsLoading ? (
            <>
              <SkeletonTrend />
            </>
          ) : (
            <>
              {trends.map(({ category, last_updated_at, data }, index) => (
                <Trend category={category} last_updated_at={last_updated_at} trend={data} key={index} />
              ))}
            </>
          )}

      </div>
      
      <style jsx>{`
        .search-input {
          min-width: 70%;
          height: 32px;
          border: 1px solid var(--border-color);
          border-radius: 7px;
          padding: 0 7px;
          background: inherit;
          color: var(--font-color);
          box-sizing: border-box;
        }
        .search-button {
          height: 32px;
          margin-left: 4px;
          border: 1px solid var(--border-color);
          border-radius: 7px;
          background: inherit;
          color: var(--inconspicuous-font-color);
          box-sizing: border-box;
        }
      `}</style>
    </>
  )
}
