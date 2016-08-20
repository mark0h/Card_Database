//GLOBAL VARIABLES
var edit_remove_checkboxes;  //Keeps track of which Traits were checked to remove for update

$(document).ready(function() {
	// alert("document ready!");
	$("#traits_to_remove_panel").hide(); //Only show this if a trait is selected for removal
	$('#add_traits_panel').hide();
	$('.remove_trait_checkbox').prop('checked', false); //Uncheck all remove trait boxes when page is ready

	//Hidden fields
	$('.card_type_selector').change(function() {
		if($('.card_type_selector').val() == 2) {
			alert("type changed!");
			$('.hidden_option').show();
		} else {
			$('.hidden_option').hide();
		}

    $.ajax({
			url: "/filter_traits_by_type",
			type: "GET",
			data: {selected_type: $(".card_type_selector").val() }
		});

	});
});

//When the UPDATE button is clicked in the Card Edit UI
$(document).on('click', "#add_trait_card_button", function(e) {
	e.stopPropagation();
	if($('#add_traits_panel').is(":visible")) {
		$('#add_traits_panel').hide();
	} else {
		$('#add_traits_panel').show();
	}
	
});

//When the Add Trait button is clicked in the Card Edit UI
$(document).on('click', "#update_card_button", function(e) {
	e.stopPropagation();	
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


//Function on what to do when a checkbox is clicked. It builds a unsorted list in html of items selected, and adds them to the panel
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


//Function for filtering TRIATS based on TYPE selection
// $(function() {
// 	$("select#card_type_id").on("change", function() {
// 		$.ajax({
// 			url: "/filter_traits_by_type",
// 			type: "GET",
// 			data: {selected_type: $("select#card_type_id").val() }
// 		});
// 	});
// });