import React, { useEffect, useState, useContext } from 'react'
import axios from '@/lib/axios'
import { useMainContext } from '@/contexts/main_context'

export default function index() {
  const { loggedIn } = useMainContext()
  const [items, setItems] = useState([])
  let ignore = false
  useEffect(() => {
    if (!ignore && loggedIn) {
      const fetchItems = async () => {
        const response = await axios.post('items')
        const data = response.data
        setItems(data)
      }
      fetchItems()
      created()
      console.log(items)
    }
    return () => {ignore = true}
  },[loggedIn])

  return (
    <>
      <h1>items</h1>
      <style jsx>{`
      `}</style>
    </>
  )
}
