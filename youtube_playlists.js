document.querySelectorAll("[aria-label^='Action menu']")[1].click();
document.querySelectorAll(".ytd-menu-service-item-renderer")[8].click();
document.querySelectorAll(".style-scope tp-yt-paper-checkbox")[1].click();
await new Promise(resolve => setTimeout(resolve, 500));
$(".style-scope.ytd-add-to-playlist-renderer").children[1].click();

// Move to second playlist
var delay = 800;
function get_elements_by_inner(word) {
    res = []
    elems = [...document.getElementsByTagName('yt-formatted-string')];
    elems.forEach((elem) => {  if(elem.outerHTML.includes(word)) { res.push(elem) } })
    return(res)
}

items = Array.prototype.slice.call(document.querySelectorAll("[aria-label^='Action menu']")).reverse()
items.pop()
for (const menu of items) {
  await new Promise(resolve => setTimeout(resolve, delay));
  menu.click();
  await new Promise(resolve => setTimeout(resolve, delay));
  get_elements_by_inner('Save to playlist')[0].click();
  await new Promise(resolve => setTimeout(resolve, delay));
  document.querySelectorAll("#label[title^='Music']")[0].click()
  await new Promise(resolve => setTimeout(resolve, delay));
  document.querySelectorAll("#close-button")[0].click()
}

// Delete all
var delay = 300;
items = Array.prototype.slice.call(document.querySelectorAll("[aria-label^='Action menu']")).reverse()
items.pop()
for (const menu of items) {
  menu.click();
  await new Promise(resolve => setTimeout(resolve, delay));
  document.querySelectorAll(".ytd-menu-service-item-renderer")[12].click();
}


// Find diff
let videos = []
for (const video of document.querySelectorAll('.yt-simple-endpoint.style-scope.ytd-playlist-video-renderer')) {
  videos.push(video.title)
}

console.log(vid.filter(n => !videos.includes(n)))
