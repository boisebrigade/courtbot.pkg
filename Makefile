rpm: rpm.lint rpm.spec rpm.build

rpm.lint:
	rpmlint courtbot.spec

rpm.spec:
	spectool -g -R courtbot.spec

rpm.build: rpm.spec
	rpmbuild -ba courtbot.spec

test:
	sudo vagrant destroy -f \
	sudo vagrant up
