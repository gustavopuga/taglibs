<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="allowDates" required="true" type="java.lang.String"
	description="Allow dates"%>

<style type="text/css">

#multiDatepicker {
	font-size: 1.5em;
}

#multiDatepicker .ui-state-highlight {
    /*copiar ui-state-default do jquery-ui-1.10.3.custom.css*/
    border: 1px solid #cccccc;
	background: #f6f6f6 url(images/ui-bg_glass_100_f6f6f6_1x400.png) 50% 50% repeat-x;
	font-weight: bold;
	color: #1c94c4;
}

#multiDatepicker .ui-state-hover, #multiDatepicker .ui-state-hover:hover {
    /*copiar ui-state-highlight do jquery-ui-1.10.3.custom.css*/ 
    border: 1px solid #fbcb09;
	background: #fdf5ce url(images/ui-bg_glass_100_fdf5ce_1x400.png) 50% 50% repeat-x;
	font-weight: bold;
	color: #c77405;
}

#multiDatepicker .ui-state-active { 
    /*copiar ui-state-default do jquery-ui-1.10.3.custom.css*/
    border: 1px solid #cccccc;
	background: #f6f6f6 url(images/ui-bg_glass_100_f6f6f6_1x400.png) 50% 50% repeat-x;
	font-weight: bold;
	color: #1c94c4;
}

#multiDatepicker .highlight a,
#multiDatepicker .highlight a:link,
#multiDatepicker .highlight a:visited {
	/*copiar ui-state-active do jquery-ui-1.10.3.custom.css*/
	border: 1px solid #fbd850 !important;
	background: #ffffff url(images/ui-bg_glass_65_ffffff_1x400.png) 50% 50% repeat-x !important;
	font-weight: bold !important;
	color: #eb8f00 !important;
}

</style>

<div id="multiDatepicker">
	<div id="inputs"></div>
</div>

<script>
	var selectDates = new Array();
	var availableDates = ${allowDates};

	function formatMinTwoDigits(number) {
		return number > 9 ? "" + number : "0" + number;
	}

	function formatDate(date) {

		var day = formatMinTwoDigits(date.getDate());
		var month = formatMinTwoDigits(date.getMonth() + 1);
		var year = formatMinTwoDigits(date.getFullYear());

		return day + '/' + month + '/' + year;
	}

	function createInputDate(date, index) {

		var inputDate = $("<input>").attr("type", "hidden");
		inputDate.attr("id", "dates[" + index + "]");
		inputDate.attr("name", "dates[" + index + "]");
		inputDate.val(date);
		$("#inputs").append(inputDate);
	}

	function gotSelectDate(date) {
		return $.inArray(date, selectDates) >= 0;
	}

	function addDate(date) {
		if (!gotSelectDate(date)) {
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

		$(selectDates).each(function(index, date) {
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
		var dateString = formatDate(date);

		if (gotSelectDate(dateString)) {
			// Enable date so it can be deselected. Set style to be highlighted
			// 			ui-state-active ui-state-highlight
			style = [ true, "highlight", "Selecionado" ];
		} else {
			// Dates not in the array are left enabled, but with no extra style
			style = [ true, "", "Disponível" ];
		}

		return style;
	}

	function available(date) {

		var style;
		var dateToString = formatDate(date);

		if ($.inArray(dateToString, availableDates) != -1) {
			style = applyStyle(date);
		} else {
			// Unable date so it can't be selected.
			style = [ false, "", "Indisponí­vel" ];
		}

		return style;
	}

	function selectDate(dateText, inst) {
		addOrRemoveDate(dateText);
	}

	$(function() {
		$("#multiDatepicker").datepicker(
				{
					onSelect : selectDate,
					beforeShowDay : available,
					defaultDate : availableDates[1],
					numberOfMonths : 1,
					dateFormat : 'dd/mm/yy',
					dayNames : [ 'Domingo', 'Segunda', 'Terça', 'Quarta',
							'Quinta', 'Sexta', 'Sábado' ],
					dayNamesMin : [ 'D', 'S', 'T', 'Q', 'Q', 'S', 'S', 'D' ],
					dayNamesShort : [ 'Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex',
							'Sáb', 'Dom' ],
					monthNames : [ 'Janeiro', 'Fevereiro', 'Março', 'Abril',
							'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro',
							'Outubro', 'Novembro', 'Dezembro' ],
					monthNamesShort : [ 'Jan', 'Fev', 'Mar', 'Abr', 'Mai',
							'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez' ],
					nextText : 'Próximo',
					prevText : 'Anterior'
				});
	});
</script>
