class PrintBase < Prawn::Document

# Often-Used Constants

  def initialize()
    super(default_prawn_options={:left_margin => 105, :page_size => 'A4', :page_layout => :portrait, :right_margin => 2, :top_margin => 30})
    font_size 9
  end



end