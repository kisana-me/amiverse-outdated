import React, { useState, useEffect } from 'react'
import { useMainContext } from '@/contexts/main_context'
import Link from 'next/link'

export default function Aside() {
  const {  } = useMainContext()

  return (
    <aside>
      <div class="">
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
      <style jsx>{`
        aside {
          width: 260px;
          height: 100svh;
          top: 0px;
          position: sticky;
          flex-shrink: 0;
          z-index: 50;
          display: none;
        }

        @media (min-width: 1000px) {
          aside {
            display: inline-block;
          }
        }
        @media (min-width: 1150px) {
          aside {
            width: 340px;
            display: inline-block;
          }
        }
      `}</style>
    </aside>
  )
}