import Link from 'next/link'
import React, { useEffect, useState, useContext } from 'react'

export default function SettingsMenu() {

  return (
    <>
      <div className="settings-menu">
        <div className="settings-menu-search">
          <Link href="/settings" legacyBehavior>
            <a className="">
              🔍設定
            </a>
          </Link>
        </div>
        <div className="settings-menu-profile">
          <Link href="/settings/profile" legacyBehavior>
            <a className="">
              🙋プロフィール
            </a>
          </Link>
        </div>
        <div className="settings-menu-account">
          <Link href="/settings" legacyBehavior>
            <a className="">
              🪪アカウント
            </a>
          </Link>
        </div>
        <div className="settings-menu-storage">
          <Link href="/settings" legacyBehavior>
            <a className="">
              📀ストレージ
            </a>
          </Link>
        </div>
        <div className="settings-menu-content">📺コンテンツ</div>
        <div className="settings-menu-activity">🧭アクティビティ</div>
        <div className="settings-menu-notifications">🔔通知</div>
        <div className="settings-menu-display">📱表示</div>
        <div className="settings-menu-security">🔏セキュリティ</div>
        <div className="settings-menu-authority">🆗権限</div>
        <div className="settings-menu-analytics">📈アナリティクス</div>
        <div className="settings-menu-payments">👛支払い</div>
        <div className="settings-menu-others">📑その他</div>
      </div>
      <style jsx>{`
        .login-fullscreen {}
      `}</style>
    </>
  )
}