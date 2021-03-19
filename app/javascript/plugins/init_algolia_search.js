import algoliasearch from "algoliasearch";

const inputField = document.getElementById("search");
const resultsSelector = document.getElementById("results")

const algoliaSearch = () => {

  if (inputField) {
    const appId = document.querySelector("meta[name='algolia-app-id']").content;
    const searchOnlyApiKey = document.querySelector("meta[name='algolia-search-only-api-key']").content;

    const client = algoliasearch(appId, searchOnlyApiKey);
    const index = client.initIndex('Charity');

    inputField.addEventListener("input", () => {
      index.search(inputField.value).then((content) => {
        console.log(content.hits.slice(5));
        resultsSelector.innerHTML = ""
        content.hits.forEach((hit) => {
          resultsSelector.insertAdjacentHTML("beforeend", `<li>${hit.name}</li>`);
        })

        // handle results however you like...
        // do the insertHTML
      })
    });
  }
}

inputField.addEventListener("keyup", (event) => {
  // eslint-disable-next-line no-undef
  algoliaSearch(resultsSelector.value);
});

export { algoliaSearch };
