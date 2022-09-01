module PDF
  class Document
    # Trailer的第一行只是Trailer关键字。之后是Trailer 字典，至少包含/Size 条目（给出条目数在交叉引用表中）和 /Root条目（它给出了对象编号）文档目录，它是正文中对象图的根元素。
    #
    # 接下来是一行只包含startxref关键字， 一行包含一个数字（文件中交叉引用表开头的字节偏移量）， 然后是行%%EOF，它表示PDF文件的结尾。
    #
    # 这是示例3-1中的Trailer：
    #```plaintext
    # trailer         文件尾关键字
    # << 文件尾字典
    # /Root 5 0 R
    # /Size 6
    # >>
    # startxref       startxref 文件尾关键字
    # 459 交叉引用表的字节偏移量
    # %%EOF 文件结束标记
    #```
    # 从文件末尾向后读取Trailer：找到文件结束标记， 提取交叉引用表的字节偏移量，然后解析Trailer字典。 Trailer关键字标记Trailer的上限。
    class Trailer
    end
  end
end