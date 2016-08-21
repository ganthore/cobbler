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

As mentioned above, all [kickstarts](https://github.com/FlossWare/cobbler/tree/master/kickstarts) call a corresponding [snippet](https://github.com/FlossWare/cobbler/tree/master/snippets).  The job of these snippets is to set variables (where appropriate) and coordinate assembly of the [kickstart](http://cobbler.github.io/manuals/2.6.0/3/5_-_Kickstart_Templating.html) result as a whole.  The names correspond to the type of distro you are installing:
* [centos_atomic_kickstart](https://github.com/FlossWare/cobbler/blob/master/snippets/centos_atomic_kickstart)
* [fedora_atomic_kickstart](https://github.com/FlossWare/cobbler/blob/master/snippets/fedora_atomic_kickstart)
* [rhel_atomic_kickstart](https://github.com/FlossWare/cobbler/blob/master/snippets/rhel_atomic_kickstart)
* [standard_kickstart](https://github.com/FlossWare/cobbler/blob/master/snippets/standard_kickstart)

### Options

The [options snippets](https://github.com/FlossWare/cobbler/tree/master/snippets/options) represent an [option](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Installation_Guide/sect-kickstart-syntax.html#sect-kickstart-commands) that one may find in a kickstart file - for example [autopart](https://github.com/FlossWare/cobbler/blob/master/snippets/options/autopart) for automatically creating partitions.

Should an option afford parameters, simply denoting the name of the option in your ```ksmeta``` as the name with the value being what should end up in the resultant [kickstart](http://cobbler.github.io/manuals/2.6.0/3/5_-_Kickstart_Templating.html).  As an example, let's assume you wsh to set the language to ```en_US``` in your kickstart:

```bash
ksmeta='lang="en_US"'
```

This will expand in the kickstart to:

```bash
lang="en_US"
```
### Modules

[Modules snippets](https://github.com/FlossWare/cobbler/tree/master/snippets/modules) represent logically related snippets contained in a file:
* [atomic](https://github.com/FlossWare/cobbler/blob/master/snippets/modules/atomic): adds the ```ostreesetup``` option and disables some services.
* [common](https://github.com/FlossWare/cobbler/blob/master/snippets/modules/common): layout "common" kickstarting options, like ```text```, ```skipx```, etc.
* [defined_disk_partition](https://github.com/FlossWare/cobbler/blob/master/snippets/modules/defined_disk_partition): if not using ```autopart```, will layout a "good enough" disk structure.  If you denote ```lvmDisks``` as a ```ksmeta``` variable whose values are the disks to use, it will layout [LVM partitioning](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Logical_Volume_Manager_Administration/LVM_GUI.html) for you.  As an example:   ```ksmeta=lvmDisks="sda,sdb,sdc"```
* [disk_partition](https://github.com/FlossWare/cobbler/blob/master/snippets/modules/disk_partition): "common" disk partitioning snippets.  If [autopart](https://github.com/FlossWare/cobbler/blob/master/snippets/options/autopart) is a ```ksmeta``` variable, it will use that [option](https://github.com/FlossWare/cobbler/tree/master/snippets/options) otherwise it will use use the [defined_disk_partition snippet](https://github.com/FlossWare/cobbler/blob/master/snippets/modules/defined_disk_partition].  
* [filesystem](https://github.com/FlossWare/cobbler/blob/master/snippets/modules/filesystem): "common" file system snippet for [zerombr](https://github.com/FlossWare/cobbler/blob/master/snippets/options/zerombr), [ignoredisk](https://github.com/FlossWare/cobbler/blob/master/snippets/options/ignoredisk) and [bootloader](https://github.com/FlossWare/cobbler/blob/master/snippets/options/bootloader) options as well as calling the [disk_partition snippet](https://github.com/FlossWare/cobbler/blob/master/snippets/modules/disk_partition).

### Sections

[Sections snippets](https://github.com/FlossWare/cobbler/tree/master/snippets/sections) correspond to sections in kickstarts like [package](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Installation_Guide/sect-kickstart-syntax.html#sect-kickstart-packages), [pre](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Installation_Guide/sect-kickstart-syntax.html#sect-kickstart-preinstall), [post](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Installation_Guide/sect-kickstart-syntax.html#sect-kickstart-postinstall) and [add ons](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Installation_Guide/sect-kickstart-syntax.html#sect-kickstart-addon).

* 