console.log("working");
console.log(_.first([1,2,3]));
$(document).on("e","#iddoes",function() {

})

// $(document).on("ready", function() { ->
//   $("#id1").on("ajax:success", function(e, data, status, xhr) ->
//     $('body').append xhr.responseText
//     console.log(data)
//   ).on "ajax:error", (e, xhr, status, error) ->
//     $("#new_article").append "<p>ERROR</p>"
// });

$(document).ready(function() {
	$("#id1").on("ajax:success", function(e, data, status, xhr) {
		// append filter form to the DOM
		
	})
});