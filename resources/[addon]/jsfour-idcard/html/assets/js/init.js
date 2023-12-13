$(document).ready(function(){
  // LUA listener
  window.addEventListener('message', function( event ) {
    if (event.data.type == 'open') {
      var type        = event.data.typecard;
      var userData    = event.data.array['user'];
      var licenseData = event.data.array['licenses'];
      var sex         = userData.sex;
      $('.container').css('width','100%');
      $('.container').css('height', '100%');

      $('#jobname').hide();
      $('#namebadge').hide();
      $('#img-badge').hide();

      if ( type == 'sim' || type == 'ktp') {
          $('#img-card').show();
          $('#name').css('color', '#282828');

          if ( sex.toLowerCase() == 'm' ) {
            $('#img-card').attr('src', 'assets/images/male.png');
              $('#sex').text('Pria');
          } else {
              $('#img-card').attr('src', 'assets/images/female.png');
              $('#sex').text('Wanita');
          }

          $('#name').text(userData.firstname + ' ' + userData.lastname);
          $('#dob').text(userData.dateofbirth);
          $('#height').text(userData.height);
          $('#signature').text(userData.firstname + ' ' + userData.lastname);

          if ( type == 'sim' ) {
              if ( licenseData != null ) {
                  Object.keys(licenseData).forEach(function(key) {
                      var type = licenseData[key].type;

                      if ( type == 'drive_bike') {
                          type = 'SIM Motor';
                      } else if ( type == 'simt' ) {
                          type = 'SIM Mobil';
                      } else if ( type == 'simc' ) {
                          type = 'SIM Helikopter';
                      } else if ( type == 'simd' ) {
                          type = 'SIM Pesawat';
                      }

                      if ( type == 'SIM Motor' || type == 'SIM Mobil' || type == 'SIM Helikopter' || type == 'SIM Pesawat' ) {
                          $('#licenses').append('<p>'+ type +'</p>');
                      }
                  });
              }
              $('#id-card').css('background', 'url(assets/images/license.png)');
          } else {
              $('#id-card').css('background', 'url(assets/images/idcard.png)');
          }
      } else if ( type == 'license' ) {
          $('#img-card').hide();
          $('#name').css('color', '#d9d9d9');
          $('#name').text(userData.firstname + ' ' + userData.lastname);
          $('#dob').text(userData.dateofbirth);
          $('#signature').text(userData.firstname + ' ' + userData.lastname);

          $('#id-card').css('background', 'url(assets/images/firearm.png)');
      } else if ( type == 'badge' ) {
          if ( sex.toLowerCase() == 'm' ) {
              $('#img-badge').attr('src', 'assets/images/male.png');
          } else {
              $('#img-badge').attr('src', 'assets/images/female.png');
          }

          $('#img-card').hide();
          $('#img-badge').show();
          $('#jobname').text(userData.gradename);
          $('#jobname').show();
          $('#namebadge').text(userData.firstname + ' ' + userData.lastname);
          $('#namebadge').show();

          $('#id-card').css('background', 'url(assets/images/badge.png)');
      }
      $('#id-card').show();
  } else if (event.data.type == 'close') {
      $('#name').text('');
      $('#dob').text('');
      $('#height').text('');
      $('#signature').text('');
      $('#sex').text('');
      $('#id-card').hide();
      $('#licenses').html('');
    }
  });
});
