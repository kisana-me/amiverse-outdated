import Link from 'next/link'
import MainHeader from '@/components/layouts/main_header'

export default function Contact() {
  return (
    <>
      <MainHeader>
        お問い合わせ
      </MainHeader>
      <h1>お問い合わせ</h1>
      <p>Amiverseが運営ているブログサイトの<Link href="https://ivecolor.com/contact">お問い合わせフォーム</Link>をご使用ください。</p>
    </>
  )
}
