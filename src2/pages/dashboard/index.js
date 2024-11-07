import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'
import Link from 'next/link'

export default function index() {
  const { loggedIn, loggedInPage, currentAccount } = useMainContext()
  let ignore = false
  useEffect(() => {
    // loggedInPage()
    if (!ignore && loggedIn) {
      // fetch
    }
    return () => {ignore = true}
  },[loggedIn])

  return (
    <>
      <h1>ダッシュボード</h1>
      <div className="div_1">
        <h2>アカウント</h2>
        
        <Link href={loggedIn ? '/@' + currentAccount.name_id : '/login'}>
          {loggedIn ? currentAccount.name + 'さんのページへ': 'ログインする' }
        </Link>
      </div>
      <style jsx>{`
        .div_1 {
        }
      `}</style>
    </>
  )
}
