import { createContext, useContext, useState, useEffect } from 'react'
import { useRouter } from 'next/router'
import axios from '@/lib/axios'

const MainContext = createContext()

export const MainContextProvider = ({ children }) => {
  const [loading, setLoading] = useState(true)
  const [loadingMessage, setLoadingMessage] = useState('セッション作成中')
  const [loggedIn, setLoggedIn] = useState(false)
  const [currentAccount, setCurrentAccount] = useState({})
  const [flashKind, setFlashKind] = useState('')//廃止
  const [flashMessage, setFlashMessage] = useState('')//廃止
  const [toastNotifications, setToastNotifications] = useState([])//移行先
  const [feeds, setFeeds] = useState({})
  const [modal, setModal] = useState(false)
  const modalTrigger = () => setModal(!modal)
  const [darkThreme, setDarkThreme] = useState(false)
  const darkThremeTrigger = () => setDarkThreme(!darkThreme)
  const [overlay, setOverlay] = useState(false)
  const router = useRouter()
  const loggedInPage = () => {
    if(!loggedIn){
      setFlashKind('info')
      setFlashMessage(`${router.pathname}へアクセスするにはログインしてください`)
      console.log(flashMessage)
      router.push('/')
      return
    }
  }
  const loggedOutPage = () => {
    if(loggedIn){
      setFlashKind('info')
      setFlashMessage(`ログイン済みですので${router.pathname}へアクセスできません`)
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
      setFlashKind('danger')
      setFlashMessage(err.response ? 'クライアントFCAエラー' : 'サーバーFCAエラー')
    }
  }

  async function startUp() {
    try {
      setLoadingMessage('アカウント情報確認中')
      const res = await axios.post('/sessions/check')
      setLoggedIn(res.data.logged_in)
      setCurrentAccount(res.data.account)
    } catch (err) {
      setFlashKind('danger')
      setFlashMessage(err.response ? 'アカウントエラー' : 'サーバーエラー')
    }
    setLoadingMessage('ロード完了')
    setLoading(false)
  }

  useEffect(() => {
    setDarkThreme(window.matchMedia('(prefers-color-scheme: dark)').matches)
    startUp()
  },[])

  // overlayの状態が変更されたときにスクロールを制御
  useEffect(() => {
    const preventDefault = (e) => {
      e.preventDefault()
    }
    if (overlay) {
      // スクロールを無効化
      document.addEventListener('wheel', preventDefault, { passive: false })
      document.addEventListener('touchmove', preventDefault, { passive: false })
    } else {
      // スクロールを有効化
      document.removeEventListener('wheel', preventDefault)
      document.removeEventListener('touchmove', preventDefault)
    }
    return () => {
      // クリーンアップ
      document.removeEventListener('wheel', preventDefault)
      document.removeEventListener('touchmove', preventDefault)
    }
  }, [overlay])

  return (
    <MainContext.Provider value={{
      loading, setLoading,
      loadingMessage, setLoadingMessage,
      loggedIn, setLoggedIn,
      currentAccount, setCurrentAccount,
      flashKind, setFlashKind,
      flashMessage, setFlashMessage,
      toastNotifications, setToastNotifications,
      feeds, setFeeds,
      modal, setModal, modalTrigger,
      darkThreme, setDarkThreme, darkThremeTrigger,
      loggedInPage, loggedOutPage,
      fetchCurrentAccount,
      overlay, setOverlay
    }}>
      {children}
    </MainContext.Provider>
  )
}

export const useMainContext = () => useContext(MainContext)
