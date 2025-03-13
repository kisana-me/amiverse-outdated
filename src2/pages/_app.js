import '@/styles/globals.css'
import Head from '@/components/head'
import Layout from '@/components/layouts/layout'
import { MainContextProvider } from '@/contexts/main_context'
import { CommonContextProvider } from '@/contexts/common_context'
import { ThemeContextProvider } from '@/contexts/theme_context'
import { ToastsContextProvider } from '@/contexts/toasts_context'
import { ItemsContextProvider } from '@/contexts/items_context'
import { EmojisContextProvider } from '@/contexts/emojis_context'

export default function App({ Component, pageProps }) {

  return (
    <MainContextProvider>
    <CommonContextProvider>
    <ThemeContextProvider>
    <ToastsContextProvider>
    <ItemsContextProvider>
    <EmojisContextProvider>
      <Head />
      <Layout>
        <Component {...pageProps} />
      </Layout>
    </EmojisContextProvider>
    </ItemsContextProvider>
    </ToastsContextProvider>
    </ThemeContextProvider>
    </CommonContextProvider>
    </MainContextProvider>
  )
}
