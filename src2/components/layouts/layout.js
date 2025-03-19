import React, { useState, useEffect } from 'react'
import { useOverlayContext } from '@/contexts/overlay_context'
import InitialLoading from '@/components/layouts/initial_loading'
import Header from '@/components/layouts/header'
import Aside from '@/components/layouts/aside'
import BottomNav from '@/components/layouts/bottom_nav'
import { useToastsContext } from '@/contexts/toasts_context'

export default function Layout({ children }) {
  const { overlay, menuOverlay, closeMenu } = useOverlayContext()
  const { toasts } = useToastsContext()

  const handleClick = () => {
    // トースト通知の即時非表示
  }
  
  return (
    <>
      <InitialLoading />
      <div className='wrap'>
        <Header />
        <main>
          <div className='main-content'>
            {children}
          </div>
        </main>
        <Aside />
        {toasts.filter((toast) => toast.status === "show").map((toast, index) => (
          <div key={index} className="flash" style={{ bottom: `${70+40*index}px`}} >
            {toast.message}
          </div>
        ))}
        <BottomNav />
        {overlay && <div className="global-overlay" />}
        {menuOverlay && <div className="global-menu-overlay" onClick={()=>{closeMenu()}} />}
      </div>
      <style jsx>{`
        .wrap {
          display: flex;
        }
        main {
          width: 100%;
          min-height: 100vh;
          padding-bottom: 60px;
          box-sizing: border-box;
          display: flex;
          justify-content: center;
        }
        .main-content {
          max-width: 800px;
          width: 100%;
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

        .global-overlay {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          backdrop-filter: blur(2px);
          background: rgba(0, 0, 0, 0.5);
          z-index: 90;
        }
        .global-menu-overlay {
          position: fixed;
          top: 0;
          left: 0;
          right: 0;
          bottom: 0;
          backdrop-filter: blur(2px);
          background: rgba(0, 0, 0, 0.5);
          z-index: 86;
        }
      `}</style>
    </>
  )
}