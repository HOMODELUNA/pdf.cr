# frozen_string_literal: true

# Welcome to Prawn, the best PDF Generation library ever.
# This documentation covers user level functionality.
#
require 'set'

#require 'ttfunk'
#require 'pdf/core'

module PDF
  # file = __FILE__
  # file = File.readlink(file) if File.symlink?(file)
  # dir = File.dirname(file)

  # # The base source directory for Prawn as installed on the system
  # #
  # #
  # BASEDIR = File.expand_path(File.join(dir, '..'))
  # DATADIR = File.expand_path(File.join(dir, '..', 'data'))

  FLOAT_PRECISION = 1.0e-9

  # When set to true, Prawn will verify hash options to ensure only valid keys
  # are used.  Off by default.
  #
  # Example:
  #   >> Prawn::Document.new(:tomato => "Juicy")
  #   Prawn::Errors::UnknownOption:
  #   Detected unknown option(s): [:tomato]
  #   Accepted options are: [:page_size, :page_layout, :left_margin, ...]
  #
  # @private

end

require './pdf/version'

require './pdf/errors'

require './pdf/utilities'
require './pdf/text'
require './pdf/graphics'
require './pdf/images'
require './pdf/images/image'
require './pdf/images/jpg'
require './pdf/images/png'
require './pdf/stamp'
require './pdf/soft_mask'
require './pdf/security'
require './pdf/transformation_stack'
require './pdf/document'
require './pdf/font'
require './pdf/measurements'
require './pdf/repeater'
require './pdf/outline'
require './pdf/grid'
require './pdf/view'
require './pdf/image_handler'

Prawn.image_handler.register(Prawn::Images::PNG)
Prawn.image_handler.register(Prawn::Images::JPG)
