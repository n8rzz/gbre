# Gbre

Gbre stands for _Git Branch Enhanced_ and is an extremely opinionated layer added on top of the `git branch` command.

## Installation

```bash
gem install gbre
```

## Usage

In order to use this gem, the following conditions must be met:

- git branches are named `TOPIC/ISSUE_NUMBER` (ex: `feature/123`)
- you are working within the hardcoded project ([Openscope](http://github.com/openscope/openscope))
- you can run ruby

From the repository root run:

```bash
gbre
```

This gem will transform the usual `git branch` output from:

```bash
* develop
  feature/123
  feature/124
  feature/126
  master
  release/0.1.0
```

into a list with a little more information:

```bash
+-----------+----------------------+-----------------------------+
|                      GIT Branch Enhanced                       |
+-----------+----------------------+-----------------------------+
|  State    |  Branch Name         |  Issue Title                |
+-----------+----------------------+-----------------------------+
|           |  develop             |                             |
|  (open)   |  feature/123         |  a placeholder issue title  |
|  (open)   |  feature/124         |  a placeholder issue title  |
|  (closed) |  feature/126         |  a placeholder issue title  |
|           |  master              |                             |
|           |  release/0.1.0       |  a placeholder issue title  |
+-----------+----------------------+-----------------------------+
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/n8rzz/gbre.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
