import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["test"]
  connect() {
    // this.element.textContent = "Hello World!"
    console.log(this.testTarget)
  }
}
