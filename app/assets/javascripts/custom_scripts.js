/**
 * Created by shilohiaulualo on 1/28/16.
 */
$(document).ready(function(){
$( "#tabs" ).tabs({
    collapsible: true
}).tooltip().show({
    effect:"explode",
    duration:200,
    easing: "easeInOutCirc",
    queue:false,
});

});