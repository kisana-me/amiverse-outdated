import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'
import Link from 'next/link'

export default function Dashboard() {
  const { loggedIn, loggedInPage, account } = useMainContext()
  let ignore = false
  useEffect(() => {
    loggedInPage()
    if (!ignore && loggedIn) {
      // fetch
    }
    return () => {ignore = true}
  },[loggedIn])

  return (
    <>
      <h1>Amiverse</h1>
      <div className="div_1">
        <h2>アカウント</h2>
        <Link href={loggedIn ? '/@' + account.name_id : '/login'}>
          あかうんと
        </Link>
      </div>
      <style jsx>{`
        .div_1 {
        }
      `}</style>
    </>
  )
}
