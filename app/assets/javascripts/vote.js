$(document).on("page:change", function(){
    $('body').on('click', '.vote_buttons img', function(e){
        var vote_container = $(e.target).parent();
        var item_id = vote_container.data("item-id");
        var item_type = vote_container.data("item-type");
        var vote_value = $(e.target).data('vote-value');
        $.ajax({
            url: '/api/vote.json',
            type: 'POST',
            data: {
                vote: {
                    item_id: item_id,
                    item_type: item_type,
                    value: vote_value
                }
            },
            success: function(response){
                vote_container.replaceWith(response.html);
                //vote_container.all('.vote_buttons img').click(click_handler);
            }
        });
    });
});