
function decrementQuantity(button) {
  var inputField = button.parentElement.previousElementSibling;
  var currentValue = parseInt(inputField.value);
  if (currentValue > 1) {
    inputField.value = currentValue - 1;
    updatePrice(inputField);
    inputField.form.submit();
  }
}

function incrementQuantity(button) {
  var inputField = button.parentElement.previousElementSibling;
  var currentValue = parseInt(inputField.value);
  if (currentValue < 10) {
    inputField.value = currentValue + 1;
    updatePrice(inputField);
    inputField.form.submit();
  }
}

function updatePrice(inputField) {
  var quantity = parseInt(inputField.value);
  var itemPrice = parseInt(inputField.dataset.itemPrice);
  var priceElement = inputField.closest('.line-item').querySelector('.item-price');
  priceElement.textContent = '$' + (itemPrice * quantity / 100).toFixed(2);
}
