import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'

export default function Settings() {
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
      <h1>設定</h1>
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
