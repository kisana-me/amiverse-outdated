import { createContext, useContext, useState, useEffect } from 'react'
import axios from '@/lib/axios'
import { useMainContext } from '@/contexts/main_context'
import { useToastsContext } from '@/contexts/toasts_context'

const StartupContext = createContext()

export const StartupContextProvider = ({ children }) => {
  const [initialLoading, setInitialLoading] = useState(true)
  const [initialLoadingMessage, setInitialLoadingMessage] = useState('開始中')
  const { fetchStatus } = useMainContext()
  const { addToast } = useToastsContext()

  async function startup() {
    setInitialLoadingMessage('問い合わせ中')
    setInitialLoading(true)
    await fetchStatus()
      .then(()=>{
        setInitialLoadingMessage('ロード完了')
      }).catch(()=>{
        setInitialLoadingMessage('ロード失敗')
        addToast(err.response ? 'アカウントエラー/startup' : 'サーバーエラー/startup')
      })
    setInitialLoading(false)
  }

  useEffect(() => {
    startup()
  },[])

  return (
    <StartupContext.Provider value={{
      initialLoading, setInitialLoading,
      initialLoadingMessage, setInitialLoadingMessage
    }}>
      {children}
    </StartupContext.Provider>
  )
}

export const useStartupContext = () => useContext(StartupContext)
