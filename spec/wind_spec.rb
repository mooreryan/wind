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

require 'spec_helper'

describe Wind do
  it 'has a version number' do
    expect(Wind::VERSION).not_to be nil
  end

  let(:fname) { File.join Dir.pwd, "tmp.txt" }

  describe IO do
    it 'has a non negative BUFFER SIZE' do
      expect(Wind::IO::BUFFER_SIZE).to be > 0
    end

    describe "#each_line" do
      after(:each) do
        FileUtils.rm fname
      end

      it "yields the same lines as std Ruby each_line" do
        write_random_file fname

        lines = []
        File.open(fname, "rt").each_line { |l| lines << l }

        expect{|b| SFile.open(fname, "rt").each_line(&b)}.
          to yield_successive_args *lines
      end

      it "returns an enumerator when no block is given" do
        write_random_file fname

        lines = []
        enum = File.open(fname, "rt").each_line

        expect(SFile.open(fname, "rt").each_line.to_a).to eq enum.to_a
      end
    end
  end
end
