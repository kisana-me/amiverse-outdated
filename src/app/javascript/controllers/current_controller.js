import { Controller } from "@hotwired/stimulus"
import consumer from "channels/consumer"

export default class extends Controller {
  static targets = ["current"]

  connect() {
    this.channel = consumer.subscriptions.create("CurrentChannel", {
      received: (data) => {
        console.log(data)
        this.addItemToDOM(data)
      }
    })
    console.log("connected channel")
  }
  disconnect() {
    this.channel.unsubscribe()
    console.log("disconnected channel")
  }
  speak() {
    this.channel.perform('speak', {message: 'message'})
  }
  addText(moji) {
    const receivedText = moji
    const divElement = document.createElement("div")
    const pElement = document.createElement("p")
    pElement.textContent = receivedText
    divElement.appendChild(pElement)
    this.currentTarget.appendChild(divElement)
  }
  addItemToDOM(itemData) {
    // itemData はサーバーから受け取った JSON データを想定
    const container = document.getElementById('items'); // 事前に定義されたコンテナを指定
  
    // HTML 構造を生成
    const itemHtml = `
      <div class="item">
        <div class="item-details">
          <a href="/accounts/${itemData.account.name_id}">
            <div class="item-whose">
              <img src="${itemData.account.icon_url}" class="item_account_image">
              <div class="item-account">
                <div class="item-account-profile">
                  <div class="item-account-name">
                    ${itemData.account.name}
                  </div>
                  <div class="item-account-name-id">
                    @${itemData.account.name_id}
                  </div>
                </div>
              </div>
            </div>
          </a>
          <div class="item-r">
            <div class="item-day">
              ${new Date(itemData.created_at).toLocaleDateString("ja-JP")}<br>
              ${new Date(itemData.created_at).toLocaleTimeString("ja-JP")}
            </div>
            <div class="item-menu">・・・</div>
          </div>
        </div>
        <a href="/items/${itemData.aid}" class="item-content-link">
          <div class="item-content">
            ${itemData.content}
          </div>
        </a>
        <div class="item-media">
          // 画像や動画を挿入するロジックが入ります
        </div>
        // その他の要素...
      </div>
    `;
  
    // HTML をコンテナに追加
    container.innerHTML += itemHtml;
    //this.currentTarget.appendChild(itemHtml)
  }
}
