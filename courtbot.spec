Name:       courtbot
Version:    0.2.0
Release:    beta2
Summary:    Courtbot is a simple web service for subscribing to case hearing details via SMS.

URL:        https://github.com/boisebrigade/courtbot
Source0:    https://github.com/boisebrigade/courtbot.pkg/archive/master.tar.gz#/%{name}-%{version}-%{release}.tar.gz

License:    ISC

%{?el7:Requires: docker}

%{?fedora:Requires: (docker or docker-ce)}

%description
Courtbot is a simple web service for subscribing to case hearing details via SMS.

%prep
%autosetup -n %{name}.pkg-master

%install
mkdir -p %{buildroot}/usr/bin/
install -m 755 src/courtbot.sh %{buildroot}/usr/bin/courtbot

mkdir -p %{buildroot}/etc/courtbot
install -m 644 src/courtbot.exs %{buildroot}/etc/courtbot/courtbot.exs

mkdir -p %{buildroot}/etc/systemd/system/
install -m 644 src/courtbot.service %{buildroot}/etc/systemd/system/courtbot.service

%clean
rm -rf %{buildroot}

%files
/usr/bin/courtbot
%config(noreplace) /etc/courtbot/courtbot.exs
/etc/systemd/system/courtbot.service

%post
systemctl enable courtbot

%changelog
* Tue Jan 1 2019 Tyler Samples <tyler@boisebrigade.org>
- Packaging for RPM
