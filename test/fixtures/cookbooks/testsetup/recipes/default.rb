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
  schedule_taskname 'C_drive_shadowcopy'
end
