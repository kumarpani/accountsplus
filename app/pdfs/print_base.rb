class PrintBase < Prawn::Document

# Often-Used Constants

  def initialize()
    super(default_prawn_options={:compress => true,
                                 :optimize_objects => true,
                                 :left_margin => 85,
                                 :page_size => 'A4',
                                 :page_layout => :portrait,
                                 :right_margin => 40,
                                 :top_margin => 30})
    font_size 9
  end



end