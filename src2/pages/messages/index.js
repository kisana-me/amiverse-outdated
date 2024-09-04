import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'

export default function Messages() {
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
      <h1>メッセージ</h1>
      <div className="div_1">
        <h2>グループ</h2>
      </div>
      <style jsx>{`
        .div_1 {
        }
      `}</style>
    </>
  )
}
