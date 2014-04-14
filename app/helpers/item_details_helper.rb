module ItemDetailsHelper
  def get_all_sorted_particulars
    ItemDetail.all.sort_by{|u| u.particulars.downcase}.uniq{|d| d[:particulars]}.map { |i| [i.id, i.particulars] }
  end

  def get_all_sorted_item_groups
    ItemDetail.where('item_group_name IS NOT NULL')
      .sort_by{|u| u.item_group_name.downcase}.uniq{|d| d[:item_group_name]}.map { |i| [i.id, i.item_group_name] }
  end

  def get_header_for_quotation(quotation)
    if quotation.is_a_complete_invoice?
        'Tax Invoice'
    elsif quotation.invoice_type == PROFORMA && @quotation.status == INVOICE
        'Proforma Invoice'
    else
        'Quotation'
    end
  end

end
