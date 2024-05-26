import { useContext } from 'react'
import { appContext } from '@/pages/_app'
import Link from 'next/link'
import { HomeSvg, HomeFrameSvg } from '@/lib/svg'

export default function Nav() {
  const loggedIn = useContext(appContext).loggedIn
  const account = useContext(appContext).account
  return (
    <nav>
      <div className="nav-logo">
        <div className="nav-li">
          <Link href="/" className="nav-a">
            <div className="nav-list-container">
              <div className="nav-list-icon">
                <img className="nav-list-amiverse" src="/amiverse.svg" />
              </div>
              <div className="nav-list-info">Amiverse</div>
            </div>
          </Link>
        </div>
      </div>
      <div className="nav-ul">
        <div className="nav-li">
          <Link href="/">
            <div className="nav-list-container">
              <div className="nav-list-icon">
                <HomeSvg width="36px" height="36px" />
              </div>
              <div className="nav-list-info">Home</div>
            </div>
          </Link>
        </div>
        <div className="nav-li">
          <Link href="/discovery">
            <div className="nav-list-container">
              <div className="nav-list-icon">
                <HomeFrameSvg width="36px" height="36px" />
              </div>
              <div className="nav-list-info">Discovery</div>
            </div>
          </Link>
        </div>
        <div className="nav-li">
          <Link href="/dashboard">
            <div className="nav-list-container">
              <div className="nav-list-icon">
                <HomeFrameSvg width="36px" height="36px" />
              </div>
              <div className="nav-list-info">Dashboard</div>
            </div>
          </Link>
        </div>
        <div className="nav-li">
          <Link href="/notifications">
            <div className="nav-list-container">
              <div className="nav-list-icon">
                <HomeFrameSvg width="36px" height="36px" />
              </div>
              <div className="nav-list-info">Notifications</div>
            </div>
          </Link>
        </div>
        <div className="nav-li">
          <Link href="/messages">
            <div className="nav-list-container">
              <div className="nav-list-icon">
                <HomeFrameSvg width="36px" height="36px" />
              </div>
              <div className="nav-list-info">Messages</div>
            </div>
          </Link>
        </div>
      </div>
      <div className="nav-menu">
        <div className="nav-li">
          <Link href={loggedIn ? '/@' + account.name_id : '/login'}>
            <div className="nav-list-container">
              <div className="nav-list-icon">
                <HomeFrameSvg width="36px" height="36px" />
              </div>
              <div className="nav-list-info">Me</div>
            </div>
          </Link>
        </div>
        <div className="nav-li">
          <Link href="/settings">
            <div className="nav-list-container">
              <div className="nav-list-icon">
                <HomeFrameSvg width="36px" height="36px" />
              </div>
              <div className="nav-list-info">Settings</div>
            </div>
          </Link>
        </div>
      </div>
      <style jsx>{`
        /* FORM-2 */
        nav {
          width: 70px;
          height: 100svh;
          position: sticky;
          padding: 30px 5px;
          box-sizing: border-box;
          top: 0px;
          left: 0px;
          display: flex;
          flex-direction: column;
          z-index: 5;
        }
        /* ボタン三種 */
        .nav-logo {
          margin-bottom: 60px;
        }
        .nav-ul {
          width: 100%;
          margin: 0px;
          padding: 0px;
          display: flex;
          flex-direction: column;
          flex-grow: 1;
        }
        .nav-menu {
        }
        /* 5大ボタン */
        .nav-li {
          width: 60px;
          height: 60px;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
        }
        .nav-list-container {
          width: 50px;
          height: 50px;
          border-radius: 25px;
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
          color: white;
        }
        .nav-list-container:hover {
          background: #fff4;
        }
        .nav-list-icon {
          display: flex;
          flex-direction: column;
          align-items: center;
          justify-content: center;
        }
        .nav-list-amiverse {
          width: 50px;
          height: 50px;
        }
        .nav-list-svg {
          width: 36px;
          height: 36px;
        }
        .nav-list-info {
          display: none;
          white-space: nowrap;
          overflow: hidden;
          text-overflow: ellipsis;
        }
        @media (max-width: 699px) {
          /* FORM-1 */
          nav {
            position: fixed;
            top: auto;
            bottom: 0px;
            width: 100%;
            height: 46px;
            padding: 0px;
            backdrop-filter: blur(3px);
            background: var(--blur-color);
          }
          .nav-logo {
            display: none;
          }
          .nav-ul {
            flex-direction: row;
            justify-content: space-around;
            align-items: center
          }
          .nav-menu {
            display: none;
          }
          .nav-li {
            height: 41px;
            width: 41px;
          }
          .nav-list-container {
            height: 41px;
            width: 41px;
          }
        }
        @media (min-width: 1300px) {
          /* FORM-3 */
          nav {
            width: 200px;
          }
          .nav-li {
            width: 190px;
            flex-direction: row;
            justify-content: flex-start;
          }
          .nav-list-container {
            height: 100%;
            width: 170px;
            padding: 10px;
            border-radius: 5px;
            flex-direction: row;
            justify-content: flex-start;
          }
          .nav-list-icon {
            margin-right: 7px;
          }
          .nav-list-info {
            display: inline-block;
          }
        }
      `}</style>
    </nav>
  )
}