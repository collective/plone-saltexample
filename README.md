# Salty Plone Example

This set of Salt states will configure a running Plone instance behind a Varnish cache.

It includes a sample `Vagrantfile` so you can test the states locally and currently it is targeted to Ubuntu systems. The states are ready for cross-platform deployment with a little attention to the other environments.

To try out the setup, just follow these instructions:

```sh
$ vagrant up
```

After quite some time, you should be able to navigate to <http://localhost:6081> and view a fresh Plone 5 install.
