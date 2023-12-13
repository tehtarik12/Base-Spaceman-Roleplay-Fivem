var logo = document.getElementById("logo-container");
var serverName = document.getElementById("name-container");
var link = document.getElementById("link-container");

var nameText = document.getElementById("name");
var linkText = document.getElementById("link");
var SpawnLocation = null
var value = null

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

window.addEventListener('message', (event) => {
    if (event.data.type === 'setup') {
      nameText.innerHTML = event.data.nametext;
      linkText.innerHTML = event.data.linktext;
    }
});

window.addEventListener('message', (event) => {
    if (event.data.type === 'showItem') {
      logo.style.opacity = 0 + '%';
      serverName.style.opacity = 0 + '%';
      link.style.opacity = 0 + '%';

      sleep(1000).then(() => {
        if (event.data.item === 'link') {
          link.style.opacity = 100 + '%';
        } else if (event.data.item === 'name') {
          serverName.style.opacity = 100 + '%';
        } else if (event.data.item === 'logo') {
          logo.style.opacity = 100 + '%';
        }
      });
    } else if (event.data.show == true) {
        event.preventDefault();
        $(".spawn-container").fadeIn(400)
    } else if (event.data.show == false) {
        event.preventDefault();
        $(".spawn-container").fadeOut(400)
    } else if (event.data.setup == true) {
        AppendTypes(event.data.locations)
    }
});

$(document).on('click', '#Name', function(evt){
  evt.preventDefault();
  value = $(this).text();
  value = (value.split(" ")[1]).toLowerCase()
  if (SpawnLocation !== null) {$(SpawnLocation).css("backgroundColor", "#5185ff")};
  if (SpawnLocation !== null) {$(SpawnLocation).css("boxShadow", "0 8px #2b488a")};
  if (SpawnLocation !== null) {$(SpawnLocation).css("color", "#EDF2F3")};

  $(this).css("backgroundColor", "#17ac6e");
  $(this).css("boxShadow", "0 8px #128555");
  $(this).css("color", "#000000");
  $.post("https://vinsan_core/Preview", JSON.stringify({location: value}));
  $("#Spawn").fadeIn(400)
  SpawnLocation = $(this)
});

$(document).on('click', '#Spawn', function(evt){
  if (SpawnLocation !== null) {
      $(".spawn-container").fadeOut(500, function () {
          $.post("https://vinsan_core/Spawn", JSON.stringify({spawn: value}));
          $("#Spawn").fadeOut(400)
      });
  };
});

function AppendTypes(locations) {
  var parent = $('.spawn-list-container')
  $(parent).html("");    
  $.each(locations, function(index, location){
      $(parent).append('<div class="spawn-card"><div id="Name"><i class="'+location.icon+'"></i> '+location.label+'</div></div>')
  });
  $(parent).append('<div class="spawner-card"><div id="Spawn">Spawn Now</div></div>');
}