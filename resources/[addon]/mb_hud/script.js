$(function () {
	window.addEventListener('message', function (event) {
		switch (event.data.type) {
			case 'setData':
				$('.player-info span').html(
					`ID: ${event.data.id} | ${event.data.job} - ${event.data.grade}`
				);
				$('.watermark').html(event.data.watermark);
				$('.icon').html(`<img src="img/${event.data.jobname}.png"/>`);
				break;
			case 'display':
				$('body').show();
				if (!event.data.idjob) $('.player-info').hide();
				if (!event.data.watermark) $('.watermark').hide();
				break;
			default:
				break;
		}
	});
});
