import React, { useEffect, useState, useContext } from 'react'
import axios from '@/lib/axios'
import {appContext} from '@/pages/_app'
import ItemAccount from '@/components/item_account'
import Post from '@/components/post'
import Link from 'next/link'

export default function Dashboard() {
  const loggedIn = useContext(appContext).loggedIn
  const loggedInPage = useContext(appContext).loggedInPage
  const account = useContext(appContext).account
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
