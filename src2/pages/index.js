import React, { useEffect, useState } from 'react'
import axios from '@/lib/axios'
import Link from 'next/link'
import MainHeader from '@/components/layouts/main_header'
import Items from '@/components/items/items'
import { useMainContext } from '@/contexts/main_context'
import { useOverlayContext } from '@/contexts/overlay_context'
import { useToastsContext } from '@/contexts/toasts_context'
import { useItemsContext } from '@/contexts/items_context'

export default function Home() {
  const {loading, loggedIn, currentAccount } = useMainContext()
  const { feeds, setFeeds } = useItemsContext()
  const { isHeaderMenuOpen, headerMenuTrigger, asideMenuTrigger } = useOverlayContext()

  const [loadItems, setloadItems] = useState(true)
  const [updating, setUpdating] = useState(false)
  const [page, setPage] = useState(1)

  const { addToast } = useToastsContext()

  async function updateFeed() {
    setUpdating(true)
    await fetchItems()
    setUpdating(false)
  }

  async function fetchItems() {
    await axios.post('/feed/index', {'page': page})
      .then(res => {
        setFeeds({...feeds, index: res.data})
        setloadItems(false)
      })
      .catch(err => {
        if (err.response) {
          addToast('タイムライン取得エラー:未ログイン')
        } else {
          addToast('タイムライン取得エラー:不明')
        }
        setloadItems(false)
      })
  }
  async function created() {
    const ActionCable = await import('actioncable')
    const cable = ActionCable.createConsumer(process.env.NEXT_PUBLIC_FRONT_WS_URL)
    cable.subscriptions.create( "ItemsChannel",{
      connected() {
        console.log('connected')
      },
      disconnected() {
        console.log('disconnected')
      },
      received(data) {
        let li = document.createElement("li")
        li.textContent = data.item.content
        document.getElementById('items').appendChild(li)
        return console.log(data['item']['content'])
      }
    })
  }

  useEffect(() => {
    if (loading) {
      return
    }
    if ('index' in feeds) {
      setloadItems(false)
    } else {
      fetchItems()
    }
  },[loading])

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
        <Items items={feeds['index']} loadItems={loadItems} />
      </div>
    </>
  )
}
