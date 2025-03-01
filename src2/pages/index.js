import React, { useEffect, useState } from 'react'
import axios from '@/lib/axios'
import Link from 'next/link'
import HeaderText from '@/components/header_text'
import Items from '@/components/items/items'
import { useMainContext } from '@/contexts/main_context'
import { useToastsContext } from '@/contexts/toasts_context'

export default function Home() {
  const {loading, loggedIn, currentAccount, feeds, setFeeds} = useMainContext()
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
        addToast('タイムライン取得完了')
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
      console.log("indexあり", feeds)
    } else {
      fetchItems()
      console.log("indexなし", feeds)
    }
  },[loading])

  return (
    <>
      <HeaderText
        headerText={'Home'}
      >
        {(() => {
          if (loggedIn) {
            return (
              <div>
                フロントが未完成で不安定な為、
                <Link href="https://api.amiverse.net/">API</Link>
                バージョンのご使用をお勧めします。
                こんにちは、{currentAccount.name}さん。
              </div>
            )
          } else {
            return (
              <div>
                Amiverse.netへようこそ！
                フロントが未完成で不安定な為、
                <Link href="https://api.amiverse.net/">API</Link>
                バージョンのご使用をお勧めします。
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
      </HeaderText>
    </>
  )
}
