if defined?(ChefSpec)
  def enable_win_shadowcopy(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:win_shadowcopy, :enable, resource_name)
  end

  def schedule_win_shadowcopy(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:win_shadowcopy, :schedule, resource_name)
  end
end
