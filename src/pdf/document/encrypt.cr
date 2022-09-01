require "../obj"
module PDF
  class Document
    # A PDF document can be encrypted (PDF 1.1) to protect its contents from unauthorized access. 
    #
    # Encryption applies to all strings and streams in the document’s
    # PDF file, but not to other object types such as integers and boolean values, which
    # are used primarily to convey information about the document’s structure rather
    # than its content. Leaving these values unencrypted allows random access to the
    # objects within a document, while encrypting the strings and streams protects the
    # document’s substantive contents. 
    #
    # Note: When a PDF stream object (see Section 3.2.7, “Stream Objects”) refers to an
    # external file, the stream’s contents are not encrypted, since they are not part of the
    # PDF file itself. However, if the contents of the stream are embedded within the PDF
    # file (see Section 3.10.3, “Embedded File Streams”), they are encrypted like any other
    # stream in the file. 
    #
    # Encryption is controlled by an encryption dictionary, which is the value of the
    # Encrypt entry in the document’s trailer dictionary (see Table 3.11 on page 61). If
    # this entry is absent from the trailer dictionary, the document is not encrypted.
    # The entries shown in Table 3.12 are common to all encryption dictionaries.
    class Encrypt
      DEFAULT = 0
      # The name of the security handler for this document; see below. Default value:
      # **Standard**, for the built-in security handler. (Names for nonstandard security handlers
      # can be registered using the procedure described in Appendix E.)
      @filter : Name
      # A code specifying the algorithm to be used in encrypting and decrypting the
      # document: 
      #- 1 Algorithm 3.1 on page 66 
      #- 0 An alternate algorithm that is undocumented and no longer supported, and
      # whose use is strongly discouraged 
      # 
      # The default value if this entry is omitted is 0, but a value of 1 is strongly recommended.
      # Values greater than 1 are not defined for PDF 1.3, and documents specifying such values
      # cannot be opened by PDF 1.3 viewer applications.
      @v : Int32? 
      def initialize(@filter,@v = nil)
      end

      def to_h : Hash(String,Name)
      end
    end
  end
end