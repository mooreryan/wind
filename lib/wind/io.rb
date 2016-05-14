# Copyright 2016 Ryan Moore
# Contact: moorer@udel.edu
#
# This file is part of Wind.
#
# Wind is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Wind is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
# License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Wind.  If not, see <http://www.gnu.org/licenses/>.

module Wind
  # Core extensions for Ruby IO
  module IO
    begin
      page_size = `getconf PAGESIZE`.chomp.to_i
    rescue Errno::ENOENT => e
      # no getconf
      page_size = 4096 # PAGESIZE on my macbook
    end

    # The buffer size is set to result of `getconf PAGESIZE` or 4096
    # if that fails.
    BUFFER_SIZE = page_size

    # A fast buffered version of IO#each_line.
    #
    # In my initial tests, it is between 2 and 3.5 times faster than
    # Ruby's IO#each_line.
    #
    # You can include Wind::IO in the File class and use this method
    # just like IO#each_line.
    #
    # @example
    #   File.include Wind::IO
    #   File.open(fname, "rt").each_line { |line| puts line }
    #
    # @return [ios or an_enumerator] Returns ios if a block is given,
    #   else, returns an enumerator
    #
    # @note Currently only tested on "regular" text files.
    #
    # @note The buffer size is set to the result of `getconf
    #   PAGESIZE`, or if that fails, it is set to 4096.
    def each_line
      return enum_for(:each_line) unless block_given?

      buf = ""
      prev_unfinished_line = ""

      while self.read(BUFFER_SIZE, buf)
        buf.scan(/^.*$\n?/).each do |str|
          if prev_unfinished_line.empty? && str[-1] == "\n"
            # str is a complete line, yield it
            yield str
          elsif prev_unfinished_line.empty?
            # str is the start of an unfinished line
            prev_unfinished_line = str
          elsif !prev_unfinished_line.empty? && str[-1] == "\n"
            # str is the conclusion of a prev_unfinished_line
            prev_unfinished_line << str

            # str is now finished, yield and reset
            yield prev_unfinished_line
            prev_unfinished_line = ""
          else
            # str is a continuation of a prev_unfinished_line
            prev_unfinished_line << str
          end
        end
      end
    end
  end
end
