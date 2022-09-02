require "../../obj"
module PDF
  # The pages of a document are accessed through a structure known as the page tree,
  # which defines their ordering within the document. The tree structure allows PDF
  # viewer applications to quickly open a document containing thousands of pages
  # using only limited memory. The tree contains nodes of two types—intermediate
  # nodes, called page tree nodes, and leaf nodes, called page objects—whose form is
  # described in the sections below. Viewer applications should be prepared to handle any form of tree structure built of such nodes. The simplest structure would
  # consist of a single page tree node that references all of the document’s page objects directly; however, to optimize the performance of viewer applications, the
  # Acrobat Distiller and PDF Writer programs construct trees of a particular form,
  # known as balanced trees. Further information on this form of tree can be found in
  # Data Structures and Algorithms, by Aho, Hopcroft, and Ullman (see the Bibliography).
  #
  # for example, this is a pagetree with its child pages
  #```plaintext
  #   2 0 obj
  # << /Type /Pages
  # /Kids [ 4 0 R
  # 10 0 R
  # 24 0 R
  # ]
  # /Count 3
  # >>
  # endobj
  # 4 0 obj
  # << /Type /Page
  # … Additional entries describing the attributes of this page …
  # >>
  # endobj
  # Document Structure 3.6
  # 77
  # 10 0 obj
  # << /Type /Page
  # … Additional entries describing the attributes of this page …
  # >>
  # endobj
  # 24 0 obj
  # << /Type /Page
  # … Additional entries describing the attributes of this page …
  # >>
  # endobj
  #```
  class PageTreeNode
    #The type of PDF object that this dictionary describes; must be Pages for a page tree node. 
    TYPE = Name.new("Pages")
    #:ditto:
    def type 
      TYPE
    end
    #(Required except in root node; must be an indirect reference) 
    #The page tree node that is the immediate parent of this one. 
    @parent : PdfRef?
    #An array of indirect references to the immediate children of this node.
    #The children may be page objects or other page tree nodes. 
    @kids : Array(PageTreeNode)
    #The number of leaf nodes (page objects) that are descendants of this node within the page tree.
    def count
      @kids.size()
    end
    def initialize(@parent,@kids)
    end
  end
end
    