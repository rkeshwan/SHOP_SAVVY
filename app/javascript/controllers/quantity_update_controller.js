import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quantity-update"
export default class extends Controller {
  static values= {
    lineId: Number,
    unitPrice: Number
  }
  calculate(event) {
    // console.log(this.lineId)
    const newQuantity = event.target.value;
    const newPrice = newQuantity * this.unitPriceValue/100.0;
    // console.log(newPrice);
    this.updatePriceDisplay(newPrice, newQuantity);
  }
  updatePriceDisplay(newPrice, newQuantity) {
    // console.log(this.lineId)
    const priceElement = document.getElementById(`price_for_item_${this.lineIdValue}`);
    priceElement.textContent = `$${newPrice} | Qty: ${newQuantity}`
  }
}
