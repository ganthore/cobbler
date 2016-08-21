# FlossWare Cobbler Kickstarts and Snippets

Welcome to the FlossWare [Cobbler](http://cobbler.github.io/) [kickstarts](http://cobbler.github.io/manuals/2.6.0/3/5_-_Kickstart_Templating.html) and [snippets](http://cobbler.github.io/manuals/2.6.0/3/6_-_Snippets.html) project!

## Concepts

### Kickstarts

All defined [kickstarts](http://cobbler.github.io/manuals/2.6.0/3/5_-_Kickstart_Templating.html) are simple wrappers that call a corresponding [snippet](http://cobbler.github.io/manuals/2.6.0/3/6_-_Snippets.html) of a similar name (without the ```.ks``` file extension):
* [flossware_centos_atomic.ks](https://github.com/FlossWare/cobbler/blob/master/kickstarts/flossware_centos_atomic.ks):  kickstarting template for CentOS Atomic.
* [flossware_fedora_atomic.ks](https://github.com/FlossWare/cobbler/blob/master/kickstarts/flossware_fedora_atomic.ks):  kickstarting template for Fedora Atomic.
* [flossware_rhel_atomic.ks](https://github.com/FlossWare/cobbler/blob/master/kickstarts/flossware_rhel_atomic.ks):  kickstarting template for RHEL Atomic.
* [flossware_standard.ks](https://github.com/FlossWare/cobbler/blob/master/kickstarts/flossware_standard.ks):  standard kickstarting template for "normal" bare metal or VMs.

*Please note:  there is some uniqueness when templating Atomic kickstarts.  For example, there is no package section and there is an ostreesetup option.  Also some of the atomic versions require different content from each other.*

### Snippets
