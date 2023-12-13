'use strict';

var QBRadialMenu = null;

$(document).ready(function(){

    window.addEventListener('message', function(event){
        var eventData = event.data;

        if (eventData.action == "closeradial") {
            QBRadialMenu.close();
        } else if (eventData.action == "openradial") {
            createMenu(eventData.items)
            QBRadialMenu.open();
        }
    });
});

function createMenu(items) {
    QBRadialMenu = new RadialMenu({
        parent      : document.body,
        size        : 375,
        menuItems   : items,
        onClick     : function(item) {
            if (item.shouldClose) {
                QBRadialMenu.close();
            }
            
            if (item.event !== null) {
                if (item.data !== null) {
                    $.post('https://vinsan_radialmenu/selectItem', JSON.stringify({
                        itemData: item,
                        data: item.data
                    }))
                } else {
                    $.post('https://vinsan_radialmenu/selectItem', JSON.stringify({
                        itemData: item
                    }))
                }
            }
        }
    });
}

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            QBRadialMenu.close();
            break;
    }
});