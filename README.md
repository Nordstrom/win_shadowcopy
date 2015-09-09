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

## Usage

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

## Recipes

### default

The default recipe ...

## Attributes

The attributes defined by this recipe are organized under the
`node['win_shadowcopy']` namespace.

Attribute | Description | Type   | Default
----------|-------------|--------|--------
...       | ...         | String | ...

## Development

The first time you check out this cookbook, run

    bundle --binstubs

to download and install the development tools.

## Testing

Three forms of cookbook testing are available:

### Style Checks

    bin/rake style

Will run foodcritic (cookbook style) and tailor (ruby style/syntax)
checks. These tests must pass before the cookbook can progress
through the CI pipeline.

### Unit Tests

    bin/rake spec

Will run ChefSpec tests.  It is a good idea to ensure that these
tests pass before committing changes to git.

#### Unit Test Coverage

    bin/rake coverage

Will run the ChefSpec tests and report on test coverage.  It is a
good idea to make sure that every Chef resource you declare is covered
by a unit test.

#### Automated Testing with Guard

    bin/guard

Will run foodcritic, tailor, rubocop (if enabled) and chefspec tests
automatically when the associated files change.  If a chefspec test
fails, it will drop you into a pry session in the context of the
failure to explore the state of the run.

To disable the pry-rescue behavior, define the environment variable
DISABLE_PRY_RESCUE before running guard:

    DISABLE_PRY_RESCUE=1 bin/guard

### Integration Tests

    bin/rake kitchen:all

Will run the test kitchen integration tests.  These tests use Vagrant
and Virtualbox, which must be installed for the tests to execute.

After converging in a virtual machine, ServerSpec tests are executed.
This skeleton comes with a very basic ServerSpec test; refer to
http://serverspec.org for detail on how to create tests.

## Author

Nordstrom, Inc.

## License

Copyright (c) 2015 Nordstrom, Inc., All Rights Reserved.
