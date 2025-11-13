import React, { useState, useEffect } from 'react'
import { useOverlayContext } from '@/contexts/overlay_context'
import Link from 'next/link'
import Footer from '@/components/layouts/footer'
import TrendsMiniList from '@/components/trends/trends_mini_list'

export default function Aside() {
  const { isAsideMenuOpen } = useOverlayContext()

  return (
    <>
      <aside className={isAsideMenuOpen ? 'show-aside' : ''}>
        <div>
          <h2>トレンド</h2>
          <TrendsMiniList />
          <Link href='/'>もっと見る</Link>
          <br />
          ログイン / サインアップ
        </div>
        <Footer />
      </aside>
      <style jsx>{`
        aside {
          width: 300px;
          height: 100vh;
          top: 0;
          right: -300px;
          border-left: 1px solid var(--border-color);
          box-sizing: border-box;
          position: fixed;
          display: flex;
          flex-direction: column;
          justify-content: space-between;
          flex-shrink: 0;
          backdrop-filter: blur(3px);
          background: var(--blur-color);
          z-index: 88;
          overflow-x: hidden;
          overflow-y: auto;
          transition: right 0.2s ease-in-out;
        }
        aside.show-aside {
          right: 0;
        }
        @media (min-width: 1000px) and (min-height: 720px) {
          aside {
            width: 260px;
            position: sticky;
          }
        }
        @media (min-width: 1150px) {
          aside {
            width: 340px;
          }
        }
      `}</style>
    </>
  )
}