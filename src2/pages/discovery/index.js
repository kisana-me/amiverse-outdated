import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'

export default function Discovery() {
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
      <h1>みつける</h1>
      <div className="div_1">
        <h2>検索</h2>
      </div>
      <div className="div_1">
        <h2>トレンド</h2>
      </div>
      <div className="div_1">
        <h2>おすすめ</h2>
      </div>
      <div className="div_1">
        <h2>ニュース</h2>
      </div>
      <style jsx>{`
        .div_1 {
        }
      `}</style>
    </>
  )
}
