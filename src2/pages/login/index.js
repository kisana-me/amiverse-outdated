import React, { useEffect, useState, useContext } from 'react'
import axios from '@/lib/axios'
import Login from '@/components/login'
import Logout from '@/components/logout'
import { useRouter } from 'next/router'
import { useMainContext } from '@/contexts/main_context'
import { useStartupContext } from '@/contexts/startup_context'
import MainHeader from '@/components/layouts/main_header'

export default function index() {
  const { loggedIn, loggedOutPage, fetchStatus } = useMainContext()
  const { initialLoading } = useStartupContext()
  const router = useRouter()
  const [currentMessage, setCurrentMessage] = useState('待機')
  const [nameId, setNameId] = useState('')
  const [password, setPassword] = useState('')

  useEffect(() => {
    if (initialLoading) {return}
    loggedOutPage()
  }, [initialLoading])

  async function loginPost(e) {
    e.preventDefault()
    setCurrentMessage('送信中')
    await axios.post('/login', {
      'name_id': nameId,
      'password': password,
    })
    .then(res => {
      if (res.data.logged_in) {
        setCurrentMessage('完了・データ取得中')
        fetchStatus().then(res => {
          setCurrentMessage('ログイン完了')
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
    })
  }

  return (
    <>
      <MainHeader>
        ログイン
      </MainHeader>
      <div>
        <p>状態：{currentMessage}</p>
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
      </div>
    </>
  )
}