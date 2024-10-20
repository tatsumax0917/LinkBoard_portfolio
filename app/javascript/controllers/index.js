// Import and register all your controllers from the importmap under controllers/*

import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
// app/javascript/controllers/index.js


// import { Application } from "@hotwired/stimulus";
// import ImageUploadController from "./image_upload_controller";

// const application = Application.start();
// application.register("image-upload", ImageUploadController);


// // app/javascript/controllers/index.js
// import { Application } from "@hotwired/stimulus";
// import ImageUploadController from "./image_upload_controller";

// // Stimulus アプリケーションの初期化
// const application = Application.start();

// // コントローラーの登録
// application.register("image-upload", ImageUploadController);
