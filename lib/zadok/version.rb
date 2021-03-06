# frozen_string_literal: true

module Zadok
  VERSION_MAJOR = 0
  VERSION_MINOR = 10
  VERSION_TINY = 8
  VERSION_PRE = nil

  VERSION = [
    VERSION_MAJOR,
    VERSION_MINOR,
    VERSION_TINY,
    VERSION_PRE
  ].compact.join(".")
end
