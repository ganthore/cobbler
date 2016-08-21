# FlossWare Cobbler Kickstarts and Snippets

Welcome to the FlossWare [Cobbler](http://cobbler.github.io/) [kickstarts](http://cobbler.github.io/manuals/2.6.0/3/5_-_Kickstart_Templating.html) and [snippets](http://cobbler.github.io/manuals/2.6.0/3/6_-_Snippets.html) project!

## Kickstarts

All defined [kickstarts](https://github.com/FlossWare/cobbler/tree/master/kickstarts) are simple wrappers that call a corresponding [snippets](https://github.com/FlossWare/cobbler/tree/master/snippets) of a similar name (without the ```.ks``` file extension):
* [flossware_centos_atomic.ks](https://github.com/FlossWare/cobbler/blob/master/kickstarts/flossware_centos_atomic.ks):  kickstarting template for CentOS Atomic.
* [flossware_fedora_atomic.ks](https://github.com/FlossWare/cobbler/blob/master/kickstarts/flossware_fedora_atomic.ks):  kickstarting template for Fedora Atomic.
* [flossware_rhel_atomic.ks](https://github.com/FlossWare/cobbler/blob/master/kickstarts/flossware_rhel_atomic.ks):  kickstarting template for RHEL Atomic.
* [flossware_standard.ks](https://github.com/FlossWare/cobbler/blob/master/kickstarts/flossware_standard.ks):  standard kickstarting template for "normal" bare metal or VMs.

*Please note:  there is some uniqueness when templating Atomic kickstarts.  For example, there is no package section and there is an ostreesetup option.  Also some of the Atomic versions require different content from each other.*

## Snippets

[Snippets](https://github.com/FlossWare/cobbler/tree/master/snippets) represent the bulk of all work.  We considered putting some templatization in the [kickstarts](https://github.com/FlossWare/cobbler/tree/master/kickstarts) but felt that keeping that functionality together made the most logical sense.  [Snippets](https://github.com/FlossWare/cobbler/tree/master/snippets) are broken up into the categories found below.

### Kickstart Counterparts

As mentioned above, all [kickstarts](https://github.com/FlossWare/cobbler/tree/master/kickstarts) call a corresponding [snippet](https://github.com/FlossWare/cobbler/tree/master/snippets).  The job of these snippets is to set variables (where appropriate) and coordinate assembly of the kickstart result as a whole.  There are, however, some that contain common functionality and reused (meaning they do not have a corresponding [kickstart](https://github.com/FlossWare/cobbler/tree/master/kickstarts) that calls them).

#### Common Kickstart Counterparts
* [common_kickstart](https://github.com/FlossWare/cobbler/blob/master/snippets/common_kickstart)
* [atomic_kickstart](https://github.com/FlossWare/cobbler/blob/master/snippets/atomic_kickstart)

#### Actual Kickstart Counterparts
* [centos_atomic_kickstart](https://github.com/FlossWare/cobbler/blob/master/snippets/centos_atomic_kickstart)
* [fedora_atomic_kickstart](https://github.com/FlossWare/cobbler/blob/master/snippets/fedora_atomic_kickstart)
* [rhel_atomic_kickstart](https://github.com/FlossWare/cobbler/blob/master/snippets/rhel_atomic_kickstart)
* [standard_kickstart](https://github.com/FlossWare/cobbler/blob/master/snippets/standard_kickstart)