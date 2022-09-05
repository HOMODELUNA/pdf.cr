require "../obj/renderable"
module PDF
  class Document
    # PDF文件的第一行给出文档的版本号。在我们的示例中，是：
    #```plaintext
    # %PDF-1.0
    #```
    # 这将文件定义为PDF版本1.0。PDF是向后兼容的，因此PDF 1.3文档 应该由知道例如PDF 1.5的程序读取。它在很大程度上也是向前兼容的， 因此大多数PDF程序都会尝试读取任何文件，无论假设的版本号是什么。
    #
    # 由于PDF文件几乎总是包含二进制数据，因此如果更改行结尾 （例如，如果文件通过FTP以文本模式传输），它们可能会损坏。 为了允许传统文件传输程序确定文件是二进制文件， 通常在标头中包含一些字符代码高于127的字节。例如：
    #```plaintext
    # %âãÏÓ
    #```
    # 百分号表示另一个标题行，其他几个字节是超过127的任意字符代码。 因此，我们示例中的整个header是：
    #```plaintext
    # %PDF-1.0
    # %âãÏÓ
    #```
    class Header
      #把一些不可打印的字符添加到PDF标题中 - 这可确保文件被识别为二进制 （而不是文本），例如，通过FTP等文件传输程序。
      MAGIC = "%âãÏÓ"
      @version ="1.3"

      def render_to_pdf(io : IO) : IO
        io << "%PDF-" << @version << "\n%âãÏÓ\n"
      end
      include Renderable
    end
  end
end