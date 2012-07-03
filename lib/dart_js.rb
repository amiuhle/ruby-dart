module DartJs

  class << self

    attr_writer :dartjs

    def dartjs
      @dartjs ||= ENV['DARTJS_SOURCE_PATH']
    end

    def compile file_or_data, options
      file_given = file_or_data.respond_to?(:path)

      in_file = file_given ? file_or_data : Tempfile.new(['template', '.dart'], options[:tmp_path])
      
      out_file = Tempfile.new ['template', '.js'], options[:tmp_path]
      begin
        unless file_given
          in_file.write data
          in_file.flush
        end

        in_path, out_path = in_file.path, out_file.path
        
        cmd = %Q{#{dartjs} -o"#{out_path}" "#{in_path}"}
        puts cmd
        if system cmd
          out_file.read
        end
      ensure
        unless file_given
          in_file.close
          in_file.unlink
        end
        
        out_file.close
        out_file.unlink
      end
    end

  end

end