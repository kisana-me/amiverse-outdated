document.addEventListener("DOMContentLoaded", () => {
  const application = Stimulus.Application.start();

  application.register("canvas", class extends Stimulus.Controller {
    connect() {
      this.canvas = this.element;
      this.ctx = this.canvas.getContext('2d');
      this.ctx.imageSmoothingEnabled = false;
      this.drawing = false;
      this.canvas.addEventListener('mousedown', (e) => this.startDrawing(e));
      this.canvas.addEventListener('mousemove', (e) => this.draw(e));
      this.canvas.addEventListener('mouseup', () => this.stopDrawing());
      this.canvas.addEventListener('mouseout', () => this.stopDrawing());
      this.canvas.addEventListener('touchstart', (e) => this.startDrawing(e));
      this.canvas.addEventListener('touchmove', (e) => this.draw(e));
      this.canvas.addEventListener('touchend', () => this.stopDrawing());
      this.canvas.addEventListener('touchcancel', () => this.stopDrawing());

      this.clearCanvas();
    }

    startDrawing(e) {
      this.drawing = true;
      this.draw(e);
    }

    draw(e) {
      if (!this.drawing) return;
      e.preventDefault();
      const { x, y } = this.getCanvasCoordinates(e);
      this.ctx.fillStyle = 'black';
      this.ctx.fillRect(x, y, 1, 1);
    }

    stopDrawing() {
      this.drawing = false;
    }

    getCanvasCoordinates(e) {
      const rect = this.canvas.getBoundingClientRect();
      let clientX, clientY;
      if (e.touches) {
        clientX = e.touches[0].clientX;
        clientY = e.touches[0].clientY;
      } else {
        clientX = e.clientX;
        clientY = e.clientY;
      }
      const x = Math.floor((clientX - rect.left) / rect.width * this.canvas.width);
      const y = Math.floor((clientY - rect.top) / rect.height * this.canvas.height);
      return { x, y };
    }

    clearCanvas() {
      this.ctx.fillStyle = 'white';
      this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
    }

    save() {
      const imageData = this.ctx.getImageData(0, 0, this.canvas.width, this.canvas.height).data;
      const binaryData = [];

      for (let i = 0; i < imageData.length; i += 4) {
        const r = imageData[i];
        const g = imageData[i + 1];
        const b = imageData[i + 2];
        const isBlack = r === 0 && g === 0 && b === 0;
        binaryData.push(isBlack ? 1 : 0);
      }

      const json = JSON.stringify(binaryData);
      document.getElementById('output').textContent = json;
    }
  });
});