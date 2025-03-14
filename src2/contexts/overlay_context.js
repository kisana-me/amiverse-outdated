import { createContext, useContext, useState, useEffect } from 'react'
import { useRouter } from 'next/router'

const OverlayContext = createContext()

export const OverlayContextProvider = ({ children }) => {
  const [overlay, setOverlay] = useState(false)
  const [menuOverlay, setMenuOverlay] = useState(false)
  const [isHeaderMenuOpen, setIsHeaderMenuOpen] = useState(false)
  const [isAsideMenuOpen, setIsAsideMenuOpen] = useState(false)
  const headerMenuTrigger = () => setIsHeaderMenuOpen(prevState => !prevState)
  const asideMenuTrigger = () => setIsAsideMenuOpen(prevState => !prevState)

  const router = useRouter()

  const closeMenu = () => {
    setMenuOverlay(false)
    setIsHeaderMenuOpen(false)
    setIsAsideMenuOpen(false)
  }

  useEffect(() => {
    closeMenu()
  },[router])

  useEffect(() => {
    if (isHeaderMenuOpen || isAsideMenuOpen) {
      setMenuOverlay(true)
    } else {
      setMenuOverlay(false)
    }
  }, [isHeaderMenuOpen, isAsideMenuOpen])

  useEffect(() => {
    if (overlay || menuOverlay) {
      // document.documentElement.style.overflow = 'hidden'
      // document.body.style.marginRight = 'hidden'
    } else {
      // document.documentElement.style.overflow = 'auto'
      // document.body.style.marginRight = '0'
    }
  }, [overlay, menuOverlay])

  return (
    <OverlayContext.Provider value={{
      overlay, setOverlay,
      menuOverlay, setMenuOverlay,
      isHeaderMenuOpen, setIsHeaderMenuOpen, headerMenuTrigger,
      isAsideMenuOpen, setIsAsideMenuOpen, asideMenuTrigger,
      closeMenu
    }}>
      {children}
    </OverlayContext.Provider>
  )
}

export const useOverlayContext = () => useContext(OverlayContext)
