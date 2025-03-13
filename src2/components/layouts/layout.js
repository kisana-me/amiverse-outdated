import React, { useState, useEffect } from 'react'
import { useCommonContext } from '@/contexts/common_context'
import Loading from './loading'
import Header from './header'
import Aside from './aside'
import { useToastsContext } from '@/contexts/toasts_context'

export default function Layout({ children }) {
  const { overlay, isMenuOpen, setIsMenuOpen } = useCommonContext()
  const { toasts } = useToastsContext()

  const handleClick = () => {
    // トースト通知の即時非表示
  }
  
  return (
    <div className='wrap dark-mode green-theme'>
      <Loading />
      <div className='container'>
        <Header />
        <main>
          {children}
        </main>
        <Aside />
        {toasts.filter((toast) => toast.status === "show").map((toast, index) => (
          <div key={index} className="flash" style={{ bottom: `${70+40*index}px`}} >
            {toast.message}
          </div>
        ))}
        {overlay && <div className="global-overlay" />}
        {isMenuOpen && <div className="global-menu-overlay" onClick={()=>{setIsMenuOpen(false)}} />}
      </div>
      <style jsx>{`
        .wrap {}
        .container {
          display: flex;
          background-color: var(--background-color);
          color: var(--font-color);
        }
        main {
          width: 100%;
          min-height: 100svh;
          padding-bottom: 60px;
          box-sizing: border-box;
        }
        .flash {
          border: 1px solid #000;
          border-radius: 5px;
          padding: 3px;
          position: fixed;
          right: 10px;
          background-color: #4fff67bb;
          z-index: 200;
        }
        @media (min-width: 700px) and (min-height: 660px) {
          main {
            border-left: 0.5px solid var(--border-color);
            width: calc(100% - 70px);
          }
        }

        @media (min-width: 1000px) {
          main {
            border-right: 0.5px solid var(--border-color);
            width: calc(100% - 70px - 260px);
          }
        }

        @media (min-width: 1150px) {
          main {
            width: calc(100% - 70px - 340px);
          }
        }

        @media (min-width: 1300px) {
          main {
            width: calc(100% - 200px - 340px);
          }
        }

        .global-overlay {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background: rgba(0, 0, 0, 0.5);
          z-index: 90;
        }
        .global-menu-overlay {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          background: rgba(0, 0, 0, 0.5);
          z-index: 86;
        }
      `}</style>
    </div>
  )
}