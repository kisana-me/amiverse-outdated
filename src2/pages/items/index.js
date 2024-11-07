import React, { useEffect, useState, useContext } from 'react'
import axios from '@/lib/axios'
import { useMainContext } from '@/contexts/main_context'
import ItemAccount from '@/components/item_account'
import Post from '@/components/post'

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
    <div className="main-container">
      <h1>items</h1>
      <Post />
      <div id="items">
        {items.map(item => (
          <ItemAccount key={item.item_id} item={item} />
        ))}
      </div>
      <style jsx>{`
        .main-container {
          background: var(--main-container-background-color);
          padding: 5px;
        }
        .items {
        }
      `}</style>
    </div>
  )
}
