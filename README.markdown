# Bastet - The unstable beast

Goddess associated with war, protection of Lower Egypt and the pharaoh, the sun, perfumes, ointments and embalming

## Configuration

    redis = Redis.new
    $bastet = Bastet::Base.new(redis)


## Usage

    $bastet.activate(:crazy_feature, current_user)
    $bastet.active?(:crazy_feature, current_user) #=> true

    $bastet.activate(:scary_feature, :admins)
    $bastet.active?(:scary_feature, :admins) #=> false

## Contibuting

[![Build Status](https://secure.travis-ci.org/itsmeduncan/bastet.png)](http://travis-ci.org/itsmeduncan/bastet)

1. Fork Basteet
2. Create a topic branch - `git checkout -b my_branch`
3. Push to your branch - `git push origin my_branch`
4. Create a pull request from your branch
