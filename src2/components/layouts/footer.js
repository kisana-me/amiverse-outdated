import Link from 'next/link'

export default function Footer() {
  return (
    <>
      <footer>
        <ul>
          <li>
            <Link href='/'>利用規約</Link>
          </li>
          <li>
            <Link href='/'>プライバシーポリシー</Link>
          </li>
          <li>
            <Link href='/'>お問い合わせ</Link>
          </li>
        </ul>
        <hr />
        <div>© Amiverse 2025</div>
      </footer>
      <style jsx>{`
      `}</style>
    </>
  )
}