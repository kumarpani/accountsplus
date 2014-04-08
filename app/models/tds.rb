class Tds

  def index(s_date, e_date)
      if !s_date.to_s.empty? && !e_date.to_s.empty?
        @s_date = Date.parse(s_date, '%d/%m/%Y')
        @e_date = Date.parse(e_date, '%d/%m/%Y')

        Payment.where('mode = ? AND paid_on >= ? AND paid_on <= ?',  'TDS', @s_date, @e_date).order(:paid_on)
      end
    end
end

