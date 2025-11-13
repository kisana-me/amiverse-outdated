import axios from '@/lib/axios'
import { useContext, useState, useEffect } from 'react'
import { useRouter } from 'next/router'
import Link from 'next/link'
import Image from 'next/image'
import Items from '@/components/items/items'
import MainHeader from '@/components/layouts/main_header'
import { useStartupContext } from '@/contexts/startup_context'
import { useToastsContext } from '@/contexts/toasts_context'
import { formatFullDate } from '@/lib/format_time'
import AccountPlate from '@/components/accounts/account_plate'

export async function getServerSideProps(context) {
  const accept = context.req.headers.accept || ''
  if (!accept.includes('application/activity+json')) {
    return {
      props: {}
    }
  }

  let apData = {}
  await axios.post('http://app:3000/ap/@' + context.query.name_id)
  .then(res => {
    apData = res.data
  })
  .catch(err => {
    apData = err.data
  })

  context.res.setHeader('Content-Type', 'application/activity+json; charset=utf-8')
  context.res.write(JSON.stringify(apData))
  context.res.end()
  return {
    props: {}
  }
}

export default function Account() {
  const { initialLoading } = useStartupContext()
  const { addToast } = useToastsContext()
  const { query = {} } = useRouter()
  const [account, setAccount] = useState({})
  const [nameId, setNameId] = useState('')

  useEffect(() => {
    if (initialLoading) {return}
    async function fetchAccount() {
      await axios.post('/@' + query.name_id)
        .then(res => {
          setAccount(res.data)
          addToast('データ取得完了')
        })
        .catch(err => {
          addToast('データ取得完了')
        })
    }
    if(query.name_id){
      fetchAccount()
    }
  },[initialLoading])

  return (
    <>
      <MainHeader>
        <div className="account-main-header">
          <img src={account.icon_url || "/ast-imgs/icon.png"} className="amh-icon" alt="アイコン" />
          <div className="amh-nameplate">
            <div>
              {account.name}
            </div>
            <div>
              @{account.name_id}
            </div>
          </div>
          <div className="amh-right">
            <button>action</button>
          </div>
        </div>
      </MainHeader>
      <div className="account-container">
        <div className="account-banner-container">
          <img
            className="account-banner-image"
            src={account.banner_url || "/ast-imgs/banner.png"}
            alt='バナー'
          />
          <div className="account-banner-content"></div>
        </div>

        <AccountPlate account={account} />

        <div className="account-profile">
          <div className="account-profile-summary">{account.summary}</div>
          <div className="account-profile-keyvalues">
            <div className="apk-keyvalue">
              <div className="apk-key">🗺️場所</div>
              <div className="apk-value">{account.location}</div>
            </div>
            <div className="apk-keyvalue">
              <div className="apk-key">🎂誕生日</div>
              <div className="apk-value">{account.birth && formatFullDate(new Date(account.birth))}</div>
            </div>
            <div className="apk-keyvalue">
              <div className="apk-key">🎫参加日</div>
              <div className="apk-value">{formatFullDate(new Date(account.created_at))}</div>
            </div>
          </div>
          <div className="account-profile-counters">
            <div className="apc-counter">
              <div className="apc-figure">{account.followers_counter}</div>
              <div className="apc-subscript">フォロワー</div>
            </div>
            <div className="apc-counter">
              <div className="apc-figure">{account.following_counter}</div>
              <div className="apc-subscript">フォロー</div>
            </div>
            <div className="apc-counter">
              <div className="apc-figure">{account.items_counter}</div>
              <div className="apc-subscript">投稿数</div>
            </div>
          </div>
        </div>

        <div className="account-tab">
          <div className="account-tab-selector">投稿</div>
          <div className="account-tab-selector">返信</div>
          <div className="account-tab-selector">メディア</div>
          <div className="account-tab-selector">リアクション</div>
        </div>

        <div className="account-content">
          <Items items={account.items}/>
        </div>
      </div>
      <style jsx>{`
        .account-main-header {
          min-width: 80%;
          display: flex;
          flex-direction: row;
          align-items: center;
        }
        .amh-icon {
          width: 40px;
          height: 40px;
          border-radius: 20px;
        }
        .amh-nameplate {
          margin-left: 4px
        }
        .amh-right {
          margin: 0 0 0 auto;
        }

        /* ========= */

        .account-container {
          max-width: 800px;
          margin: auto;
        }
        
        /* バナー */
        
        .account-banner-container {
          width: 100%;
          aspect-ratio: 2/1;
        }
        .account-banner-image {
          width: 100%;
          aspect-ratio: 2/1;
          object-fit: cover;
          object-position: center center;
          display: block;
        }
        
        
        /* プロフィール */

        .account-profile {
          margin: 0px 14px;
        }
        .account-profile-summary {}
        .account-profile-keyvalues {}
        .apk-keyvalue {
          display: flex;
          color: var(--inconspicuous-font-color);
          font-size: small;
        }
        .apk-key {}
        .apk-value {
          margin-left: 4px;
        }
        .account-profile-counters {
          display: flex;
          justify-content: space-evenly;
        }
        .apc-counter {
          width: 100px;
          margin: 7px;
          padding: 5px;
          border-radius: 7px;
          text-align: center;
          box-sizing: border-box;
        }
        .apc-counter:hover {
          background: var(--hover-color);
        }
        .apc-figre {
          font-weight: bold;
        }
        .apc-subscript {
          color: var(--inconspicuous-font-color);
        }

        /* タブ */

        .account-tab {
          display: flex;
        }
        .account-tab-selector {
          padding: 5px;
          margin: 2px;
          margin-left: 4px;
          border-radius: 4px;
          color: var(--inconspicuous-font-color);
        }
        .account-tab-selector:hover {
          background: var(--hover-color);
        }
        
        /* コンテンツ */

        .account-content {

        }
      `}</style>
    </>
  )
}