import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menuButton", "menu", "popupMenu"];

  connect() {
    this.isOpen = false;
    //this.createMenu();
    document.addEventListener('mousedown', this.handleClickOutside.bind(this));
  }

  disconnect() {
    document.removeEventListener('mousedown', this.handleClickOutside.bind(this));
  }

  createMenu() {
    const menuItems = [
      { label: '編集', action: () => console.log('編集がクリックされました') },
      { label: '削除', action: () => console.log('削除がクリックされました') },
      { label: '共有', action: () => console.log('共有がクリックされました') },
    ];

    this.menuTarget.innerHTML = '';
    menuItems.forEach(item => {
      const button = document.createElement('button');
      button.className = 'menu-item';
      button.textContent = item.label;
      button.addEventListener('click', () => {
        item.action();
        this.toggleMenu();
      });
      this.menuTarget.appendChild(button);
    });
  }

  toggleMenu() {
    this.isOpen = !this.isOpen;
    if (this.isOpen) {
      this.calculateMenuPosition();
      this.menuTarget.style.display = 'block';
    } else {
      this.menuTarget.style.display = 'none';
    }
  }

  calculateMenuPosition() {
    const buttonRect = this.menuButtonTarget.getBoundingClientRect();
    const screenWidth = window.innerWidth;
    const screenHeight = window.innerHeight;
    const menuWidth = 221;
    const menuHeight = 355;

    let left = buttonRect.right - menuWidth;
    let top = buttonRect.bottom + 8;

    if (left < 0) {
      left = 0;
    }

    if (top + menuHeight > screenHeight) {
      top = buttonRect.top - menuHeight - 8;
    }

    this.menuTarget.style.top = `${top}px`;
    this.menuTarget.style.left = `${left}px`;
  }

  handleClickOutside(event) {
    if (this.isOpen && !this.menuButtonTarget.contains(event.target)) {
      this.toggleMenu();
    }
  }
}
