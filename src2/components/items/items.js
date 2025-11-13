import Link from 'next/link'
import Item from '@/components/items/item'
import SkeletonItem from '@/components/items/skeleton_item'

export default function Items({ items = [], loadItems = false }) {

  return (
    <>
      <div className="items">
        {(() => {
          if (loadItems) {
            return (
              <>
                {[...Array(20)].map((_, index) => (
                  <SkeletonItem key={index} />
                ))}
              </>
            )
          } else if (items.length > 0) {
            return (
              <>
                {items.map(item => (
                  <Item key={item.aid} item={item} />
                ))}
              </>
            )
          } else {
            return (
              <>
                <p>アイテムはありません。</p>
              </>
            )
          }
        })()}
      </div>
      <style jsx>{`
        .items {
        }
      `}</style>
    </>
  )
}