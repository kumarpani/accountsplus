# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Audioplus::Application.initialize!

# Quotation Type and Status
PENDING = 'Pending'
CONFIRMED = 'Confirmed'
INVOICE = 'Invoice'
CLOSED = 'Closed'
PROFORMA = 'Proforma Invoice'
