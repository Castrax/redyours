const searchBar = () => {
  const searchInput = document.getElementById('search-input');
  const results = document.querySelectorAll('.container-tickets .progress-results a');

  let searchTerm = '';

  const showCards = (status) => {
    results.forEach(result => {
      result.classList.add('d-none');
    })

    const newResults = Array.from(results);

    const filteredResults = Array.prototype.filter.call(newResults, result => {
      result.firstElementChild.childNodes[3].firstElementChild.firstElementChild.innerText.toLowerCase().includes(searchTerm.toLowerCase());
    })

    filteredResults.forEach(result => {
      result.classList.remove('d-none');
      result.classList.add('d-block');
    });
  }

  if (searchInput) {
    searchInput.addEventListener('input', (e) => {
      searchTerm = e.target.value;
      showCards('progress-results');
    })
  }
}

export { searchBar };
