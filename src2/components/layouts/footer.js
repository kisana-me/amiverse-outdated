import Link from 'next/link'

export default function Footer() {
  return (
    <>
      <footer>
        <ul>
          <li>
            <Link href='/terms'>利用規約</Link>
          </li>
          <li>
            <Link href='/privacy'>プライバシーポリシー</Link>
          </li>
          <li>
            <Link href='/contact'>お問い合わせ</Link>
          </li>
        </ul>
        <hr />
        <div>© Amiverse</div>
      </footer>
      <style jsx>{`
      `}</style>
    </>
  )
}