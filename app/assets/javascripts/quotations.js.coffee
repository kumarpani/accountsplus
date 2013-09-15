addDatePicker = -> $('#quotation_event_date').datepicker {format: 'yyyy-mm-dd'}

$(document).ready addDatePicker
$(document).on('page:load', addDatePicker)
