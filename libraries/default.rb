module Windows
  # helpers for the win_shadowcopy LWRP
  module Shadowcopy
    def config_exists?(*)
      setting = new_resource.name
      Chef::Log.info "Checking for existence of dynamic DNS option: #{setting}"
      @exists ||= begin
        cmd = shell_out!('')
        cmd.stderr.empty? && cmd.stdout.include?(setting)
      end
    end

    def enable_shadowcopy
      Chef::Log.info "Configuring Shadowcopy on volume: #{drivepath}"
      drivepath = new_resource.shadowcopy_drivepath + ':'
      storagepath = new_resource.shadowcopy_storagepath + ':'
      maxsize = new_resource.shadowcopy_maxsize
      time = new_resource.schedule_time
      taskname = new_resource.schedule_taskname
      taskcmd = "schtasks.exe /create /tn #{taskname} /ru SYSTEM /tr"
      taskrun = "vssadmin.exe Add ShadowStorage /For=#{drivepath} /On=#{storagepath} /MaxSize=#{maxsize}GB"
      taskopt = "/sc hourly /mo 8 /st #{time} /rl HIGHEST"
      cmd = shell_out!(taskcmd + taskrun + taskopt)
      cmd.stderr.empty? && cmd.stdout.include?('Successfully created shadow copy')
    end

    def schedule_shadowcopy
      schedule_drivepath = new_resource.schedule_drivepath
      Chef::Log.info "Checking for existence of dynamic DNS option: #{setting}"
      cmd = shell_out!('')
      cmd.stderr.empty? && cmd.stdout.include?(setting)
    end
  end
end
