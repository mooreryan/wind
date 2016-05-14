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

require "coveralls"
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "wind"
require "fileutils"

class SFile < File
  include Wind::IO
end

def random_size_line
  "a" * rand(0..10_000)
end

def write_random_file fname
  File.open(fname, "w") do |f|
    rand(10..20).times do
      f.puts random_size_line
    end
  end
end
