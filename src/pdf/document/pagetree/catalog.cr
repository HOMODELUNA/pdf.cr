require "../../obj"
require "./abstract_pagetree"
require "../../data"
module PDF
  
  # The root of a document’s object hierarchy is the catalog dictionary, located via the
  # **Root** entry in the trailer of the PDF file (see Section 3.4.4, “File Trailer”). 
  # The catalog contains references to other objects defining the document’s contents, outline, 
  # article threads (PDF 1.1), named destinations, and other attributes. 
  #
  # In addition, it contains information about how the document should be displayed
  # on the screen, such as whether its outline and thumbnail page images should be
  # displayed automatically and whether some location other than the first page
  # should be shown when the document is opened.
  class Catalog < PageTree

    #The type of PDF object that this dictionary describes; 
    #must be Catalog for the catalog dictionary. 
    TYPE = Name.new("Catalog")
    def type
      TYPE
    end
    #The page tree node that is the root of the document’s page tree (see Section 3.6.2, “Page Tree”). 
    @pages : Hash(Name,PageTreeNode)
    # A number tree (see Section 3.8.5, “Number Trees”)
    # defining the page labeling for the document. The keys in this tree are
    # page indices; the corresponding values are page label dictionaries (see
    # Section 7.3.1, “Page Labels”). Each page index denotes the first page to
    # which the specified page label dictionary applies. The tree must include
    # a value for page index 0. 
    @page_lables : NumberTree?
    # Names dictionary (Optional; PDF 1.2) The document’s name dictionary (see Section 3.6.3,“Name Dictionary”). 
    @names =0
    # Dests dictionary  (Optional; PDF 1.1; must be an indirect reference) 
    # A dictionary of names and corresponding destinations (see “Named Destinations” on page 387). 
    @dests =0
    # ViewerPreferences dictionary (Optional; PDF 1.2) A viewer preferences dictionary (see Section 7.1,
    # “Viewer Preferences”) specifying the way the document is to be displayed on the screen. If this entry is absent, viewer applications should
    # use their own current user preference settings. 
    @viewer_preferences =0

    # A name object specifying the page layout to be used when the document is opened: 
    enum PageLayout
      #Display one page at a time. 
      SinglePage 
      #Display the pages in one column. 
      OneColumn 
      #Display the pages in two columns, with oddnumbered pages on the left. 
      TwoColumnLeft 
      #Display the pages in two columns, with oddnumbered pages on the right. 
      TwoColumnRight 
      #Default value: SinglePage.     
      def self.default
        SinglePage
      end
      def to_name() : Name
        Name.sym_cases( self,SinglePage,OneColumn,TwoColumnLeft, TwoColumnRight)
      end
    end
    
    @page_layout : Name?
    # Outlines dictionary (Optional; must be an indirect reference) The outline dictionary that is
    # the root of the document’s outline hierarchy (see Section 7.2.2, “Document Outline”). 
    # Threads array (Optional; PDF 1.1; must be an indirect reference) 
    # An array of thread dictionaries representing the document’s article threads (see Section 7.3.2,“Articles”). 
    enum PageMode
      #Neither document outline nor thumbnail images visible 
      UseNone 
      #Document outline visible 
      UseOutLines
      #Thumbnail images visible 
      UseThumbs 
      #Full-screen mode, with no menu bar, window controls, or any other window visible 
      FullScreen
      #Default value: UseNone.     
      def self.default
        UseNone
      end
      def to_name() : Name
        case self
        in UseNone then Names.new("UseNone")
        in UseOutLines then Names.new("UseOutLines")
        in UseThumbs then Names.new("UseThumbs")
        in FullScreen then Names.new("FullScreen")
        end
      end
    end
    @page_mode : PageMode = PageMode.default
    # A value specifying a destination to be displayed 
    # or dictionary an action to be performed when the document is opened. 
    # The value is an array defining a destination (see Section 7.2.1, “Destinations”)
    # or an action dictionary representing an action (Section 7.5, “Actions”).
    # If this entry is absent, the document should be opened to the top of the
    # first page at the default magnification factor. 
    @open_action : Array(Int32) | Hash(String ,String) | Nil
    #A dictionary containing document-level information for uniform resource identifier (URI) actions 
    #(see “URI Actions” on page 428). 
    @uri : Hash(String,String)?
    #The document’s interactive form (AcroForm) dictionary (see Section 7.6.1, “Interactive Form Dictionary”). 
    @acroform : Hash(String,String)?
    #The document’s structure tree root dictionary (see “Structure Hierarchy” on page 486). 
    @struct_tree_root : Hash(String,String)?
    #A dictionary containing state information used by the Acrobat Web Capture (AcroSpider) plug-in extension 
    # (see Section 8.5.1, “Web Capture Information Dictionary”).
    @spiderinfo : Hash(String,String)?

    def initialize(@pages)
    end
  end
end