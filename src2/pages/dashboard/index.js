import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'
import Link from 'next/link'
import MainHeader from '@/components/layouts/main_header'
import Logout from '@/components/logout'

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

  const ifLoggedIn = (
    <>
      <h2>アカウント</h2>
      <Link href={loggedIn ? '/@' + currentAccount.name_id : '/login'}>
        {loggedIn ? currentAccount.name + 'さんのページへ': 'ログインする' }
      </Link>
      <Logout />
    </>
  )

  const ifLoggedOut = (
    <>
      <h2>アカウント</h2>
      <p>ログインする</p>
      <Link href="/login">ここから</Link>
    </>
  )

  return (
    <>
      <MainHeader>
        ダッシュボード
      </MainHeader>
      <div className="div_1">
        {loggedIn ? ifLoggedIn : ifLoggedOut }
        
      </div>
      <style jsx>{`
        .div_1 {
        }
      `}</style>
    </>
  )
}
