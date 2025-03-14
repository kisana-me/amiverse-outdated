import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'
import MainHeader from '@/components/layouts/main_header'

export default function Notifications() {
  const { loading, loggedIn, toastNotifications } = useMainContext()
  let ignore = false
  useEffect(() => {
    if (!ignore && loggedIn) {
      // fetch
    }
    return () => {ignore = true}
  },[loggedIn])

  return (
    <>
      <MainHeader>通知</MainHeader>
      <div className="div_1">
        <p>未実装</p>
      </div>
      <style jsx>{`
        .div_1 {
        }
      `}</style>
    </>
  )
}
