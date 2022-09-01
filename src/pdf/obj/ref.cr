module PDF
  struct PdfRef
    @target =0
    @version =0
    def initizlize(@target,  @version=0)
    end
    def to_s()
      "#{@target} #{@version} R"
    end
  end
end