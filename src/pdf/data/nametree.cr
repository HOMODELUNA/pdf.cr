module PDF::Data
  # A name tree serves a similar purpose to a dictionary—associating keys and
  # values—but by different means. A name tree differs from a dictionary in the following important ways: 
  #- Unlike the keys in a dictionary, which are name objects, those in a name tree
  # are strings. 
  #- The keys are ordered. 
  #- The values associated with the keys may be objects of any type, but they must
  # always be specified via indirect object references. 
  #
  #- The data structure can represent an arbitrarily large collection of key-value
  # pairs, which can be looked up efficiently without requiring the entire data
  # structure to be read from the PDF file. (In contrast, a dictionary is subject to an
  # implementation limit on the number of entries it can contain.) 
  #
  # A name tree is constructed of *nodes*, each of which is a dictionary object.
  # Table 3.22 shows the entries in a node dictionary. The nodes are of three kinds,
  # depending on the specific entries they contain. The tree always has exactly one
  # root node, which contains a single entry: either **Kids** or **Names** but not both. If the
  # root node has a **Names** entry, it is the only node in the tree. If it has a **Kids** entry,
  # then each of the remaining nodes is either an intermediate node, containing a
  # Limits entry and a **Kids** entry, or a leaf node, containing a Limits entry and a
  # **Names** entry.
  class NameTree
    
    enum Type
      Root
      Intermediate
      Leaf
    end
    @type : Type

    # (Root and intermediate nodes only; required in intermediate nodes; present in the root node
    # if and only if Names is not present) An array of indirect references to the immediate children of this node. 
    # The children may be intermediate or leaf nodes. 
    @kids : Array(NameTree)?
    #Names array (Root and leaf nodes only; required in leaf nodes; present in the root node if and only if Kids
    # is not present) An array of the form 
    # `[key1 value1 key2 value2 … keyn valuen]`
    #
    #  where each keyi
    #- is a string and the corresponding valuei
    #- is an indirect reference to the object associated with that key. The keys are sorted in lexical order, as described below. 
    @names : Array({String,PdfObj})?
    # Limits array (Intermediate and leaf nodes only; required) An array of two strings, 
    # specifying the (lexically) least and greatest keys included in the Names array of a leaf node or in the Names
    # arrays of any leaf nodes that are descendants of an intermediate node.
    def limits : Array(String)?
      return nil unless @names
      minkv,maxkv = names.minmax_by?{|k,v|k}
      return (minkv && maxkv) ? [kinkv[0],maxkv[0]] : nil
    end

    def initialize(@type,@kids,@names)
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
        io << "/Names "
        PdfObj.raw_output(@names.sort_by!{|name,_|name}.map{|name_str,obj|{Name.new(name_str),PdfRef.new(obj.id)}},io)
      else
        raise "unrecognized name tree"
      end
      io
    end
    include Renderable
  end
end