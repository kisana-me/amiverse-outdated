import ItemAccount from '@/components/items/item_account'

export default function Index() {
  const ItemAccountData = {
    name: 'test',
    name_id: 'test_id',
  }

  return (
    <>
      <h1>1. ItemAccount</h1>
      <ItemAccount account={ItemAccountData} />
    </>
  )
}