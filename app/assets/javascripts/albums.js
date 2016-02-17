// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery(document).on("ready page:change", function() {

    $('#myCarousel').carousel({
        interval: 5000
    });

    $('#carousel-text').html($('#slide-content-0').html());

    //Handles the carousel thumbnails
    $('[id^=carousel-selector-]').click( function(){
        var id = this.id.substr(this.id.lastIndexOf("-") + 1);
        var id = parseInt(id);
        $('#myCarousel').carousel(id);
    });


    // When the carousel slides, auto update the text
    $('#myCarousel').on('slid.bs.carousel', function (e) {
        var id = $('.item.active').data('slide-number');
        $('#carousel-text').html($('#slide-content-'+id).html());
    });

    var username = $(".album_search_ajax").data('username');
    $(".album_search_ajax").select2({
        ajax: {
            url: "/user/"+username+"/albums.json",
            dataType: 'json',
            delay: 200,
            data: function (params) {
                return {
                    query: params.term
                };
            },
            processResults: function (data, params) {
                // parse the results into the format expected by Select2
                // since we are using custom formatting functions we do not need to
                // alter the remote JSON data, except to indicate that infinite
                // scrolling can be used
                params.page = params.page || 1;

                return {
                    results: $.map(data.items, function(item){
                        item.id = item.title;
                        return item;
                    })
                    /*pagination: {
                        more: (params.page * 30) < data.total_count
                    }*/
                };
            },
            cache: false /* enable in production mode */
        },
        multiple: true,
        minimumInputLength: 1,
        tags:true,
        tokenSeparators: [',']
    });
});

