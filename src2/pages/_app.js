import '@/styles/globals.css'
import Head from '@/components/head'
import Layout from '@/components/layouts/layout'
import { MainContextProvider } from '@/contexts/main_context'
import { OverlayContextProvider } from '@/contexts/overlay_context'
import { ThemeContextProvider } from '@/contexts/theme_context'
import { ToastsContextProvider } from '@/contexts/toasts_context'
import { StartupContextProvider } from '@/contexts/startup_context'
import { TrendsContextProvider } from '@/contexts/trends_context'
import { ItemsContextProvider } from '@/contexts/items_context'
import { EmojisContextProvider } from '@/contexts/emojis_context'
import ScrollRestoration from '@/components/common/scroll_restoration'

export default function App({ Component, pageProps }) {

  return (
    <>
      <MainContextProvider>
      <OverlayContextProvider>
      <ThemeContextProvider>
      <ToastsContextProvider>
      <StartupContextProvider>
      <TrendsContextProvider>
      <ItemsContextProvider>
      <EmojisContextProvider>
        <ScrollRestoration />
        <Head />
        <Layout>
          <Component {...pageProps} />
        </Layout>
      </EmojisContextProvider>
      </ItemsContextProvider>
      </TrendsContextProvider>
      </StartupContextProvider>
      </ToastsContextProvider>
      </ThemeContextProvider>
      </OverlayContextProvider>
      </MainContextProvider>
    </>
  )
}
