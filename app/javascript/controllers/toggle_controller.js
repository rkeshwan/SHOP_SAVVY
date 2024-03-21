import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {

  // toggle_monthly(event) {
  //   // event.preventDefault();
  //   const toggleable = document.querySelector(".savings_list_weekly");
  //   toggleable.classList.toggle("hidden");
  // }

  // toggle_monthly(event) {
  //   // event.preventDefault();
  //   const toggleable = document.querySelector(".savings_list_monthly");
  //   toggleable.classList.toggle("hidden");
  // }

  // toggle_yearly(event) {
  //   // event.preventDefault();
  //   const toggleable = document.querySelector(".savings_list_yearly");
  //   toggleable.classList.toggle("hidden");
  // }
  toggle_weekly(event) {
    event.preventDefault();
    const weeklyList = document.querySelector(".savings_list_weekly");
    const monthlyList = document.querySelector(".savings_list_monthly");
    const yearlyList = document.querySelector(".savings_list_yearly");

    if (!weeklyList.classList.contains("hidden")) {
      return; // If already visible, do nothing
    }

    // Hide other lists
    monthlyList.classList.add("hidden");
    yearlyList.classList.add("hidden");

    // Toggle visibility of the monthly list
    weeklyList.classList.toggle("hidden");
  }

  toggle_monthly(event) {
    event.preventDefault();
    const weeklyList = document.querySelector(".savings_list_weekly");
    const monthlyList = document.querySelector(".savings_list_monthly");
    const yearlyList = document.querySelector(".savings_list_yearly");

    if (!monthlyList.classList.contains("hidden")) {
      return; // If already visible, do nothing
    }

    // Hide other lists
    weeklyList.classList.add("hidden");
    yearlyList.classList.add("hidden");

    // Toggle visibility of the monthly list
    monthlyList.classList.toggle("hidden");
  }

  toggle_yearly(event) {
    event.preventDefault();
    const weeklyList = document.querySelector(".savings_list_weekly");
    const monthlyList = document.querySelector(".savings_list_monthly");
    const yearlyList = document.querySelector(".savings_list_yearly");

    if (!yearlyList.classList.contains("hidden")) {
      return; // If already visible, do nothing
    }

    // Hide other lists
    weeklyList.classList.add("hidden");
    monthlyList.classList.add("hidden");

    // Toggle visibility of the yearly list
    yearlyList.classList.toggle("hidden");
  }
}
