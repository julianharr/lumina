import places from "places.js";

const initAutocomplete = () => {
  const addressInput = document.getElementById("search_query");
  if (addressInput) {
    places({ container: addressInput }).configure({
      countries: ["au"],
    });
  }
};

export { initAutocomplete };
