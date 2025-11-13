import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'
import MainHeader from '@/components/layouts/main_header'
import { useToastsContext } from '@/contexts/toasts_context'

export default function Notifications() {
  const { loading, loggedIn, toastNotifications } = useMainContext()
  const { toasts } = useToastsContext()
  let ignore = false
  useEffect(() => {
    if (!ignore && loggedIn) {
      // fetch
    }
    return () => {ignore = true}
  },[loggedIn])

  return (
    <>
      <MainHeader>通知</MainHeader>
      <div className="div_1">
        {loggedIn ? (<></>) : (<>
          <div>
            <div>ログインしよう</div>
            <div>簡易ログインフォーム</div>
          </div>
          <hr />
        </>)}

        <div>通知</div>
        <div className="notifications">
          <div key={1} className="notification">
            テスト通知1
          </div>
        </div>
        <hr />

        <div>トースト通知</div>
        <div className="toasts">
          {toasts.map((toast, index) => (
            <div key={index} className="toast">
              {toast.message}
            </div>
          ))}
        </div>
        <hr />
      </div>
      <style jsx>{`
        .div_1 {
        }
      `}</style>
    </>
  )
}
