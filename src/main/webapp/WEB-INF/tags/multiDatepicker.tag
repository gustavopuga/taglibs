<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="allowDates" required="true" type="java.lang.String"
	description="Allow dates"%>

<div id="multiDatepicker">
	<div id="inputs"></div>
</div>
<script>
	
	var selectDates = new Array();
    var availableDates = ${allowDates};
    
	function formatMinTwoDigits(number) {
		return number > 9 ? "" + number : "0" + number;
	}
	
	function formatDateBR(date) {

		var day = formatMinTwoDigits(date.getDate());
		var month = formatMinTwoDigits(date.getMonth() + 1);
		var year = formatMinTwoDigits(date.getFullYear());

		return day + '/' + month + '/' + year;
	}

	function formatDateUS(date) {

		var day = formatMinTwoDigits(date.getDate());
		var month = formatMinTwoDigits(date.getMonth() + 1);
		var year = formatMinTwoDigits(date.getFullYear());

		return month + '/' + day + '/' + year;
	}
	
	function convertDateUSToBR(dateString) {
		return formatDateBR(new Date(dateString));
	}
	
	function convertDateBRToUS(dateString) {
		
		var date = new Date(dateString);
		var month = date.getDate() - 1;
		var day = date.getMonth() + 1;
		
		date.setDate(day);
		date.setMonth(month);
		
		return formatDateUS(date);
	}
	
	function createInputDate(date, index){
		
		var inputDate = $("<input>").attr("type", "hidden");
		inputDate.attr("id", "dates[" + index + "]");
        inputDate.attr("name", "dates[" + index + "]");
        inputDate.val(convertDateUSToBR(date));
        $("#inputs").append(inputDate);
	}
	
	function gotSelectDate(date) {
		return $.inArray(date, selectDates) >= 0;
	}
	
	function addDate(date) {
		if (!gotSelectDate(date)){
			createInputDate(date, selectDates.length);
			selectDates.push(date);
		}
	}
	
	function removeDate(index) {
		selectDates.splice(index, 1);
		
		$("#inputs").remove();
		var inputDiv = $("<div>");
		inputDiv.attr("id", "inputs");
		$("#multiDatepicker").append(inputDiv);
		
		$(selectDates).each(function(index, date){
			createInputDate(date, index);
		});
	}

	// Adds a date if we don't have it yet, else remove it
	function addOrRemoveDate(date) {
		var index = $.inArray(date, selectDates);
		index >= 0 ? removeDate(index) : addDate(date);
	}

	function applyStyle(date) {

		var style;
		var dateString = formatDateUS(date);
		
		if (gotSelectDate(dateString)) {
			// Enable date so it can be deselected. Set style to be highlighted
			style = [ true, "ui-state-active ui-state-highlight", "Selecionado" ];
		} else {
			// Dates not in the array are left enabled, but with no extra style
			style = [ true, "", "Disponível" ];
		}
		
		return style;
	}

	function available(date) {
		
		var style;
		var dateToString = formatDateBR(date);
		
		if ($.inArray(dateToString, availableDates) != -1) {
			style = applyStyle(date);
		} else {
			// Unable date so it can't be selected.
			style = [ false, "", "Indisponí­vel" ];
		}
		
		return style;
	}

	function selectDate (dateText, inst){
		convertDateBRToUS(availableDates[1]);
		addOrRemoveDate(dateText);
	}
	
	$(function() {
		$("#multiDatepicker").datepicker({
			onSelect : selectDate,
			beforeShowDay : available,
			defaultDate: convertDateBRToUS(availableDates[1]),
			numberOfMonths : 3
		});
	});
</script>
