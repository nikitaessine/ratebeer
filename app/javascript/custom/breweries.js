const BREWERIES = {};

const handleResponse = (breweries) => {
  BREWERIES.list = breweries;
  BREWERIES.show();
};

const createTableRow = (brewery) => {
  const tr = document.createElement("tr");
  tr.classList.add("tablerow");
  const breweryname = tr.appendChild(document.createElement("td"));
  breweryname.innerHTML = brewery.name;
  const founded = tr.appendChild(document.createElement("td"));
  founded.innerHTML = brewery.year;
  const beers = tr.appendChild(document.createElement("td"));
  console.log(brewery.beers);
  beers.innerHTML = brewery.beers.length;
  const active = tr.appendChild(document.createElement("td"));
  active.innerHTML = brewery.active ? "Yes" : "No";

  return tr;
};

BREWERIES.show = () => {
  console.log("opa")
  document.querySelectorAll(".tablerow").forEach((el) => el.remove());
  const table = document.getElementById("brewerytable");

  BREWERIES.list.forEach((brewery) => {
    const tr = createTableRow(brewery);
    table.appendChild(tr);
  });
};

BREWERIES.sortByName = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  });
};

BREWERIES.sortByYear = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year - b.year;
  });
};

BREWERIES.sortByBeerCount = () => {
  BREWERIES.list.sort((a, b) => {
    return a.beers.length - b.beers.length;
  });
};

const breweries = () => {
  console.log("opa")
  if (document.querySelectorAll("#brewerytable").length < 1) return;

  document.getElementById("name").addEventListener("click", (e) => {
    e.preventDefault();
    BREWERIES.sortByName();
    BREWERIES.show();
  });

  document.getElementById("founded").addEventListener("click", (e) => {
    e.preventDefault();
    BREWERIES.sortByYear();
    BREWERIES.show();
  });
  
  document.getElementById("beers").addEventListener("click", (e) => {
    e.preventDefault();
    BREWERIES.sortByBeerCount();
    BREWERIES.show();
  });

  fetch("breweries.json")
    .then((response) => response.json())
    .then(handleResponse);
};

export { breweries };