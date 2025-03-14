import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'
import Link from 'next/link'
import MainHeader from '@/components/layouts/main_header'

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
      <MainHeader>コミュニティ</MainHeader>
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
