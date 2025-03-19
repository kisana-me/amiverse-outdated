import { useEffect, useState } from "react"
import { useRouter } from "next/router"

export default function ScrollRestoration() {
  const router = useRouter()
  const [scrollPositions, setScrollPositions] = useState({})

  useEffect(() => {
    const saveScrollPosition = () => {
      console.log('設定')
      setScrollPositions((prev) => {
        const newPositions = { ...prev }
        if (window.scrollY === 0) {
          delete newPositions[router.asPath]
        } else {
          newPositions[router.asPath] = window.scrollY
        }
        return newPositions
      })
    }

    const restoreScrollPosition = () => {
      setTimeout(() => {
        window.scrollTo(0, scrollPositions[router.asPath] || 0)
      }, 0)
      console.log('復活', scrollPositions)
    }

    window.addEventListener("beforeunload", saveScrollPosition)
    router.events.on("routeChangeStart", saveScrollPosition)

    router.beforePopState(() => {
      restoreScrollPosition()
      return true
    })

    restoreScrollPosition()

    return () => {
      window.removeEventListener("beforeunload", saveScrollPosition)
      router.events.off("routeChangeStart", saveScrollPosition)
    }
  }, [router])

  return null
}