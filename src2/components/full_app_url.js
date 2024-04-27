function FullAppUrl(path) {
  const host = process.env.NEXT_PUBLIC_FRONT_APP_URL
  const url = new URL(path, host)
  return url
}

export default FullAppUrl