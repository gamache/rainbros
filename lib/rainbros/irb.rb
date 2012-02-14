module Rainbros
  module ::IRB
    class << self
      attr_reader :rainbro

      alias :old_setup :setup

      def setup(ap_path)
        old_setup(ap_path)
        prompt = "8==D~~"
        opts = {
                :spread => 3.0,
                :freq => 0.8,
                :os => rand(256),
                :speed => 1.0
        }
        output = capture_stdout {::Lol.cat([prompt], opts)}.string.chomp

        @rainbro = "#{output} "

        #output = output.gsub(/(#{27.chr}\[\d+;\d+;\d+m)(.{1})(#{27.chr}\[0m)/, '\001\1\002\2\001\3\002')

        #default = @CONF[:PROMPT][:DEFAULT]
        #@CONF[:PROMPT][:RAINBROS] = {
        #        :PROMPT_I => "#{default[:PROMPT_I][0..-3]}#{output}",
        #        :PROMPT_N => "#{default[:PROMPT_N][0..-3]}#{output}",
        #        :PROMPT_S => "#{default[:PROMPT_S][0..-2]}#{output}",
        #        :PROMPT_C => "#{default[:PROMPT_C][0..-2]}#{output}",
        #        :RETURN => "#{output}#{default[:RETURN][3..-1]}"
        #}
        #@CONF[:PROMPT_MODE] = :RAINBROS
        #@CONF[:AUTO_INDENT] = true
        #puts @CONF[:PROMPT][:RAINBROS]
      end
    end

    class StdioInputMethod < InputMethod
      def gets
        print @prompt
        print IRB.rainbro
        line = @stdin.gets
        @line[@line_no += 1] = line
      end
    end

    class FileInputMethod < InputMethod
      def gets
        print @prompt
        print IRB.rainbro
        l = @io.gets
        l
      end
    end

    class ReadlineInputMethod < InputMethod
      def gets
        Readline.input = @stdin
        Readline.output = @stdout
        if l = readline(IRB.rainbro, false)
          HISTORY.push(l) if !l.empty?
          @line[@line_no += 1] = l + "\n"
        else
          @eof = true
          l
        end
      end
    end
  end
end