module QuotationsHelper
  def get_terms_and_conditions
    return [

    "Any Additional Requirements Charges will be extra",
    "Above Materials are on hire basis only",
    "AV Creations, does not take any responsibility for the loss or theft of personal belongings at the Venue",
    "Cheque Should be issued in favor of  M/s AV Creations.",
    "Service Provided for 24 Hrs & 365 Days.",
    "The above Rates are on day charges. If you require it more than a day, charges will be Calculated as per your requirement.",
    "Payment Terms – 50% in advance as Cheque, DD or Pay Order on conformation of the event with P.O or letter of conformation & Rest 50% of the payment should be made 2 days before the event.",
    "12.36% Service Tax Extra on the Billing Amount.",
    "Order should confirm at least 30 days before the Event.",
    "Order should confirm at least 15 days before the Event.",
    "Order should confirm at least 10 days before the Event.",
    "Order should confirm at least 5 days before the Event.",
    "Order should confirm at immediately.",
    "Our charge is applicable to the period of hire stipulated in the Work order or quotation submitted. Any extension to the hire period will be subject to additional hire charges dependent on availability of equipment and resources at time of request.",
    "Power should be provided from your end.",
    "Payment to make in favor of “AV Creations” payable in Bangalore.",
    "All Services or items over and above those stated in quotation will be charged as an extra to the   client.  These areas may include additions to pre-production work and on-site requests. The client will be informed of any additional costs prior to the request being carried out.",
    "It is the responsibility of the client to ensure that all necessary permissions, copyrights and authorizations have been obtained, unless otherwise agreed in writing.",
    "If the event is not held on that date and is cancelled or postponed due to any reason whatsoever, the amount is non-refundable and it cannot be used or adjusted for another event.",
    "We are not responsible if the show is not possible due to rains and other natural calamities after conformation of the dates of the events.",
    "If in the event of rain the equipment will not be powered on, if adequate shelter is not provided.",
    "Security, Shelter and Protection for the equipment are your responsibility and any damages resulting due to its lapse is your liability at the venue.",
    "During show rig and de-rig, AV Creations personnel will ensure care is displayed with regards to the Venue/site. However, we cannot be held responsible for any damage caused during the normal Construction and transportation of our equipper.",
    "Although AV Creations will use all reasonable endeavors to meet its obligations in a prompt and efficient manner, it does not accept responsibility for any failure or delay caused by circumstances beyond its control.",
    "Stage & Speaker Platforms to be provided by the organizers. These can be organized with prior Negotiations. The dimensions of the speaker platforms and the tables required for the FOH/DJ Console and any other relevant details will be provided after conformation of the event.",
    "Relevant Permissions form Police, Excise, Fire, and Local Authorities. NGO’s or any other Government Organizations should be in order and is your responsibility.",
    "If the equipment is seized, withheld, confiscated or detained for any reason whatsoever it is your responsibility to restore it back to AV Creations in its original state and all expenses towards it Reinstatement is completely yours.",
    "Additional genset hour will cost Rs.1000 for 62.5 KVA (beyond 5 hours).",
    "Additional genset hour will cost Rs.1300 for 82 KVA (beyond 5 hours).",
    "Additional genset hour will cost Rs.1700 for 110 KVA (beyond 5 hours).",
    "The above equipment and dates are subject to availability at the time of confirmation.",
    "Event management fee 10% on the total billing.",
    "Event management fee 15% on the total billing.",
    "Event management fee 20% on the total billing.",
    "Venue should be avilable much before the event.",
    "Technician’s Food, Stay & T/A to be arranged from your end.",

  ]

  end

  def get_all_sorted_venues
    Quotation.all.sort_by{|q| q.venue.downcase}.uniq{|d| d[:venue]}.map { |i| [i.id, i.venue] }
  end
end
