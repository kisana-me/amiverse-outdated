import React, { useRef, useEffect } from 'react';
import { useMainContext } from '@/contexts/main_context';

export default function ToggleMenu({ isOpen, onClose, children, buttonRef }) {
  const { setOverlay } = useMainContext();
  const menuRef = useRef(null);

  // メニューの位置を計算して調整する
  const adjustMenuPosition = () => {
    if (!menuRef.current || !buttonRef.current) return;
    const menu = menuRef.current;
    const button = buttonRef.current;
    const buttonRect = button.getBoundingClientRect();
    
    // 一度メニューを表示して高さを取得
    menu.style.visibility = 'hidden';
    menu.style.display = 'block';
    const menuRect = menu.getBoundingClientRect();
    
    const viewportHeight = window.innerHeight;
    const viewportWidth = window.innerWidth;
    
    // 下方向の空きスペース
    const spaceBelow = viewportHeight - buttonRect.bottom;
    // 右方向の空きスペース
    const spaceRight = viewportWidth - buttonRect.left;
    
    // メニューが下に収まるかチェック
    const fitsBelow = spaceBelow >= menuRect.height;
    // メニューが右に収まるかチェック
    const fitsRight = spaceRight >= menuRect.width;
    
    // 位置の設定
    if (fitsBelow) {
      menu.style.top = `${buttonRect.bottom}px`;
      menu.style.bottom = 'auto';
    } else {
      menu.style.bottom = `${viewportHeight - buttonRect.top}px`;
      menu.style.top = 'auto';
    }
    
    if (fitsRight) {
      menu.style.left = `${buttonRect.left}px`;
      menu.style.right = 'auto';
    } else {
      menu.style.right = `${viewportWidth - buttonRect.right}px`;
      menu.style.left = 'auto';
    }
    
    // メニューを表示
    menu.style.visibility = 'visible';
  };

  useEffect(() => {
    if (isOpen) {
      setOverlay(true);
      adjustMenuPosition();
      
      // ウィンドウサイズが変更されたときにも位置を調整
      window.addEventListener('resize', adjustMenuPosition);
      document.addEventListener('click', handleClickOutside);
    } else {
      setOverlay(false);
    }
    return () => {
      document.removeEventListener('click', handleClickOutside);
      window.removeEventListener('resize', adjustMenuPosition);
      setOverlay(false);
    };
  }, [isOpen]);

  const handleClickOutside = (event) => {
    if (menuRef.current && !menuRef.current.contains(event.target) &&
        buttonRef.current && !buttonRef.current.contains(event.target)) {
      onClose();
    }
  };

  if (!isOpen) return null;

  return (
    <div ref={menuRef} className="toggle-menu">
      {children}
      <style jsx>{`
        .toggle-menu {
          position: fixed;
          min-width: 200px;
          background: #fff;
          border-radius: 8px;
          box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
          z-index: 101;
          padding: 8px 0;
          display: none; /* 初期状態では非表示 */
        }
        /* メニュー項目のスタイル */
        :global(.menu-item) {
          padding: 8px 16px;
          cursor: pointer;
          color: #000;
        }
        :global(.menu-item:hover) {
          background-color: #f5f5f5;
        }
      `}</style>
    </div>
  );
} 