export default function ItemConsole({}) {
  return (
    <>
      <div className="console">
        <div className="console-rating">
          <button className='console-button crb crb-left'>
            <div className="console-icon">
              <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M48.2111 17.5777C48.9482 16.1036 51.0518 16.1036 51.7889 17.5777L83.9299 81.8598C84.7138 83.4275 83.2452 85.1736 81.5664 84.6699L50.5747 75.3724C50.1998 75.2599 49.8002 75.26 49.4253 75.3724L18.4336 84.6699C16.7548 85.1736 15.2862 83.4275 16.0701 81.8598L48.2111 17.5777Z" fill="currentColor"/>
              </svg>
            </div>
            <div className="console-number">0</div>
          </button>
          <button className='console-button crb crb-right'>
            <div className="console-icon">
              <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
              <path d="M51.7889 82.4223C51.0518 83.8964 48.9482 83.8964 48.2111 82.4223L16.0701 18.1402C15.2862 16.5725 16.7548 14.8264 18.4336 15.3301L49.4253 24.6276C49.8002 24.7401 50.1998 24.74 50.5747 24.6276L81.5664 15.3301C83.2452 14.8264 84.7138 16.5725 83.9299 18.1402L51.7889 82.4223Z" fill="currentColor"/>
              </svg>
            </div>
            <div className="console-number">0</div>
          </button>
        </div>

        <button className='console-button cnb cb-emojis'>
          <div className="console-icon">
            <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M76 11H70V24H57V30H70V43H76V30H89V24H76V11ZM50 27C50 21.5581 51.8899 16.5576 55.0492 12.6192C52.7609 12.2123 50.4052 12 48 12C25.9086 12 8 29.9086 8 52C8 74.0914 25.9086 92 48 92C70.0914 92 88 74.0914 88 52C88 49.5948 87.7877 47.2391 87.3808 44.9508C83.4424 48.1101 78.4419 50 73 50C60.2975 50 50 39.7025 50 27ZM36 34C32.6863 34 30 36.6863 30 40C30 43.3137 32.6863 46 36 46C39.3137 46 42 43.3137 42 40C42 36.6863 39.3137 34 36 34ZM32.8247 59C32.3692 59 32 59.3693 32 59.8247C32 68.2058 38.7942 75 47.1753 75H51.8247C60.2058 75 67 68.2058 67 59.8247C67 59.3693 66.6308 59 66.1753 59H32.8247Z" fill="currentColor"/>
            </svg>
          </div>
          <div className="console-number">1</div>
        </button>
        <button className='console-button cnb cb-quote'>
          <div className="console-icon">
            <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M44 20H11V56H35V71L29 71V80H44V20ZM89.0002 20H56.0002L56.0002 56H80.0002V71L74.0002 71V80H89.0002V20Z" fill="currentColor"/>
            </svg>
          </div>
          <div className="console-number">10</div>
        </button>
        <button className='console-button cnb cb-diffuse'>
          <div className="console-icon">
            <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M48.1816 12.3858C49.2557 11.5673 50.7443 11.5673 51.8184 12.3858L86.2339 38.6139C88.5177 40.3544 87.2868 44 84.4155 44H15.5846C12.7132 44 11.4824 40.3544 13.7661 38.6139L48.1816 12.3858ZM21 68H37V77C37 79.7614 34.7614 82 32 82H26C23.2386 82 21 79.7614 21 77V68ZM63 68H79V77C79 79.7614 76.7614 82 74 82H68C65.2386 82 63 79.7614 63 77V68ZM59 68H41V83C41 85.7614 43.2386 88 46 88H54C56.7614 88 59 85.7614 59 83V68ZM21 48C18.2386 48 16 50.2386 16 53V59C16 61.7614 18.2386 64 21 64H79C81.7614 64 84 61.7614 84 59V53C84 50.2386 81.7614 48 79 48H21Z" fill="currentColor"/>
            </svg>
          </div>
          <div className="console-number">100</div>
        </button>
        <button className='console-button cnb cb-reply'>
          <div className="console-icon">
            <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M11 19C11 16.2386 13.2386 14 16 14H84C86.7614 14 89 16.2386 89 19V59C89 61.7614 86.7614 64 84 64H80.1939C77.706 64 75.6814 62.1077 74.5909 59.8715C72.3182 55.211 67.5341 52 62 52C56.4659 52 51.6818 55.211 49.4091 59.8715C48.3186 62.1077 46.294 64 43.8061 64H16C13.2386 64 11 61.7614 11 59V19ZM52 66C52 60.4772 56.4772 56 62 56C67.5229 56 72 60.4772 72 66C72 71.5229 67.5229 76 62 76C56.4772 76 52 71.5229 52 66ZM42 80C42 76.6863 44.6863 74 48 74C51.3137 74 54 76.6863 54 80C54 83.3137 51.3137 86 48 86C44.6863 86 42 83.3137 42 80Z" fill="currentColor"/>
            </svg>
          </div>
          <div className="console-number">1000</div>
        </button>
        <button className='console-button cnb cb-menu'>
          <div className="console-icon">
            <svg viewBox="0 0 100 100" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path fill-rule="evenodd" clip-rule="evenodd" d="M30 15C21.7157 15 15 21.7157 15 30C15 38.2843 21.7157 45 30 45C38.2843 45 45 38.2843 45 30C45 21.7157 38.2843 15 30 15ZM70 15C61.7157 15 55 21.7157 55 30C55 38.2843 61.7157 45 70 45C78.2843 45 85 38.2843 85 30C85 21.7157 78.2843 15 70 15ZM55 70C55 61.7157 61.7157 55 70 55C78.2843 55 85 61.7157 85 70C85 78.2843 78.2843 85 70 85C61.7157 85 55 78.2843 55 70ZM30 55C21.7157 55 15 61.7157 15 70C15 78.2843 21.7157 85 30 85C38.2843 85 45 78.2843 45 70C45 61.7157 38.2843 55 30 55Z" fill="currentColor"/>
            </svg>
          </div>
          <div className="console-number"></div>
        </button>
      </div>
      <style jsx>{`
        .console {
          height: 22px;
          margin-bottom: 4px;
          display: flex;
          justify-content: space-between;
        }
        .console-rating {
          display: flex;
        }
        .console-button {
          display: flex;
          align-items: center;
          overflow: hidden;
          background: inherit;
          color: white;
          border: 1px solid #0000;
          cursor: pointer;
        }
        .crb-left {
          border: 1px solid #c5c5c5;
          border-right: 0.5px solid;
          border-radius: 6px 0 0 6px;
        }
        .crb-right {
          border: 1px solid #c5c5c5;
          border-left: 0.5px solid;
          border-radius: 0 6px 6px 0;
        }
        .console-icon {
          width: 18px;
          height: 18px;
          flex-shrink: 0;
        }
        .console-number {
          display: flex;
          justify-content: flex-start;
          align-items: center;
          overflow: hidden;
        }
        .cnb {
          border-radius: 6px;
          max-width: 60px;
        }
        .cnb:hover, .crb:hover {
          background: #fff3;
        }
      `}</style>
    </>
  )
}