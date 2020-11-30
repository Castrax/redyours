const searchBar = () => {
  const searchInput = document.getElementById('search-input');
  const results = document.querySelectorAll('.container-tickets .progress-results a');

  let searchTerm = '';
  let cardsArray = [];

  const fetchCards = (status) => {
    const cards = document.querySelectorAll(`.container-tickets .${status} a`);
    cards.forEach(card => {
      const cardsHash = {};
      const cardUrl = card.href;
      cardsHash['url'] = cardUrl;
      const cardTarget = card.attributes[1].nodeValue
      cardsHash['target'] = cardTarget;
      const cardPhoto = `https://picsum.photos/300/200?random=${Math.floor(Math.random() * 10) + 1}`;
      cardsHash['photo'] = cardPhoto;
      const cardTitle = card.firstElementChild.childNodes[3].firstElementChild.firstElementChild.innerText;
      cardsHash['title'] = cardTitle;
      const cardDate = card.firstElementChild.childNodes[3].firstElementChild.childNodes[3].innerText;
      cardsHash['date'] = cardDate;
      const cardManager = card.firstElementChild.childNodes[3].firstElementChild.childNodes[5].firstElementChild.innerText;
      cardsHash['manager'] = cardManager;
      const cardComments = card.firstElementChild.childNodes[3].firstElementChild.childNodes[5].childNodes[3].innerText;
      cardsHash['comments'] = cardComments;
      cardsArray.push(cardsHash);
    })
  }

  const showCards = (status) => {
    results.forEach(result => {
      result.innerHTML = '';
    })
    const resultsDisplay = document.querySelector('.progress-tickets');
    const aCard = document.createElement('a');
    const cardNew = document.createElement('div');
    const imgCard = document.createElement('img');
    const cardBody = document.createElement('div');
    const cardText = document.createElement('div');
    const titleCard = document.createElement('p');
    const spanTitle = document.createElement('span');
    const pCreated = document.createElement('p');
    const spanCreated = document.createElement('span');
    const cardBottom = document.createElement('div');
    const managerCard = document.createElement('p');
    const pComments = document.createElement('p');
    const spanComments = document.createElement('span');
    cardsArray.filter(card => card.title.toLowerCase().includes(searchTerm.toLowerCase()))
              .forEach(card => {
                aCard.classList.add('static-popup-link');
                aCard.setAttribute('data-toggle', 'modal');
                aCard.setAttribute('data-target', `${card.target}`);
                aCard.setAttribute('href', `${card.url}`);
                cardNew.classList.add('card');
                cardNew.classList.add('mt-5');
                cardNew.style.width = "300px";
                imgCard.classList.add('card-img-top');
                imgCard.classList.add('mt-3');
                imgCard.setAttribute("src", `${card.photo}`);
                cardBody.classList.add('card-body');
                cardText.classList.add('card-text');
                titleCard.classList.add('title-card');
                spanTitle.classList.add('title-desc');
                spanTitle.innerText = card.title;
                spanCreated.classList.add('created-at');
                spanCreated.innerText = card.date;
                cardBottom.classList.add('card-bottom');
                managerCard.classList.add('manager-card');
                managerCard.innerText = card.manager;
                spanComments.classList.add('comments-count');
                spanComments.innerText = card.comments;
              })
    pComments.appendChild(spanComments);
    cardBottom.appendChild(managerCard);
    cardBottom.appendChild(pComments);
    titleCard.appendChild(spanTitle);
    cardText.appendChild(titleCard);
    pCreated.appendChild(spanCreated);
    cardText.appendChild(pCreated);
    cardText.appendChild(cardBottom);
    cardBody.appendChild(cardText);
    cardNew.appendChild(imgCard);
    cardNew.appendChild(cardBody);
    aCard.appendChild(cardNew);
    resultsDisplay.appendChild(aCard);
  }

  fetchCards('progress-results');
  // fetchCards('reviews-results');
  // fetchCards('completed-results');

  if (searchInput) {
    searchInput.addEventListener('input', (e) => {
      searchTerm = e.target.value;
      showCards('progress-results');
      // showCards('reviews-results');
      // showCards('completed-results');
    })
  }
}

export { searchBar };
