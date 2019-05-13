#
# spec file for package drbd-formula
#
# Copyright (c) 2019 SUSE LINUX GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via https://bugs.opensuse.org/
#


# See also http://en.opensuse.org/openSUSE:Specfile_guidelines
%define fname drbd
Name:           drbd-formula
Version:        0.1.0
Release:        0
Summary:        DRBD deployment salt formula
License:        Apache-2.0
Group:          System/Packages
URL:            https://github.com/nick-wang/%{name}
Source0:        %{name}-%{version}.tar.gz
Requires:       drbd-utils
Requires:       salt-shaptools
BuildArch:      noarch
BuildRoot:      %{_tmppath}/%{name}-%{version}-build

%description
DRBD deployment salt formula

%prep
%setup -q

%build

%install
mkdir -p %{buildroot}/srv/salt/
cp -R %{fname} %{buildroot}/srv/salt

%files
%defattr(-,root,root,-)
%license LICENSE
%doc README.md
/srv/salt/%{fname}
%dir %attr(0755, root, salt) /srv/salt

%changelog
