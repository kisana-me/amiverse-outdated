import React, { useEffect, useState, useContext } from 'react'
import { useMainContext } from '@/contexts/main_context'
import MainHeader from '@/components/layouts/main_header'
import { useThemeContext } from '@/contexts/theme_context'
import SettingsMenu from '@/components/settings/settings_menu'

export default function Index() {
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
      <MainHeader>設定</MainHeader>
      <div className="div_1">
        <SettingsMenu />
        <hr />
        <div>設定を検索</div>
        <div>デバッグメニュー</div>
          <button onClick={() => {darkThremeTrigger()}}>
            🪄ダークテーマトリガー🔮
          </button>
      </div>
      <style jsx>{`
        .div_1 {
        }
      `}</style>
    </>
  )
}
