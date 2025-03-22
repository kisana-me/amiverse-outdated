import SkeletonBox from '@/components/skeletons/skeleton_box'

export default function SkeletonTrend() {

  return (
    <>
      <div className="trend">
        <div className="trend-top">
          <div className="trend-top-content">
            <div className="trend-top-title"><SkeletonBox /></div>
            <div className="trend-top-summary"><SkeletonBox width="200px"/></div>
          </div>
        </div>

        <div className="trend-list">
          {[...Array(30)].map((_, index) => (
            <div key={index} className="trend-item">
              <div className="trend-item-top"><SkeletonBox width="80px" height="20px"/></div>
              <div className="trend-item-word"><SkeletonBox width="50px" /></div>
              <div className="trend-item-bottom"><SkeletonBox height="20px" /></div>
            </div>
          ))}
        </div>

        <div className="trend-bottom">
          <span>Category: <SkeletonBox width="60px" height="20px"/></span><br />
          <span>Last updated at: <SkeletonBox width="180px" height="20px"/></span>
        </div>
      </div>

      <style jsx>{`
        .trend-top {
          position: relative;
          background: linear-gradient(45deg, transparent, #a7eb88);
          aspect-ratio: 2 / 1;
        }
        .trend-top-content {
          width: 100%;
          height: 50%;
          padding: 15px;
          box-sizing: border-box;
          position: absolute;
          bottom: 0;
          display: flex;
          flex-direction: column;
          justify-content: flex-end;
          background: linear-gradient(0deg, #000000, #00000000);
        }
        .trend-top-title {
          font-weight: bold;
        }

        .trend-list {
          padding: 15px 0;
        }
        .trend-item {
          padding: 10px 15px;
          color: var(--font-color);
          text-decoration: none;
          display: flex;
          flex-direction: column;
        }
        .trend-item:hover {
          background: var(--hover-color);
        }
        .trend-item-top, .trend-item-bottom {
          color: var(--inconspicuous-font-color);
          font-size: small;
        }
        .trend-item-word {
          font-weight: bold;
        }

        .trend-bottom {
          padding: 15px;
          color: var(--inconspicuous-font-color);
          font-size: small;
        }

        .skeleton-last-updated {
          height: 12px;
          width: 150px;
          background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
          background-size: 200% 100%;
          animation: shimmer 1.5s infinite;
          border-radius: 4px;
          margin-bottom: 15px;
        }
        .skeleton-item {
          display: flex;
          justify-content: space-between;
          padding: 10px 0;
          border-bottom: 1px solid #eff3f4;
        }
        .skeleton-word {
          height: 16px;
          width: 120px;
          background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
          background-size: 200% 100%;
          animation: shimmer 1.5s infinite;
          border-radius: 4px;
        }
        .skeleton-count {
          height: 14px;
          width: 40px;
          background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
          background-size: 200% 100%;
          animation: shimmer 1.5s infinite;
          border-radius: 4px;
        }
        @keyframes shimmer {
          0% { background-position: 200% 0; }
          100% { background-position: -200% 0; }
        }
      `}</style>
    </>
  )
}
