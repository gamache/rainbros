# unused for now
module Rainbros
  module ::Kernel
    def capture_stdout
      out = StringIO.new
      $stdout = out
      yield
      return out
    ensure
      $stdout = STDOUT
    end
  end
end