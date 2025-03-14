import React, { useState, useEffect } from 'react'
import { useOverlayContext } from '@/contexts/overlay_context'
import Link from 'next/link'
import Footer from '@/components/layouts/footer'

export default function Aside() {
  const { isAsideMenuOpen } = useOverlayContext()

  return (
    <>
      <aside className={isAsideMenuOpen ? 'show-aside' : ''}>
        <div>
          <h2>トレンド</h2>
          <div>
            <div>
              ワード
              <br />
              1件
            </div>
          </div>
          <Link href='/'>もっと見る</Link>
          <br />
          ログイン / サインアップ
        </div>
        <Footer />
      </aside>
      <style jsx>{`
        aside {
          width: 300px;
          height: 100svh;
          top: 0;
          right: -300px;
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