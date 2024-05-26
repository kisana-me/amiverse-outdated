import Header from './header'
import Footer from './footer'
import Nav from './nav'
import Tab from './tab'
import Login from './login'
import { appContext } from '@/pages/_app'
import React, { useContext, useState, useEffect } from 'react'

export default function Layout({ children }) {
  const loading = useContext(appContext).loading
  const setLoading = useContext(appContext).setLoading
  const loadingMessage = useContext(appContext).loadingMessage
  const darkThreme = useContext(appContext).darkThreme
  const flashKind = useContext(appContext).flashKind
  const setFlashKind = useContext(appContext).setFlashKind
  const flashMessage = useContext(appContext).flashMessage
  const setFlashMessage = useContext(appContext).setFlashMessage
  const loginForm = useContext(appContext).loginForm
  const [removeFlash, setRemoveFlash] = useState(false)
  const [showLoading, setShowLoading] = useState(loading)

  useEffect(() => {
    if (!loading) {
      const timer = setTimeout(() => {
        setShowLoading(false)
      }, 390)
      return () => clearTimeout(timer)
    }
  }, [loading])

  const handleClick = () => {
    if(removeFlash){
      setFlashMessage('')
      setRemoveFlash(false)
    } else {
      setFlashMessage(flashMessage + '(もう一度押して削除)')
      setRemoveFlash(true)
    }
  }
  const closeLoading = () => setLoading(false)
  
  return (
    <div className={`all ${darkThreme ? "dark-mode" : "light-mode"} ${loading ? "loading-top" : ""}`}>
      <div className={`${showLoading ? "loading-expose" : "loading-hide"}`}>
        <div className="loading-logo">
          <div className={`loading-logo-ring1 ${loading ? "" : "loading-logo-ring2"}`}></div>
          <img className="loading-logo-amiverse" src="/amiverse.svg" />
        </div>
        <div className='loading-details'>
          <div className="loading-status">{loadingMessage}</div>
          <div className='loading-close-button' onClick={closeLoading} >閉じる</div>
        </div>
      </div>
      <div className="main-container">
        <Nav />
        {loginForm ? <Login /> : ''}
        <main>
          {children}
          {flashMessage ? <div className={`flash  flash-${flashKind}`} onClick={handleClick}>{flashMessage}</div> : ''}
        </main>
        <Tab />
      </div>
      <style jsx>{`
        .all {
          background: var(--background-color);
          color: var(--font-color);
        }
        .loading-top {
          width: 100vw;
          height: 100svh;
          overflow: hidden;
        }
        .loading-expose{
          z-index: 10;
          position: fixed;
          width: 100vw;
          height: 100svh;
          background: var(--background-color);
          display: flex;
          align-items: center;
          justify-content: center;
          text-align: center;
        }
        .loading-hide {
          display: none;
        }
        .loading-logo {
          font-size: 32px;
          font-family: math;
          color: #b057e8;
          display: block;
          width: 50px;
          height: 50px;
          background: #04DDFD00;
          position: absolute;
          top: 50%;
          left: 50%;
          transform: translate(-50%, -50%);
        }
        .loading-logo-ring1 {
          background: rgba(181, 244, 253, 1);
          position: absolute;
          z-index:-1;
          border-radius: 100px;
          height: 70px;
          width: 70px;
          top: -10px;  /*A.中心*/
          left: -10px;  /*A.中心*/
          animation: pulsate1 1s ease-in-out;  /* スピードなど */
          animation-iteration-count: infinite;
        }
        .loading-logo-ring2 {
          animation: pulsate2 0.4s ease-in-out;  /* スピードなど */
        }
        @keyframes pulsate1 {
          0% { transform: scale(1, 1); opacity: 0.1; }
          50% { transform: scale(2, 2); opacity: 0.1; }
          100%  { transform: scale(1, 1); opacity: 0.1; }
        }
        @keyframes pulsate2 {
          0% { opacity: 0.1; }
          100%  { transform: scale(3, 3); opacity: 0.0; }
        }
        .loading-logo-amiverse {
          width: 50px;
          height: 50px;
        }
        .loading-details {
          position: absolute;
          bottom: 10%;
        }
        .loading-status {
          color: #64a5fc;
        }
        .loading-close-button {
          display: inline;
        }

        /* MAIN */

        /* FORM-2 */
        .main-container {
          display: flex;
          background-color: var(--background-color);
          color: var(--font-color);
        }
        main {
          width: calc(100% - 30px);
          border-left: 0.5px solid;
          box-sizing: border-box;
          background-color: var(--main-background-color);
        }
        @media (max-width: 700px) {
          /* FORM-1 */
          main {
            border: none;
            width: 100%;
            min-height: 100svh;
            padding-bottom: 46px;
          }
        }
        @media (min-width: 1000px) {
          main {
            border-right: 0.5px solid var(--border-color);
            width: calc(100% - 160px);
          }
        }
        .main-container {
          display: flex;
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
      `}</style>
    </div>
  )
}