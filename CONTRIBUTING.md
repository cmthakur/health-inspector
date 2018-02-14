Contribution Guidelines
=======================

How To Contribute
-----------------

* Follow the steps described in [Development Setup](#development-setup)
* Create a topic branch: `git checkout -b awesome_feature`
* Commit your changes
* Keep up to date: `git fetch && git rebase origin/master`

Once you’re ready:

* Fork the project on GitHub
* Add your repository as a remote: `git remote add your_remote your_repo`
* Push up your branch: `git push your_remote awesome_feature`
* Create a Pull Request for the topic branch, asking for review.

If you’re looking for things to hack on, please check
[GitHub Issues](https://github.com/cmthakur/health-inspector/issues).

Acceptance
----------

**Contributions WILL NOT be accepted without tests.**

If you haven't tested before, start reading up in the `spec/` directory to see
what's going on. If you've got good links regarding TDD or testing in general
feel free to add them here!

Branching
---------

For your own development, use the topic branches. Basically, cut each
feature into its own branch and send pull requests based off those.

The master branch is the main production branch. **Always** should be
fast-forwardable.

Development Setup
-----------------

  - Checkout out the repo
  - Run `bin/setup` to install dependencies
  - Run `rake spec` to run the tests
  - Run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
