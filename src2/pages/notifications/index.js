import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'

export default function Notifications() {
  const { loggedIn } = useMainContext()
  let ignore = false
  useEffect(() => {
    if (!ignore && loggedIn) {
      // fetch
    }
    return () => {ignore = true}
  },[loggedIn])

  return (
    <>
      <h1>通知</h1>
      <div className="div_1">
        <h2>検索</h2>
      </div>
      <style jsx>{`
        .div_1 {
        }
      `}</style>
    </>
  )
}
