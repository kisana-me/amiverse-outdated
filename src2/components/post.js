import React, { useState, useContext } from 'react'
import axios from '@/lib/axios'
import { useMainContext } from '@/contexts/main_context'

export default function Post() {
  const { loggedIn, setFlash } = useMainContext()
  const [content, setContent] = useState('')
  const [nsfw, setNsfw] = useState(false)
  const [cw, setCw] = useState(false)

  const handleSubmit = async (e) => {
    e.preventDefault()
    if (loggedIn) {
      await axios.post('/items/create', { content, cw })
        .then(res => {
          if (res.data.success) {
            setFlash('投稿したよ')
            setContent('')
            setNsfw(false)
            setCw(false)
            /* apiに送信後、frontからuse serverでapを配信したい */
          } else {
            setFlash('間違った入力')
          }
        })
        .catch(err => {
          setFlash(`投稿通信例外${err}`)
        })
    } else {
      setFlash('ろぐいんしてください')
    }
  }

  return (
    <>
      <div>
        <form onSubmit={handleSubmit}>
          <label>
            内容:
            <textarea value={content} onChange={(e) => setContent(e.target.value)} />
          </label>
          <br />
          <label>
            Nsfw:
            <input type="checkbox" checked={nsfw} onChange={(e) => setNsfw(!nsfw)} />
          </label>
          <br />
          <label>
            Cw:
            <input type="checkbox" checked={cw} onChange={(e) => setCw(!cw)} />
          </label>
          <br />
          <button type="submit">送信</button>
        </form>
      </div>
      <style jsx>{`
      `}</style>
    </>
  )
}