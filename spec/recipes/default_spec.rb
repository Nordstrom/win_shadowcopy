RSpec.describe 'testsetup::default' do
  include ChefRun

  it 'enables the default shadowcopy' do
    expect(chef_run).to enable_win_shadowcopy('default')
  end

  it 'schedules the default shadowcopy' do
    expect(chef_run).to schedule_win_shadowcopy('default')
  end
end
