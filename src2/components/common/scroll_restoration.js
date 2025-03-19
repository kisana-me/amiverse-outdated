import { useEffect, useState } from "react"
import { useRouter } from "next/router"

export default function ScrollRestoration() {
  const router = useRouter()
  const [scrollPositions, setScrollPositions] = useState({})

  useEffect(() => {
    const saveScrollPosition = () => {
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