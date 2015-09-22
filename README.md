# win_shadowcopy

## Description

This is a resource cookbook that hosts a LWRP that supports configuration of
Windows shadowcopy with the following (string) attributes:
* drivepath
* MaxSize
* shadowcopy_storagepath
And these (string) actions:
* enable
* schedule

This LWRP leverages Microsoft DSC script to perform tasks, and may not work
properly with older versions of Windows.  Your mileage may vary.

## Warning

This LWRP cookbook requires DSC bits necessary to manage VSS to be installed
prior to using the win_shadowcopy LWRP.  Please refer to DSC documentation for
directions.

## Example Usage

win_shadowcopy 'default' do
  action :enable
  shadowcopy_drivepath 'C:'
  shadowcopy_maxsize '1024MB'
  shadowcopy_storagepath 'C:'
end

win_shadowcopy 'default' do
  action :schedule
  schedule_ensure 'Present'
  schedule_drivepath 'C:'
  schedule_time '5:00PM'
  schedule_taskname 'C_drive_VSS'
end

## Author

Sandeep Bhat and Dave Viebrock, Nordstrom, Inc.

## License

Copyright (c) 2015 Nordstrom, Inc., All Rights Reserved.
