addMonthToParentClass = -> $('.previous-month').parent().addClass "month"

$(document).ready addMonthToParentClass
$(document).on('page:load', addMonthToParentClass)