function generateItemCard(id, name, model, brand, price, priceChange, imgUrl, imgAlt, lastUpdate, status) {
	let priceChangeIcon = "";
	let cardUpdateFooter = "";

	if (priceChange > 0) {
		priceChangeIcon = `
		<div class="mx-3 text-danger">
			<i class="bi bi-arrow-up"></i>
			<span id="priceChange">${priceChange}</span>
		</div>
		`;
	} else if (priceChange < 0) {
		priceChangeIcon = `
		<div class="mx-3 text-success">
			<i class="bi bi-arrow-down"></i>
			<span id="priceChange">${priceChange}</span>
		</div>
		`;
	}

	if (lastUpdate && status == "OK") {
		cardUpdateFooter = `
		<div class="card-footer">
			<small id="lastUpdate" class="text-secondary">last updated ${lastUpdate}</small>
		</div>
		`;
	} else if (status != "OK" && status != "NEW") {
		cardUpdateFooter = `
		<div class="card-footer">
			<small id="lastUpdate" class="text-danger">${status}</small>
		</div>
		`;
	} else {
		cardUpdateFooter = `
		<div class="card-footer">
			<small id="lastUpdate" class="text-secondary">item not scanned</small>
		</div>
		`;
	}

	const htmlString = `
	<div class="card rounded-0">
		<div class="card-img-top d-flex justify-content-center align-items-center" style="height: 215px;">
			<img src="${imgUrl}" class="p-3" style="max-height: 100%; max-width: 100%;" alt="${imgAlt}" />
		</div>
		<div class="card-body">
			<h5 class="card-title">
				<a href="/item/data/${id}" class="text-decoration-none">${name}</a>
			</h5>
			<div class="d-flex align-items-center justify-content-start">
				<h3 id="price" class="mt-2">$${status == "NEW" ? "--.--" : price}</h3>
				${priceChangeIcon}
			</div>
		</div>
		<ul class="list-group list-group-flush">
			<li class="list-group-item">${model}</li>
			<li class="list-group-item">${brand}</li>
		</ul>
		${cardUpdateFooter}
	</div>	
	`;
	return htmlString;
}

function addItemCards() {
	const cardContainer = document.getElementById("cardContainer");
	const items = JSON.parse(document.currentScript.getAttribute("items"));

	items.forEach(item => {
		const itemCard = document.createElement("div");
		let price, priceChange, lastUpdate, status;
		item.list.forEach(i => {
			if (!price || i.price < price) {
				price = i.price;
				priceChange = i.price_diff;
				lastUpdate = i.last_update;
				status = i.status;
			}
		})
		itemCard.classList.add("col");
		itemCard.innerHTML = generateItemCard(item.info_id, item.name, item.model, item.brand, (price / 100).toFixed(2), (priceChange / 100).toFixed(2), item.image_url, "product image", new Date(lastUpdate).toLocaleString(), status);
		cardContainer.appendChild(itemCard);
	});
}

addItemCards();
