require "../obj"
module PDF::Data
  #A *number tree* is similar to a name tree (see Section 3.8.4, “Name Trees”), except
  # that its keys are integers instead of strings, sorted in ascending numerical order.
  # The entries in the leaf (or root) nodes containing the key-value pairs are named
  # *Nums* instead of *Names* as in a name tree. Table 3.24 shows the entries in a number tree’s node dictionaries.
  class NumberTree
    enum Type
      Root
      Intermediate
      Leaf
    end
    @type : Type
    #An array of indirect references to the immediate children of this node. 
    #The children may be intermediate or leaf nodes. 
    @kids : Array(NumberTree) 
    # An array of the form 
    #
    # [key1 value1 key2 value2 … keyn valuen]
    #
    # where each *keyi* is an integer and the corresponding *valuei* is an indirect reference to the object associated with that key. 
    # The keys are sorted in numerical order, 
    # analogously to the arrangement of keys in a name tree as described in Section 3.8.4, “Name Trees.” 
    @nums : Array({String,Int64})

    def initialize(@type,@kids,@nums)
    end
    #An array of two integers, specifying the (numerically) least and greatest keys included in the Nums array of a leaf node 
    #or in the *Nums* arrays of any leaf nodes that are descendants of an intermediate node.
    def limits : Array(String)?
      return nil unless @names
      minkv,maxkv = names.minmax_by?{|k,v|k}
      return (minkv && maxkv) ? [kinkv[0],maxkv[0]] : nil
    end
    # for mixing-in module `Renderable`
    def render_to_pdf(io : IO) : IO
      case @type
      when Type::Root
        io << "<< /Kids " 
        PdfObj.raw_output(@kids.map{|obj| PdfRef.new(obj)},io) <<" >>"
      when Type::Intermediate
        io << "<< /Limits "
        PdfObj.raw_output(limits(),io)
        io << "/Kids "
        PdfObj.raw_output(@kids.map{|obj| PdfRef.new(obj)},io) <<" >>"
      when Type::Leaf
        io << "<< /Limits "
        PdfObj.raw_output(limits(),io)
        io << "/Nums "
        PdfObj.raw_output(@nums.sort_by!{|name,_|name}.map{|name_str,obj|{Name.new(name_str),PdfRef.new(obj.id)}},io)
      else
        raise "unrecognized name tree"
      end
      io
    end
    include Renderable
  end
end