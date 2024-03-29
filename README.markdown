# Bastet - The criteria based feature rollout beast [![Build Status](https://secure.travis-ci.org/itsmeduncan/bastet.png)](http://travis-ci.org/itsmeduncan/bastet)

## Gemfile

    gem "bastet"

## Configuration

    redis = Redis.new
    bastet = Bastet.setup(redis) #=> Bastet::Base.instance ...

## Usage

### Activate

    group = Bastet::Group.new('admin_users') { |user| user.admin? }
    bastet.activate("admin_only_feature", group)

### Test

    user = User.new(admin: true)
    bastet.active?("admin_only_feature", user) #=> true


### Deactivate

    bastet.deactivate("admin_only_feature", group)
    bastet.inactive?("admin_only_feature", user) #=> true

### Criteria

    Bastet::Group.new('all') { true } # true for everyone
    Bastet::Group.new('none') { false } # false for everyone
    Bastet::Group.new('admins') { |user| user.admin? } # True for entities that respond to #admin? with true
    Bastet::Group.new('10_percent') { |user| (entity.id % 10) < (20 / 10) } # True for 20% of entities based on the id

## To Do

1. Support activating/deactivating for multiple users/groups at once
2. Percentage support
3. Logging

## Contibuting

1. Fork Basteet
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create a pull request from your branch
