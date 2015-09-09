if defined?(ChefSpec)
  def set_win_shadowcopy(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:win_shadowcopy, :set, resource_name)
  end
end
