require 'rainbow'

# typed: true
module Parlour
  # Contains methods to enable debugging facilities for Parlour.
  module Debugging
    extend T::Sig

    @debug_mode = true # TODO: temporary

    sig { params(value: T::Boolean).returns(T::Boolean) }
    def self.debug_mode=(value)
      @debug_mode = value
    end

    sig { returns(T::Boolean) }
    def self.debug_mode?
      @debug_mode
    end

    sig { params(object: T.untyped, message: String).void }
    def self.debug_puts(object, message)
      return unless debug_mode?
      name = Rainbow("#{name_for_debug_caller(object)}: ").magenta.bright.bold
      prefix = Rainbow("Parlour debug: ").blue.bright.bold
      puts prefix + name + message
    end

    sig { params(object: T.untyped).returns(String) }
    def self.name_for_debug_caller(object)
      case object
      when ConflictResolver
        "conflict resolver"
      when RbiGenerator
        "RBI generator"
      when Plugin
        "plugin #{object.class.name}"
      else
        object.class.name
      end
    end
  end
end