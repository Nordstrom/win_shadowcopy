#
# Copyright (c) 2015 Nordstrom, Inc.
#

require 'spec_helper'

describe command("schtasks.exe /query | findstr #{schedule_taskname}") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^"#{schedule_taskname}"/) }
end
