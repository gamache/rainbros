module Rainbros
  module ::IRB
    class << self
      alias :old_setup :setup

      def setup(ap_path)
        STDOUT.sync = true
        old_setup(ap_path)
        prompt = "8===D~~ "
        opts = {
                :spread => 3.0,
                :freq => 0.8,
                :os => rand(256),
                :speed => 1.0
        }
        output = ::Lol.cat([prompt], opts)
        default = @CONF[:PROMPT][:DEFAULT]
        @CONF[:PROMPT][:RAINBROS] = {
                :PROMPT_I => "#{default[:PROMPT_I][0..-3]}#{output}",
                :PROMPT_N => "#{default[:PROMPT_N][0..-3]}#{output}",
                :PROMPT_S => "#{default[:PROMPT_S][0..-2]}#{output}",
                :PROMPT_C => "#{default[:PROMPT_C][0..-2]}#{output}",
                :RETURN => "#{output}#{default[:RETURN][3..-1]}"
        }
        @CONF[:PROMPT_MODE] = :RAINBROS
        @CONF[:AUTO_INDENT] = true
        # disable readline because it causes a wrapping bug.
        # http://www.ruby-forum.com/topic/213807
        @CONF[:USE_READLINE] = false
      end
    end
  end
end