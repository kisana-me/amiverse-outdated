import React, { useContext } from 'react'
import axios from '@/lib/axios'
import { useMainContext } from '@/contexts/main_context'
import { useRouter } from 'next/router'

export default function Logout() {
  const { setLoginLoading, loggedIn, setLoggedIn, setFlash } = useMainContext()
  const router = useRouter()

  const handleLogout = async () => {
    setLoginLoading(true)
    await axios.delete('/logout')
      .then(response => {
        if (!response.data.logged_in) {
          setLoggedIn(false)
          router.push('/').then(() => {
            setFlash('ログアウトしました')
            setLoginLoading(false)
          })
        } else {
          setFlash('ログアウトできませんでした')
        }
      })
      .catch(err => {
        setFlash('ログアウト通信例外')
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