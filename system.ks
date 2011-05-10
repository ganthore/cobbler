#platform=x86, AMD64, or Intel EM64T
# System authorization information
auth  --useshadow  --enablemd5  --enablenis --nisdomain=flossware.com
# System bootloader configuration
bootloader --location=mbr
# Clear the Master Boot Record
zerombr
# Partition clearing information
clearpart --all --initlabel
# Use text mode install
text
# Firewall configuration
firewall --disabled
# Run the Setup Agent on first boot
firstboot --disable
# interactive install
#interactive
# System keyboard
keyboard us
# System language
lang en_US
# Installation logging level
logging --level=debug
# Use network installation
url --url=$tree
# If any cobbler repo definitions were referenced in the kickstart profile, include them here.
$yum_repo_stanza
# Network information
network --hostname=$hostname --bootproto=dhcp --device=eth0
# Reboot after installation
reboot
# Root password
rootpw --iscrypted $1$YF9VN0yn$jhieNwdEA/KLtjPa.wW/p0

# SELinux configuration
selinux --disabled
# Do not configure the X Window System
skipx
# System timezone
timezone  America/New_York
# Install OS instead of upgrade
install
# Disk partitioning information

#if $getVar('$manualDiskLayout','') == ''
	#set $partitionedDisks = $getVar('$prePartitionedDisks', '')
	#if $partitionedDisks != ''
		clearpart --none --drives=$partitionedDisks
	#end if

	#if $getVar('$prePartitions', '') != ''
		#set $allPartitions = $partitions.split( ',' )
		#for $aPartition in $allPartitions
			part None --onpart=$aPartition --noformat
		#end for
	#end if

	#if $getVar('$disks', '') != ''
		# #set $clearParts = $getVar('$clearParts', '')
		# #if $clearParts != ''
			# clearpart --all --drives=$clearParts
		# #end if
			clearpart --all --drives=$disks

		#set $allDisks = $disks.split( ',' )

        #set $bootPartitionSize = $getVar('$bootPartitionSize', '200')
		part /boot --fstype="ext3" --size=$bootPartitionSize --ondisk=$allDisks[0]

		#set $pv = 1
		#set allPv = ''

		#for $aDisk in $allDisks
			part pv.$pv --size=1024 --grow --ondisk=$aDisk
			#set $allPv = $allPv + ' pv.' + str($pv)
			#set $pv += 1
		#end for
		volgroup VolGroup00 --pesize=32768 $allPv
		logvol swap --fstype="swap" --name=LogVol01 --vgname=VolGroup00 --recommended
		logvol / --fstype="ext3" --name=LogVol00 --vgname=VolGroup00 --size=1024 --grow
	#else
		part swap --fstype="swap" --recommended
		part / --fstype="ext3" --grow --size=1024
		part /boot --fstype ext3 --size 200 --recommended
	#end if
#end if

%pre
$kickstart_start

%packages
@core
#set $packages = $getVar('$packages', '')
#set $allPackages = $packages.split(',')
#for $aPackage in $allPackages
$aPackage
#end for

%post
grep HOSTNAME /etc/sysconfig/network
if [ $? == 0 ]
then
    sed -i -e "s/\(HOSTNAME=\).*/\1$hostname/" /etc/sysconfig/network
else
    echo "HOSTNAME=$hostname" >> /etc/sysconfig/network
fi

grep NISDOMAIN /etc/sysconfig/network
if [ $? == 0 ]
then
    sed -i -e "s/\(NISDOMAIN=\).*/\1flossware.com/" /etc/sysconfig/network
else
    echo "NISDOMAIN=flossware.com" >> /etc/sysconfig/network
fi

grep DHCP_HOSTNAME /etc/sysconfig/network-scripts/ifcfg-eth0
if [ $? == 0 ] 
then
    sed -i -e "s/\(DHCP_HOSTNAME=\).*/\1$hostname/" /etc/sysconfig/network-scripts/ifcfg-eth0
else
    echo "DHCP_HOSTNAME=$hostname" >> /etc/sysconfig/network-scripts/ifcfg-eth0
fi

sed -i -e "s/\(^hosts:\).*/\1      files dns/" /etc/nsswitch.conf

#if $getVar('$isGraphical', '') != ''  
sed -i -e "s/\(^id:\).*/\15:initdefault:/" /etc/inittab
#end if

#if $getVar('$enableInitScripts','') == ''
for aScript in /etc/init.d/*
do
        /sbin/chkconfig `basename $aScript` off
done
#end if

#  $yum_config_stanza

/sbin/chkconfig --add network
/sbin/chkconfig network on

/sbin/chkconfig --add sshd
/sbin/chkconfig sshd on

/sbin/chkconfig --add puppet
/sbin/chkconfig puppet on

ln -s /home/root/ssh /root/.ssh

/bin/dbus-uuidgen > /var/lib/dbus/machine-id

$kickstart_done
%end
