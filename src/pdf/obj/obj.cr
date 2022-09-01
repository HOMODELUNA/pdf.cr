require "./stream"
require "./ref"
module PDF

  class Name
    @value : String
    def initialize(@value)
    end
  end

  # PDF supports eight basic types of object,five atoms and three comprehensives: 
  #- Boolean values
  #- Integer and real numbers
  #- Strings
  #- Names
  #- Arrays
  #- Dictionaries
  #- Streams
  #- The null object (represented as nil in crystal)
  alias ObjType = Int64 | Float64 | String | Name | Bool | Nil \
    | Array(ObjType) | Hash(String,ObjType) | Stream | PdfRef 

  
  abstract class PdfObj
    
    abstract def id : Int64?
    
    def generation
      0
    end

    def self.raw_output(obj : ObjType,io)
      case obj
      when Int64,Float64,Bool
        io<< obj
      when String
        io << '<'
        obj.each_codepoint{|cp| (cp & 0xFF).to_s(io,base: 16,precision: 2)}
        io << '>'
      when Name,PdfRef
        io << obj.to_s
      when Nil
        io << "null"
      when Array(ObjType)
        io << "["
        obj.map{ |o|String.build{|builder| self.raw_output(v,builder) } }.join(io,' ')
        io << "]"
      when Hash(String,ObjType)
        io << "<<"
        obj.map{|k,v|"#{Name.format(k)} #{String.build{|builder| self.raw_output(v,builder) }}"}.join(io,' ')
        io << ">>"
      when Stream
        obj.raw_output(io)
      end
    end
    def output(io)
      
    end

    private def string_excape(io)
    end
  end
end