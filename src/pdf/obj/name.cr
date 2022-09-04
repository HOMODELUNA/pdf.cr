require "./renderable"

module PDF

  class Name
    @inner : String = ""
    property :inner
    def initialize(@inner)
    end
    # This syntax is required in order to represent any of the delimiter or white-space characters or the number sign character itself; 
    # it is recommended but not required for
    # characters whose codes are outside the range 33 (!) to 126 (~)
    def self.format(io : IO,str : String) : IO
      str.each_char do |c|
        case c.ord
        when 35 # char'#'
          io <<'#' <<c.ord.to_s(16)
        when [33..126]
          io << c
        when [256..-1]
          raise "non ascii char #{c} in #{str.inspect}are not premitted in names"
        else
          io <<'#' <<c.ord.to_s(16)
        end
      end
    end
    #:ditto:
    def to_s() 
      String.build {|io|Name.format(io,@inner)}
    end
    def to_s(io : IO) 
      Name.format(io,@inner)
    end
    def render_to_pdf(io : IO) : IO
      Name.format(io,@inner)
    end
    include Renderable
    #It's helpful in binding enums with `Names` from its symbol. 
    #An example from this can be seen from `PDF::Catalog::PageLayout#to_name`:
    #```
    #Name.symcases( self,SinglePage,OneColumn,TwoColumnLeft, TwoColumnRight)
    ##expand to 
    #case self
    #when SinglePage then Name.new("SinglePage")
    #when OneColumn then Name.new("OneColumn")
    #when TwoColumnLeft then Name.new("TwoColumnLeft")
    #when TwoColumnRight then Name.new("TwoColumnRight")
    #end
    macro sym_cases(source,*namesyms)
      case {{source}}
      {%for sym in namesyms %}
      when {{sym.id}} then Name.new({{sym.id.to_s}})
      {% end %}
      end
    end
  end
end