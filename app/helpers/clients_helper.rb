module ClientsHelper
  def get_all_sorted_companies
    Client.all.sort_by{|c| c.company_name.downcase}.map { |client| [client.company_name, client.id] }
  end

end
