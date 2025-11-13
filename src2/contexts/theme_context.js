import { createContext, useContext, useState, useEffect } from 'react'

const ThemeContext = createContext()

export const ThemeContextProvider = ({ children }) => {
  const [darkThreme, setDarkThreme] = useState(false)
  const darkThremeTrigger = () => setDarkThreme(!darkThreme)

  useEffect(() => {
    setDarkThreme(window.matchMedia('(prefers-color-scheme: dark)').matches)
  },[])

  const lightThremeGlobalStyles = `
    :root {
      --background-color: #ffffff;
      --font-color: #000000;
      --link-color: #46be1b;
      --border-color: #acacac;
      --transparent-background-color: #0000003f;
      --content-color: #ffffff;
      --shadow-color: #808080;
      --blur-color: #ffffff88;
      --primary-color: #0000ff;
      --button-color: #000000;
      --button-font-color: #ffffff;
      --hover-color: #b5b5b588;
      --inconspicuous-font-color: #6b6b6b;
      --inconspicuous-background-color: #d8d8d8;
    }
  `

  const  darkThremeGlobalStyles = `
    :root {
      --background-color: #000000;
      --font-color: #ffffff;
      --link-color: #6ef744;
      --border-color: #7c7c7c;
      --transparent-background-color: #00000060;
      --content-color: #141414;
      --shadow-color: #808080;
      --blur-color: #00000088;
      --primary-color: #0000df;
      --button-color: #ffffff;
      --button-font-color: #000000;
      --hover-color: #ffffff88;
      --inconspicuous-font-color: #bcbcbc;
      --inconspicuous-background-color: #444444;
    }
  `

  return (
    <ThemeContext.Provider value={{
      darkThreme, setDarkThreme, darkThremeTrigger
    }}>
      <style>{darkThreme ? darkThremeGlobalStyles : lightThremeGlobalStyles}</style>
      {children}
    </ThemeContext.Provider>
  )
}

export const useThemeContext = () => useContext(ThemeContext)
