import { createContext, useContext, useState, useEffect } from 'react'
import { useRouter } from 'next/router'
import axios from '@/lib/axios'

const MainContext = createContext()

export const MainContextProvider = ({ children }) => {
  const [loggedIn, setLoggedIn] = useState(false)
  const [currentAccount, setCurrentAccount] = useState({})
  // const [scrollPositions, setScrollPositions] = useState(0)
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

  // useEffect(() => {
  //   const handleRouteChange = (url) => {
  //     console.log("Page changed to:", url)
  //     console.log("scroll:", document.scrollingElement.scrollTop)
  //     console.log("prev-scroll:", scrollPositions)
  //     setScrollPositions(document.scrollingElement.scrollTop)
  //   }
  //   const handleHistoryChange = (e) => {
  //     console.log("his changed to:", e)
  //   }
  //   router.events.on("routeChangeStart", handleRouteChange)
  //   router.events.on("beforeHistoryChange", handleHistoryChange)
  //   return () => {
  //     router.events.off("routeChangeStart", handleRouteChange)
  //     router.events.off("beforeHistoryChange", handleHistoryChange)
  //   }
  // }, [router])

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
