//GLOBAL VARIABLES
var edit_remove_checkboxes;  //Keeps track of which Traits were checked to remove for update

$(document).ready(function() {
	// alert("document ready!");
	$("#traits_to_remove_panel").hide(); //Only show this if a trait is selected for removal
	$('.remove_trait_checkbox').prop('checked', false); //Uncheck all remove trait boxes when page is ready
});

//When the UPDATE button is clicked in the Card Edit UI
$(document).on('click', "#update_card_button", function(e) {
	alert(edit_remove_checkboxes);
});

//When a "remove" checkbox is selected in the Card Edit UI
$(document).on('click', ".remove_trait_checkbox", function(e) {
	e.stopPropagation(); //prevent event from 'bubbling up' to parent tree

	if($(".remove_trait_checkbox").is(":checked")) {
		handle_trait_remove_checkbox_click();
		$("#traits_to_remove_panel").show();
	} else {
		handle_trait_remove_checkbox_click();
	}

});

function handle_trait_remove_checkbox_click() {
  
  var traits_to_remove_html = "<ul id='removed_traits_ul'>"

  edit_remove_checkboxes = $('.remove_trait_checkbox:checked').map(function () {
  	return $(this).attr('id');
  }).get();

  if(!edit_remove_checkboxes.length) {
  	$("#traits_to_remove_panel").hide(); //Hide the remove panel if no more checkboxes are selected anymore
  } else {
  	//Loop through each checkbox trait value and add to the list
  	$.each(edit_remove_checkboxes, function(index, value) {
  		final_value = value.replace(/\+/g, " ").replace(/_checkbox/g, "");
  		traits_to_remove_html += "<li id='removed_traits_li"+final_value+"'>"+final_value+"</li>"
  	});
  }

  traits_to_remove_html += "</ul>"
  $('#traits_to_remove_body').html(traits_to_remove_html); //Add final list results to the panel body of traits remove list
}