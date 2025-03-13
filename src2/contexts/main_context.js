import { createContext, useContext, useState, useEffect } from 'react'
import { useRouter } from 'next/router'
import axios from '@/lib/axios'

const MainContext = createContext()

export const MainContextProvider = ({ children }) => {
  const [loading, setLoading] = useState(true)
  const [loadingMessage, setLoadingMessage] = useState('セッション作成中')
  const [loggedIn, setLoggedIn] = useState(false)
  const [currentAccount, setCurrentAccount] = useState({})
  const router = useRouter()

  const loggedInPage = () => {
    if(!loggedIn){
      addToast(`${router.pathname}へアクセスするにはログインしてください`)
      console.log(flashMessage)
      router.push('/')
      return
    }
  }
  const loggedOutPage = () => {
    if(loggedIn){
      addToast(`ログイン済みですので${router.pathname}へアクセスできません`)
      router.push('/')
      return
    }
  }

  async function fetchCurrentAccount() {
    try {
      const res = await axios.post('/sessions/check')
      setLoggedIn(res.data.logged_in)
      setCurrentAccount(res.data.account)
    } catch (err) {
      setLoggedIn(false)
      setCurrentAccount({})
      addToast(err.response ? 'クライアントFCAエラー' : 'サーバーFCAエラー')
    }
  }

  async function startUp() {
    try {
      setLoadingMessage('アカウント情報確認中')
      const res = await axios.post('/sessions/check')
      setLoggedIn(res.data.logged_in)
      setCurrentAccount(res.data.account)
    } catch (err) {
      addToast(err.response ? 'アカウントエラー' : 'サーバーエラー')
    }
    setLoadingMessage('ロード完了')
    setLoading(false)
  }

  useEffect(() => {
    startUp()
  },[])

  return (
    <MainContext.Provider value={{
      loading, setLoading,
      loadingMessage, setLoadingMessage,
      loggedIn, setLoggedIn,
      currentAccount, setCurrentAccount,
      loggedInPage, loggedOutPage,
      fetchCurrentAccount
    }}>
      {children}
    </MainContext.Provider>
  )
}

export const useMainContext = () => useContext(MainContext)
