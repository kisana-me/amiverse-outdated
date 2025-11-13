import React, { useEffect, useState, useContext } from 'react'
import { useRouter } from 'next/router'
import axios from '@/lib/axios'
import { useToastsContext } from '@/contexts/toasts_context'
import MainHeader from '@/components/layouts/main_header'

export default function New() {
  const router = useRouter()
  const { addToast } = useToastsContext()
  const [itemContent, setItemContent] = useState('')

  async function createItem(e) {
    e.preventDefault()
    await axios.post('/items/create', {
      'content': itemContent
    })
    .then(res => {
      if (res.data.is_done) {
        addToast(`投稿しました`)
        router.push('/')
        // router.push('/items/' + res.data.item_aid)
      } else {
        console.log(`アイテム作成:サーバーエラー, ${res.data}`)
        addToast('アイテム作成:サーバーエラー')
      }
    })
    .catch(err => {
      console.log(`アイテム作成:通信エラー, ${err.response}`)
      addToast('アイテム作成:通信エラー')
    })
  }

  return (
    <>
      <MainHeader>
        投稿
      </MainHeader>
      <div id="items">
        <form onSubmit={createItem}>
          <label>
            コンテンツ:
            <textarea value={itemContent} onChange={(e) => setItemContent(e.target.value)} />
          </label>
          <button type="submit">作成</button>
        </form>
      </div>
      <style jsx>{`
        .items {
        }
      `}</style>
    </>
  )
}
