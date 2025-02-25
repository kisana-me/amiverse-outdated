import React, { useState, useEffect } from 'react'
import { useMainContext } from '@/contexts/main_context'
import Loading from './loading'
import Header from './header'
import Aside from './aside'

export default function Layout({ children }) {
  const { setLoading, loadingMessage, darkThreme, flashKind, setFlashMessage, flashMessage, loginForm, overlay, setOverlay } = useMainContext()
  const [removeFlash, setRemoveFlash] = useState(false)

  const handleClick = () => {
    if(removeFlash){
      setFlashMessage('')
      setRemoveFlash(false)
    } else {
      setFlashMessage(flashMessage + '(もう一度押して削除)')
      setRemoveFlash(true)
    }
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
        {flashMessage ? <div className={`flash  flash-${flashKind}`} onClick={handleClick}>{flashMessage}</div> : ''}
        {overlay && <div className="global-overlay" />}
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
          bottom: 70px;
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
          z-index: 100;
        }
      `}</style>
    </div>
  )
}