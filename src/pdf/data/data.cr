# As mentioned at the beginning of this chapter, there are some general-purpose
# data structures that are built from the basic object types described in Section 3.2,
# “Objects,” and are used in many places throughout PDF. This section describes
# data structures for text strings, dates, rectangles, name trees, and number trees.
# The subsequent two sections describe more complex data structures for functions and file specifications.
# All of these data structures are meaningful only as part of the document hierarchy; they cannot appear within content streams. In particular, the special conventions for interpreting the values of string objects apply only to strings outside
# content streams. An entirely different convention is used within content streams
# for using strings to select sequences of glyphs to be painted on the page (see
# Chapter 5). Table 3.21 summarizes the basic and higher-level data types that are
# used throughout this book to describe the values of dictionary entries and other
# PDF data values.
module PDF::Data
end