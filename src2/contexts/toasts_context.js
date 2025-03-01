import { createContext, useContext, useState, useEffect } from 'react'

const ToastsContext = createContext()

export const ToastsContextProvider = ({ children }) => {
  const [toasts, setToasts] = useState([])

  function addToast(message) {
    const newToast = {
      date: Date.now(),
      status: "show",
      message
    }
    setToasts((prevToasts) => [...prevToasts, newToast])
    setTimeout(() => {
      setToasts((prevToasts) =>
        prevToasts.map((toast) =>
          toast.date === newToast.date ? { ...toast, status: "hidden" } : toast
        )
      )
    }, 5000)
  }

  useEffect(() => {
    
  },[])

  return (
    <ToastsContext.Provider value={{ toasts, addToast }}>
      {children}
    </ToastsContext.Provider>
  )
}

export const useToastsContext = () => useContext(ToastsContext)
