module ItemDetailsHelper
  def get_all_sorted_particulars
    ItemDetail.all.sort_by{|u| u.particulars.downcase}.uniq{|d| d[:particulars]}.map { |i| [i.id, i.particulars] }
  end

end
