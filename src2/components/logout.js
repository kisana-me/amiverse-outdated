import React, { useContext } from 'react'
import axios from '@/lib/axios'
import { useMainContext } from '@/contexts/main_context'
import { useRouter } from 'next/router'
import { useToastsContext } from '@/contexts/toasts_context'

export default function Logout() {
  const { loggedIn, setLoggedIn } = useMainContext()
  const { addToast } = useToastsContext()
  const router = useRouter()

  const handleLogout = async () => {
    await axios.delete('/logout')
      .then(response => {
        if (!response.data.logged_in) {
          setLoggedIn(false)
          router.push('/')
          addToast('ログアウトしました')
        } else {
          addToast('ログアウトされてません')
        }
      })
      .catch(err => {
        addToast('ログアウトエラー')
      })
  }

  return (
    <>
      {loggedIn ? <button onClick={handleLogout}>ログアウト</button> : ''}
      <style jsx="true">{`
      `}</style>
    </>
  )
}