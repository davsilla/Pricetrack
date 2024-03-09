const item = JSON.parse(document.currentScript.getAttribute("item"));

function setItemCardData() {
	const itemPrice = document.getElementById("itemPrice");
	const itemStorePageLink = document.getElementById("itemStorePageLink");
	const itemUpdateText = document.getElementById("itemUpdateText");
	const itemPriceChange = document.getElementById("itemPriceChange");

	let minPrice = null;
	let priceDiff = null;
	let minPriceIndex = null;

	item.list.forEach((o, i) => {
		if ((!minPrice && o.price > 0) || minPrice > o.price) {
			minPriceIndex = i;
			minPrice = o.price;
			if (o.price_diff !== 0) {
				priceDiff = o.price_diff;
			}
		}
	});

	if (minPrice) {
		itemPrice.innerText = (minPrice / 100).toFixed(2);
		itemStorePageLink.href = item.list[minPriceIndex].url;
		itemUpdateText.innerText = "last updated " + new Date(item.list[minPriceIndex].last_update).toLocaleString();
	} else {
		itemUpdateText.innerText = "item not scanned";
		itemStorePageLink.href = item.list[0].url;
	}

	if (priceDiff > 0) {
		itemPriceChange.classList.add("text-danger");
		itemPriceChange.innerHTML = `<i class="bi bi-arrow-up"></i>${(priceDiff / 100).toFixed(2)}
		`;
	} else if (priceDiff < 0) {
		itemPriceChange.classList.add("text-success");
		itemPriceChange.innerHTML = `<i class="bi bi-arrow-down"></i>${(priceDiff / 100).toFixed(2)}
		`;
	}
}

setItemCardData();
