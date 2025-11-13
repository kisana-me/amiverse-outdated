import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'
import MainHeader from '@/components/layouts/main_header'
import { useThemeContext } from '@/contexts/theme_context'
import SettingsMenu from '@/components/settings/settings_menu'

export default function Profile() {
  const { loggedIn } = useMainContext()
  const { darkThremeTrigger } = useThemeContext()
  let ignore = false
  useEffect(() => {
    if (!ignore && loggedIn) {
      // fetch
    }
    return () => {ignore = true}
  },[loggedIn])

  return (
    <>
      <MainHeader>設定/プロフィール</MainHeader>
      <div className="div_1">
        <SettingsMenu />
        <hr />
        <div>プロフィール</div>
        <div>アイコン</div>
        <div>バナー</div>
        <div>名前</div>
        <div>ID</div>
        <div>紹介文</div>
        <div>リンク</div>
        <div>場所</div>
        <div>誕生日</div>
        <div>オンラインステータスの公開範囲</div>
        <div>誕生日</div>
      </div>
      <style jsx>{`
        .div_1 {
        }
      `}</style>
    </>
  )
}
