version=8
(cd ../ && git add * && git commit -m test)
./makesrpm.sh --output /root/rpmbuild/SRPMS --version 5.3.${version} --rename xrootd-ceph-buffered
cd /root/rpmbuild/SRPMS
rpm2cpio xrootd-ceph-buffered-5.3.${version}-1.el7.src.rpm | cpio -imdv --no-absolute-filenames
sudo cp xrootd-ceph-buffered.tar.gz ../SOURCES
sed -i "s/5.3.$((version-1))/5.3.${version}/g" /root/rpmbuild/SPECS/xrootd-ceph-buffered.spec
rpmbuild -ba /root/rpmbuild/SPECS/xrootd-ceph-buffered.spec
yum remove -y xrootd-ceph-buffered-5.3.${version}-1.el7.x86_64
yum install -y /root/rpmbuild/RPMS/x86_64/xrootd-ceph-buffered-5.3.${version}-1.el7.x86_64.rpm
systemctl restart xrootd@ceph
