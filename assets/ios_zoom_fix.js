document.querySelector("head meta[name=viewport]").remove();
var newMeta = document.createElement("meta");
newMeta.name = "viewport";
newMeta.content =
  "width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=0";
document.querySelector("head").prepend(newMeta);
