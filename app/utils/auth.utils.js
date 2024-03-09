function extractFlashMessages(req) {
	var messages = [];
	// Check if flash messages was sent. If so, populate them.
	var errorFlash = req.flash("error");
	var successFlash = req.flash("success");

	// Look for error flash.
	if (errorFlash && errorFlash.length) messages.push({ error: errorFlash[0] });

	// Look for success flash.
	if (successFlash && successFlash.length) messages.push({ success: successFlash[0] });

	return messages;
}

module.exports = { extractFlashMessages };
