module Windows
  # helpers for the win_shadowcopy LWRP
  module Shadowcopy
    def enable_shadowcopy
      shadowcopy_drivepath = new_resource.shadowcopy_drivepath
      shadowcopy_storagepath = new_resource.shadowcopy_storagepath
      shadowcopy_maxsize = new_resource.shadowcopy_maxsize
      dsc_script 'enable_shadowcopy' do
        code <<-EOH
        cVSSSetShadowCopy{
            Drive = '#{shadowcopy_drivepath}'
            Enable = $True
            StorageLocation = '#{shadowcopy_storagepath}'
            MaxSize = '#{shadowcopy_maxsize}'
         }
         EOH
      end
    end

    def schedule_shadowcopy
      schedule_drivepath = new_resource.schedule_drivepath
      schedule_time = new_resource.schedule_time
      schedule_ensure = new_resource.schedule_ensure
      schedule_taskname = new_resource.schedule_taskname
      dsc_script 'schedule_shadowcopy' do
        code <<-EOH
          cVSSTaskScheduler ScheduleCopy{
              TaskName = '#{schedule_taskname}'
              Ensure =  '#{schedule_ensure}'
              Drive = '#{schedule_drivepath}'
              TriggerTime = '#{schedule_time}'
          }
         EOH
      end
    end
  end
end
