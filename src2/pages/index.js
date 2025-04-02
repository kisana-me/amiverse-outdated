import React, { useEffect, useState } from 'react'
import axios from '@/lib/axios'
import Link from 'next/link'
import MainHeader from '@/components/layouts/main_header'
import FeedItems from '@/components/feeds/feed_items'
import { useMainContext } from '@/contexts/main_context'
import { useOverlayContext } from '@/contexts/overlay_context'
import { useToastsContext } from '@/contexts/toasts_context'
import { useItemsContext } from '@/contexts/items_context'
import { useStartupContext } from '@/contexts/startup_context'

export default function Home() {
  const { loggedIn, currentAccount } = useMainContext()
  const { initialLoading } = useStartupContext()
  const { addToast } = useToastsContext()
  const { itemsLoading, getFeeds, feeds, loadFeeds } = useItemsContext()

  const [indexFeed, setIndexFeed] = useState([])
  const [updating, setUpdating] = useState(false)

  async function updateFeed() {
    setUpdating(true)
    await loadFeeds(undefined, undefined, true)
    setUpdating(false)
  }

  useEffect(() => {
    if (initialLoading || itemsLoading) {return}
    setIndexFeed(getFeeds('index'))
  }, [feeds])

  useEffect(() => {
    (async () => {
      if (initialLoading) {return}
      await loadFeeds()
    })()
  }, [initialLoading])

  return (
    <>
      <MainHeader>
        ホーム | フォロー中 | 現在
      </MainHeader>
      {(() => {
        if (loggedIn) {
          return (
            <div>
              こんにちは、{currentAccount.name}さん。
            </div>
          )
        } else {
          return (
            <div>
              Amiverse.netへようこそ！
              <Link href="/login">ログイン</Link>
              <Link href="/signup">サインアップ</Link>
            </div>
          )
        }
      })()}
      
      <button onClick={updateFeed} disabled={updating}>{updating ? '更新中' : 'フィードを更新'}</button>
      <Link href="/items/new">作成</Link>
      <div>
        <FeedItems items={indexFeed} loadItems={initialLoading || itemsLoading} />
      </div>
    </>
  )
}
