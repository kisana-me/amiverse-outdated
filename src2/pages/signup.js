import React, { useEffect, useState, useContext } from 'react'
import axios from '@/lib/axios'
import { useRouter } from 'next/router'
import { useToastsContext } from '@/contexts/toasts_context'
import MainHeader from '@/components/layouts/main_header'

export default function Signup() {
  const { addToast } = useToastsContext()
  const router = useRouter()
  const [signupStatus, setSignupStatus] = useState('未確認')
  const [invitationChecked, setInvitationChecked] = useState(false)
  const [invitationCode, setInvitationCode] = useState('')
  const [name, setName] = useState('')
  const [nameID, setNameID] = useState('')
  const [summary, setSummary] = useState('')
  const [password, setPassword] = useState('')
  const [passwordConfirmation, setPasswordConfirmation] = useState('')

  const signupCheck = async (e) => {
    e.preventDefault()
    await axios.post('/signup/check', {
      'code': invitationCode
    })
    .then(res => {
      if(res.data.valid){
        setSignupStatus('アカウントを作成してください')
        setInvitationChecked(true)
      } else {
        setSignupStatus('使用不可能')
      }
    })
    .catch(err => {
      setSignupStatus('サーバーエラー')
    })
  }
  const signupCreate = async (e) => {
    e.preventDefault()
    await axios.post('/signup/create', {
      'code': invitationCode,
      'name': name,
      'name_id': nameID,
      'summary': summary,
      'password': password,
      'password_confirmation': passwordConfirmation
    })
    .then(res => {
      if (res.data.status == 'created') {
        setSignupStatus('作成されました')
        addToast('作成したよ')
        router.push('/')
      } else if (res.data.status == 'rollbacked') {
        setSignupStatus(res.data.message)
      } else if (res.data.status == 'invalid_code') {
        setSignupStatus('招待が確認できませんでした')
      } else {
        setSignupStatus('アカウントが作成できませんでした')
      }
    })
    .catch(err => {
      setSignupStatus('アカウント作成通信例外')
      console.log(err)
    })
  }
  const invitationCodeForm = (
    <form onSubmit={signupCheck}>
      <label>
        招待コード:
        <input type="text" value={invitationCode} onChange={(e) => setInvitationCode(e.target.value)} ></input>
      </label>
      <button type="submit">送信</button>
    </form>
  )
  const AccountForm = (
    <form onSubmit={signupCreate}>
      <label>
        招待コード:
        <input type="text" value={invitationCode} onChange={(e) => setInvitationCode(e.target.value)} />
      </label>
      <br />
      <label>
        なまえ:
        <input type="text" value={name} onChange={(e) => setName(e.target.value)} />
      </label>
      <br />
      <label>
        ID:
        <input type="text" value={nameID} onChange={(e) => setNameID(e.target.value)} />
      </label>
      <br />
      <label>
        パスワード:
        <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} />
      </label>
      <br />
      <label>
        パスワード確認:
        <input type="password" value={passwordConfirmation} onChange={(e) => setPasswordConfirmation(e.target.value)} />
      </label>
      <br />
      <button type="submit">送信</button>
    </form>
  )
  let form
  if (invitationChecked) {
    form = AccountForm
  } else {
    form = invitationCodeForm
  }

  return (
    <>
      <MainHeader>
        サインアップ
      </MainHeader>
      <div>
        <span>{signupStatus}</span>
        {form}
      </div>
    </>
  )
}