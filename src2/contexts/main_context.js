import { createContext, useContext, useState, useEffect } from 'react'
import { useRouter } from 'next/router'
import axios from '@/lib/axios'
import { useToastsContext } from '@/contexts/toasts_context'

const MainContext = createContext()

export const MainContextProvider = ({ children }) => {
  const [loggedIn, setLoggedIn] = useState(false)
  const [currentAccount, setCurrentAccount] = useState({})
  const { addToast } = useToastsContext()
  const router = useRouter()

  const loggedInPage = () => {
    if(!loggedIn){
      addToast(`ログインしてください`)
      router.push('/')
      return
    }
  }
  const loggedOutPage = () => {
    if(loggedIn){
      addToast(`ログイン済みです`)
      router.push('/')
      return
    }
  }
  async function fetchStatus() {
    try {
      const res = await axios.post('/sessions/check')
      if(res.data.logged_in) {
        setCurrentAccount(res.data.account)
      } else {
        setCurrentAccount({})
      }
      setLoggedIn(res.data.logged_in)
    } catch (err) {
      setLoggedIn(false)
      setCurrentAccount({})
    }
  }

  return (
    <MainContext.Provider value={{
      loggedIn, setLoggedIn,
      currentAccount, setCurrentAccount,
      loggedInPage, loggedOutPage,
      fetchStatus
    }}>
      {children}
    </MainContext.Provider>
  )
}

export const useMainContext = () => useContext(MainContext)
