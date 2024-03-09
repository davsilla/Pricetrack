function generateItemDataInputs(i, storeList = []) {
	const datalistOpts = storeList.map(s => `<option value="${s.name}"></option>`).join("\n");
	const htmlString = `
	<div class="mb-3">
		<label for="urlInput${i}" class="form-label">url</label>
		<input type="url" name="url" class="form-control" id="urlInput${i}" required>
	</div>
	<div class="mb-3">
		<label for="itemXpathInput${i}" class="form-label">price xpath</label>
		<input type="text" name="xpath" class="form-control" id="itemXpathInput${i}" required>
	</div>
	<div class="row store-info">
		<!-- store id -->
		<div class="col mb-3 d-none">
			<label for="storeIdInput${i}" class="form-label">store id</label>
			<input type="text" name="store_id" class="form-control rounded-0 store-info-id" id="storeIdInput${i}" placeholder="a2717f42-56d9-41e8-bb2a-40e2f339578d">
		</div>
		<!-- store name -->
		<div class="col mb-3">
			<label for="storeNameInput${i}" class="form-label">store name</label>
			<input name="store_name" class="form-control store-info-name" list="storeNameOptions${i}" id="storeNameInput${i}" placeholder="Type to search...">
			<datalist id="storeNameOptions${i}">
				${datalistOpts}
			</datalist>
		</div>
		<!-- store url -->
		<div class="col-sm-8 mb-3">
			<label for="storeUrlInput${i}" class="form-label">store url <span class="text-secondary">(optional)</span></label>
			<input type="text" name="store_url" class="form-control rounded-0 store-info-url" id="storeUrlInput${i}" placeholder="https://www.amazon.com">
		</div>
	</div>
	<button class="btn btn-danger rounded-0 delete-item-data-btn mt-2" style="width: 100%;">
		<i class="bi bi-trash3"></i>
	</button>
	`;
	return htmlString;
}

let numOfItems = 0;
const stores = JSON.parse(document.currentScript.getAttribute("stores"));

const addItemForm = document.getElementById("addItemForm");
const addItemStoreDataContainer = document.getElementById("addItemStoreDataContainer");
const addItemStoreDataBtn = document.getElementById("addItemStoreData");

addItemForm.addEventListener("keyup", function (ev) {
	const target = ev.target;
	if (target.classList.contains("delete-item-data-btn")) {
		target.parentElement.remove();
		ev.preventDefault();
		return;
	}
	if (target.classList.contains("store-info-name")) {
		target.addEventListener("change", function (ev) {
			const pe = target.parentElement.parentElement;
			const ob = stores.find(o => o.name.toLowerCase() === ev.target.value.toLowerCase());
			const url = pe.querySelector(".store-info-url");
			const id = pe.querySelector(".store-info-id");
			if (ob) {
				target.value = ob.name;
				url.value = ob.url;
				id.value = ob.id;
				url.setAttribute("readonly", "");
			} else {
				id.value = "";
				url.value = "";
				url.removeAttribute("readonly");
			}
		});
	}
});

addItemStoreDataBtn.addEventListener("click", function (ev) {
	const newItemInputs = document.createElement("div");

	newItemInputs.classList.add("border", "border-1", "border-dark", "px-3", "pt-3", "pb-4", "mb-3", "item-store-data");
	newItemInputs.innerHTML = generateItemDataInputs(numOfItems, stores);
	numOfItems += 1;

	addItemForm.insertBefore(newItemInputs, addItemStoreDataContainer);
	ev.preventDefault();
});
