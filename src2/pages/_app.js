import '@/styles/globals.css'
import Head from '@/components/head'
import Layout from '@/components/layouts/layout'
import { MainContextProvider } from '@/contexts/main_context'
import { ToastsContextProvider } from '@/contexts/toasts_context'
import { EmojisContextProvider } from '@/contexts/emojis_context'

export default function App({ Component, pageProps }) {

  return (
    <MainContextProvider>
    <ToastsContextProvider>
    <EmojisContextProvider>
      <Head />
      <Layout>
        <Component {...pageProps} />
      </Layout>
    </EmojisContextProvider>
    </ToastsContextProvider>
    </MainContextProvider>
  )
}
