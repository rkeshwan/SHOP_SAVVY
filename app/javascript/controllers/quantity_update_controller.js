import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quantity-update"
export default class extends Controller {
  static values= {
    lineItemId: Number,
    lineId: Number,
    unitPrice: Number,

  }
  calculate(event) {
    // console.log(this.lineId)
    const newQuantity = event.target.value;
    const newPrice = newQuantity * this.unitPriceValue/100.0;
    // console.log(newPrice);
    this.updatePriceDisplay(newPrice, newQuantity);
    this.updateQuantityBackend(newQuantity);
  }
  updatePriceDisplay(newPrice, newQuantity) {
    // console.log(this.lineId)
    const priceElement = document.getElementById(`price_for_item_${this.lineIdValue}`);
    priceElement.textContent = `$${newPrice}`
  }

  // Updated method to handle quantity change and AJAX request
  updateQuantityBackend(newQuantity) {
    console.log(this.element.dataset.quantityUpdateLineIdValue)
    const lineItemId = this.element.dataset.quantityUpdateLineIdValue;
    console.log(lineItemId)
    console.log(`Line Item ID: ${lineItemId}`);
    fetch(`/line_items/${lineItemId}/adjust_item`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'text/vnd.turbo-stream.html.fragment+html'
      },
      body: JSON.stringify({ quantity: newQuantity })
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Failed to update quantity');
      }
    }).catch(error => console.error(error));
  }
}
