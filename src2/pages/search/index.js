import React, { useEffect, useState } from 'react'
import { useRouter } from 'next/router'
import MainHeader from '@/components/layouts/main_header'
import Item from '@/components/items/item'
import axios from '@/lib/axios'

export default function Search() {
  const router = useRouter()
  const [searchQuery, setSearchQuery] = useState('')
  const [searchInput, setSearchInput] = useState('')
  const [searchLoading, setSearchLoading] = useState(true)
  const [searchedItems, setSearchedItems] = useState([])

  const handleSearchChange = (e) => {
    setSearchInput(e.target.value)
  }

  const handleSearchClick = () => {
    if (searchInput) {
      router.push(`/search?query=${searchInput}`, undefined, { shallow: true })
    }
  }

  async function fetchItems(query) {
    await axios.post('/search', {query})
      .then(res => {
        setSearchedItems(res.data)
      })
      .catch(err => {
        console.log("er")
      })
    setSearchLoading(false)
  }

  useEffect(() => {
    if (router.query.query) {
      setSearchQuery(router.query.query)
      setSearchInput(router.query.query)
      console.log('検索中')
      fetchItems(router.query.query)
    } else {
      console.log('検索内容を入力')
    }
  }, [router.query.query])

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
      <div className="search-container">
        <div>検索</div>
        {searchLoading ? (
          <p>'{searchQuery}'について検索中...</p>
        ) : searchedItems.length > 0 ? (
          searchedItems.map(item => (
            <Item key={item.aid} item={item} />
          ))
        ) : (
          <p>結果が見つかりませんでした。</p>
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
