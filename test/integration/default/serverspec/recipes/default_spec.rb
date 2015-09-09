#
# Copyright (c) 2015 Nordstrom, Inc.
#

require 'spec_helper'

describe command('$volume = ((gwmi win32_volume | ?{$_.DriveLetter -eq 'E:'} | select *).DeviceID).split('\')[3]; gwmi win32_shadowstorage | ?{$_.volume -match $volume}') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match(/^E:/) }
end
