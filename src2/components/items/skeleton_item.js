import SkeletonBox from '@/components/skeletons/skeleton_box'

export default function Item() {

  return (
    <>
      <div className="item">
        <SkeletonBox width="100%" height="54px"/>
        <div className='item-info item-top-info'>
          <div className='iti-left'>
            <SkeletonBox width="40px" height="18px"/>
          </div>
          <div className='iti-right'>
            <SkeletonBox width="60px" height="18px"/>
          </div>
        </div>
        <div className="item-content">
          <SkeletonBox width="100%" height="28px"/>
        </div>
        <div className='item-info item-bottom-info'>
          <div className='ibi-left'>
            <SkeletonBox width="60px" height="18px"/>
          </div>
          <div className='ibi-right'>
            <SkeletonBox width="60px" height="18px"/>
          </div>
        </div>
        <SkeletonBox width="80px" height="24px"/>
        <SkeletonBox width="100%" height="26px"/>
      </div>
      <style jsx>{`
        .item {
          padding: 10px 5px;
          border-bottom: 1px var(--border-color) solid;
        }
        /* INFO */
        .item-info {
          display: flex;
          justify-content: space-between;
          font-size: 12px;
          line-height: 12px;
          color: #939393;
        }
        .item-top-info {
          margin-top: 4px;
        }
        .iti-left {}
        .iti-right {}
        .item-bottom-info{
          color: #939393;
          margin-bottom: 4px;
        }
        .ibi-left {}
        .ibi-right {}

        /* CONTENT */
        .item-content {
          min-height: 40px;
          padding: 5px;
          overflow-wrap: break-word;
        }
        .item-content-image {
          width: 100%;
        }
        .item-content-video {
          width: 100%;
        }
      `}</style>
    </>
  )
}