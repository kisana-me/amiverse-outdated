import { createContext, useContext, useState, useEffect } from 'react'
import { useRouter } from 'next/router'

const CommonContext = createContext()

export const CommonContextProvider = ({ children }) => {
  const [overlay, setOverlay] = useState(false)
  const [isMenuOpen, setIsMenuOpen] = useState(false)
  const menuTrigger = () => setIsMenuOpen(prevState => !prevState)

  const router = useRouter()

  useEffect(() => {
    setIsMenuOpen(false)
  },[router])

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
    <CommonContext.Provider value={{
      overlay, setOverlay,
      isMenuOpen, setIsMenuOpen, menuTrigger
    }}>
      {children}
    </CommonContext.Provider>
  )
}

export const useCommonContext = () => useContext(CommonContext)
