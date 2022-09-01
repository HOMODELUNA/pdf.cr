module PDF

  class Name
    @inner : String = ""
    property :inner
    def initialize(@inner)
    end
    # This syntax is required in order to represent any of the delimiter or white-space characters or the number sign character itself; 
    # it is recommended but not required for
    # characters whose codes are outside the range 33 (!) to 126 (~)
    def self.format(str : String) : String
      String.build do |builder|
        str.each_char do |c|
          case c.ord
          when 35 # char'#'
            builder <<'#' <<c.ord.to_s(16)
          when [33..126]
            builder << c
          when [256..-1]
            raise "non ascii char #{c} in #{str.inspect}are not premitted in names"
          else
            builder <<'#' <<c.ord.to_s(16)
          end
        end
      end
    end
    #:ditto:
    def to_s() 
      Name.format(str)
    end
  end
end