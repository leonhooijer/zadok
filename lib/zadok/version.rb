# frozen_string_literal: true

module Zadok
  VERSION_MAJOR = 0
  VERSION_MINOR = 8
  VERSION_TINY = 12
  VERSION_PRE = nil

  VERSION = [
    VERSION_MAJOR,
    VERSION_MINOR,
    VERSION_TINY,
    VERSION_PRE
  ].compact.join(".")
end
