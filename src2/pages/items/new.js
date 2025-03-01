import React, { useEffect, useState, useContext } from 'react'
import axios from '@/lib/axios'
import { useRouter } from 'next/router'
import { useToastsContext } from '@/contexts/toasts_context'

export default function New() {
  const router = useRouter()
  const { addToast } = useToastsContext
  const [itemContent, setItemContent] = useState('')

  async function createItem(e) {
    e.preventDefault()
    await axios.post('/items/create', {
      'content': itemContent
    })
    .then(res => {
      if (res.data.is_done) {
        console.log('item/create:完了')
        addToast(`投稿しました`)
        router.push('/')
        // router.push('/items/' + res.data.item_aid)
      } else {
        console.log('item/create:作成不可能')
      }
    })
    .catch(err => {
      console.log('item/create:通信エラー', err)
    })
  }

  return (
    <div className="main-container">
      <h1>作成</h1>
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
        .main-container {
          background: var(--main-container-background-color);
          padding: 5px;
        }
        .items {
        }
      `}</style>
    </div>
  )
}
