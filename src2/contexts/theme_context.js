import { createContext, useContext, useState, useEffect } from 'react'

const ThemeContext = createContext()

export const ThemeContextProvider = ({ children }) => {
  const [darkThreme, setDarkThreme] = useState(false)
  const darkThremeTrigger = () => setDarkThreme(!darkThreme)

  useEffect(() => {
    setDarkThreme(window.matchMedia('(prefers-color-scheme: dark)').matches)
  },[])

  return (
    <ThemeContext.Provider value={{
      darkThreme, setDarkThreme, darkThremeTrigger
    }}>
      {children}
    </ThemeContext.Provider>
  )
}

export const useThemeContext = () => useContext(ThemeContext)
