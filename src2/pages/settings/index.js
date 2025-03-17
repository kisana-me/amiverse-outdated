import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'
import MainHeader from '@/components/layouts/main_header'

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
      <MainHeader>設定</MainHeader>
      <div className="div_1">
        <div className="settings-tab">
          <div className="settings-tab-search">設定を検索</div>
          <div className="settings-tab-profile">プロフィール</div>
          <div className="settings-tab-account">アカウント</div>
          <div className="settings-tab-storage">ストレージ</div>
          <div className="settings-tab-content">コンテンツ</div>
          <div className="settings-tab-activity">アクティビティ</div>
          <div className="settings-tab-notifications">通知</div>
          <div className="settings-tab-display">表示</div>
          <div className="settings-tab-security">セキュリティ</div>
          <div className="settings-tab-authority">権限</div>
          <div className="settings-tab-analytics">アナリティクス</div>
          <div className="settings-tab-payments">支払い</div>
          <div className="settings-tab-others">その他</div>
        </div>
        <hr />
        <div>設定を検索</div>
      </div>
      <style jsx>{`
        .div_1 {
        }
      `}</style>
    </>
  )
}
