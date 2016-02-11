$(function() {                  /*-----------------------this is the code for results clicking---------------------*/
    $('#main').hide();
});

$('body').on('click','nav a', function(e) {
    $('.profile_main_col').show();
    $('#result_feed').children().hide();
    $($(this).attr('href')).show();
    e.preventDefault();           /*-----------------------end code for results clicking---------------------*/
});