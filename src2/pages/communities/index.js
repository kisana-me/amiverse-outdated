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
        {loggedIn ? (<>
          <div>
            <div>コミュニティ一覧</div>
            <div>テストコミュニティ1</div>
          </div>
        </>) : (<>
          <div>
            <div>ログインしよう</div>
            <div>簡易ログインフォーム</div>
          </div>
          <hr />
        </>)}
        <div>
          <div>おすすめコミュニティ</div>
          <div>テストコミュニティ2</div>
        </div>
      </div>
      <style jsx>{`
        .div_1 {
        }
      `}</style>
    </>
  )
}
