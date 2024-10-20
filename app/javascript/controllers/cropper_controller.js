//　画像のトリミングに関する動作
import { Controller } from "@hotwired/stimulus";
import { Modal } from "bootstrap";

export default class extends Controller {
  connect() {
    
    this.modal = new Modal(document.getElementById('image-modal'));
    this.cropper = null;

    // クロップボタンのクリックイベント
    document.getElementById('crop-button').addEventListener('click', () => {
      this.cropImage();
    });
    
    document.getElementById('crop-cancel-button').addEventListener('click', () => {
      // 何らかの処理
      this.cropCancel();
    });

  }
  
  reChoice(){
    const fileInput = document.getElementById('file-input');
    fileInput.value = "";
  }

  triming(event) {

    // 5MB以上の画像を選択したら強制終了
    const imageUpload = event.target;
    if (imageUpload && imageUpload.files.length > 0) {
      const sizeInMegabytes = imageUpload.files[0].size / 1024 / 1024;
      if (sizeInMegabytes > 5) {
        alert("画像サイズが5MBを超えています");
        imageUpload.value = "";  // ファイルの選択をクリア
        return
      }
    }

    // トリミング画面へ
    const fileInput = document.getElementById('file-input');
    
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader(); // ファイルを読み込み、結果を処理するためのAPI
      reader.onload = (e) => {
        const imageElement = document.getElementById('selected-image');
        imageElement.src = e.target.result;
        const inputImageName = document.getElementById('original_file_name')
        inputImageName.value = file.name;

        // モーダルを表示
        this.modal.show();

        // Cropper.jsのインスタンスを作成
        if (this.cropper) {
          this.cropper.destroy(); // 以前のインスタンスがあれば破棄
        }
        this.cropper = new Cropper(imageElement, {
          aspectRatio: 1,
          viewMode: 1,
          autoCropArea: 1,
          responsive: false,
          guides: false,
          // background: false,
          autoCropArea: 1,
          // movable: false,
          rotatable: true,
          cropBoxMovable: true,
          minContainerWidth: 250,
          minContainerHeight: 250,
          minCanvasWidth: 200,
          minCanvasHeight	: 200,
          minCropBoxWidth: 80,
          // cropBoxResizable: false,
          zoomable: false,
          dragMode: 'none',
        });
        
        
        


      };
      reader.readAsDataURL(file);
      const fileInput = document.getElementById('file-input');
    }
  }

  // クロップボタンをクリックしたときの動作
  cropImage() {
    if (this.cropper) {
      const croppedCanvas = this.cropper.getCroppedCanvas(); // <Canvas>要素
      const croppedImage = croppedCanvas.toDataURL("image/jpeg"); // JPEG形式でデータURLを取得
      const resultImageField = document.getElementById('cropped_image_data');
      if (resultImageField) {
        resultImageField.value = croppedImage;
      }
      // モーダルを閉じる
      this.modal.hide();
      
    }
  }
  
  // ファイル入力をリセットするメソッド
  cropCancel() {
    const fileInput = document.getElementById('file-input');
    if (fileInput) {
        fileInput.value = "";
    }
  }
}