import React, { useEffect, useState, useContext } from 'react'
import axios from '@/lib/axios'
import Login from '@/components/login'
import Logout from '@/components/logout'
import { useRouter } from 'next/router'
import { useMainContext } from '@/contexts/main_context'

export default function index() {
  const { fetchCurrentAccount, loadingMessage } = useMainContext()
  const router = useRouter()
  const [currentMessage, setCurrentMessage] = useState('')
  const [nameId, setNameId] = useState('')
  const [password, setPassword] = useState('')

  async function loginPost(e) {
    e.preventDefault()
    await axios.post('/login', {
      'name_id': nameId,
      'password': password,
    })
    .then(res => {
      if (res.data.logged_in) {
        setCurrentMessage('完了・データ取得中')
        fetchCurrentAccount().then(res => {
          setCurrentMessage('ログイン完了')
          console.log("ae")
          router.push('/')
        }).catch(err => {
          setCurrentMessage('アカウント取得エラー')
          console.log(err)
        })
      } else {
        setCurrentMessage('間違っています')
      }
    })
    .catch(err => {
      setCurrentMessage('通信例外')
      console.log(err)
    })
  }

  return (
    <>
      <main>
        <h1>ログイン</h1>
        <p>{currentMessage}</p>
        <form onSubmit={loginPost}>
          <label>
            ID:
            <input type="text" value={nameId} onChange={(e) => setNameId(e.target.value)} />
          </label>
          <br />
          <label>
            パスワード:
            <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} />
          </label>
          <br />
          <button type="submit">送信</button>
        </form>
        <Logout />
      </main>
    </>
  )
}