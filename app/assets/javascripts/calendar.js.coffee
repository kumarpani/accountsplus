makeParentClassConfirmed = -> $('.Confirmed').parent().parent().addClass "Confirmed"
makeParentClassPending = -> $('.Pending').parent().parent().addClass "Pending"

$(document).ready makeParentClassConfirmed
$(document).on('page:load', makeParentClassConfirmed)

$(document).ready makeParentClassPending
$(document).on('page:load', makeParentClassPending)
