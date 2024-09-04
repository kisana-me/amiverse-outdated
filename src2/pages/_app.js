import '@/styles/globals.css'
import Head from '@/components/head'
import Layout from '@/components/layouts/layout'
import { MainContextProvider } from '@/contexts/main_context'

export default function App({ Component, pageProps }) {

  return (
    <MainContextProvider>
      <Head />
      <Layout>
        <Component {...pageProps} />
      </Layout>
    </MainContextProvider>
  )
}
