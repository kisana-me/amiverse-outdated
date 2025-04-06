export default function fullUrl(path) {
  const base = process.env.FRONT_URL || ''
  return new URL(path, base).toString()
}
