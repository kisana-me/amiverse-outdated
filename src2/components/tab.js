import React, { useContext } from 'react'
import { appContext } from '@/pages/_app'
import Logout from './logout'

export default function Tab() {
  const darkThreme = useContext(appContext).darkThreme
  const loggedIn = useContext(appContext).loggedIn
  const setLoggedIn = useContext(appContext).setLoggedIn
  const darkThremeTrigger = useContext(appContext).darkThremeTrigger

  return (
    <div className="tab-container">
      <p>content here</p>
      <button onClick={darkThremeTrigger}>{darkThreme ? '🌙' : '☀'}</button>
      <Logout />
      <style jsx>{`
        /* FORM-2 */
        .tab-container {
          width: 260px;
          height: 100svh;
          top: 0px;
          position: sticky;
          flex-shrink: 0;
          z-index: 4;
          display: inline-block;
        }

        @media (max-width: 999.9px) {
          /* FORM-1 */
          .tab-container {
            display: none;
          }
        }

        @media (min-width: 1150px) {
          /* FORM-3 */
          .tab-container {
            width: 340px;
            display: inline-block;
          }
        }
      `}</style>
    </div>
  )
}