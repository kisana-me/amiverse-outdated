import React, { useContext } from 'react'
import axios from '@/lib/axios'
import { useMainContext } from '@/contexts/main_context'
import { useRouter } from 'next/router'

export default function Logout() {
  const { setLoginLoading, loggedIn, setLoggedIn, setFlash } = useMainContext()
  const router = useRouter()

  const handleLogout = async () => {
    await axios.delete('/logout')
      .then(response => {
        if (!response.data.logged_in) {
          setLoggedIn(false)
          router.push('/').then(() => {
          })
        } else {
        }
      })
      .catch(err => {
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