# SPDX-FileCopyrightText: 2002-2022 Ole Tange, http://ole.tange.dk and Free Software and Foundation, Inc.
#
# SPDX-License-Identifier: GPL-3.0-or-later

SUBDIRS = src

test:
	cd testsuite; make 1

web:
	cd src; make web

upload:
	eval `gpg-agent --daemon`
# make sure $YYYYMMDD is set
	echo $(YYYYMMDD) | grep 20
	cp parallel-$(YYYYMMDD).tar.bz2 parallel-latest.tar.bz2
	cp doc/parallel.directive parallel-$(YYYYMMDD).tar.bz2.directive
	perl -i -pe "s/20\d\d\d\d\d\d/$(YYYYMMDD)/" parallel-*.tar.*directive
	gpg --clearsign --yes parallel-$(YYYYMMDD).tar.bz2.directive

	cp doc/parallel.latest.directive parallel-latest.tar.bz2.directive
	perl -i -pe "s/20\d\d\d\d\d\d/$(YYYYMMDD)/" parallel-latest.tar.*directive
	gpg --clearsign --yes parallel-latest.tar.bz2.directive

	(echo '#!/bin/bash'; \
	 echo; \
	 echo "# To check the signature run:"; \
	 echo "#   echo | gpg"; \
	 echo "#   gpg --auto-key-locate keyserver --keyserver-options auto-key-retrieve parallel-$(YYYYMMDD).tar.bz2.sig"; \
	 echo; \
	 echo "echo | gpg 2>/dev/null"; \
	 echo 'gpg --auto-key-locate keyserver --keyserver-options auto-key-retrieve $$0'; \
	 echo 'exit $$?' ; \
	 echo; \
	 gpg -ab -o - parallel-$(YYYYMMDD).tar.bz2; \
	) > parallel-$(YYYYMMDD).tar.bz2.sig

	(echo '#!/bin/bash'; \
	 echo; \
	 echo "# To check the signature run:"; \
	 echo "#   echo | gpg"; \
	 echo "#   gpg --auto-key-locate keyserver --keyserver-options auto-key-retrieve parallel-latest.tar.bz2.sig"; \
	 echo; \
	 echo "echo | gpg 2>/dev/null"; \
	 echo 'gpg --auto-key-locate keyserver --keyserver-options auto-key-retrieve $$0'; \
	 echo 'exit $$?' ; \
	 echo; \
	 gpg -ab -o - parallel-$(YYYYMMDD).tar.bz2; \
	) > parallel-latest.tar.bz2.sig

	gpg --auto-key-locate keyserver --keyserver-options auto-key-retrieve parallel-latest.tar.bz2.sig
	gpg --auto-key-locate keyserver --keyserver-options auto-key-retrieve parallel-$(YYYYMMDD).tar.bz2.sig

	../ftpsync/src/ftpsync parallel-$(YYYYMMDD).tar.bz2{,.sig,*asc} ftp://ftp-upload.gnu.org/incoming/ftp/
	../ftpsync/src/ftpsync parallel-latest.tar.bz2{,.sig,*asc} ftp://ftp-upload.gnu.org/incoming/ftp/

# This can take 7 minutes
	pushd /tmp; \
	rm -rf /tmp/parallel-$(YYYYMMDD)*; \
	while ! wget https://ftp.gnu.org/gnu/parallel/parallel-$(YYYYMMDD).tar.bz2 ; do sleep 2; done; \
	tar xjvf parallel-$(YYYYMMDD).tar.bz2; \
	cd parallel-$(YYYYMMDD); \
	./configure; \
	make -j && sudo make -j install; \
	pushd; \
	sudo cp /usr/local/bin/parallel /usr/local/bin/parallel-$(YYYYMMDD)

alphaupload:
# Copy of upload
	eval `gpg-agent --daemon`
# make sure $YYYYMMDD is set
	echo $(YYYYMMDD) | grep 20
	cp parallel-$(YYYYMMDD).tar.bz2 parallel-latest.tar.bz2
	cp doc/parallel.directive parallel-$(YYYYMMDD).tar.bz2.directive
	perl -i -pe "s/20\d\d\d\d\d\d/$(YYYYMMDD)/" parallel-*.tar.*directive
	gpg --clearsign --yes parallel-$(YYYYMMDD).tar.bz2.directive

	cp doc/parallel.latest.directive parallel-latest.tar.bz2.directive
	perl -i -pe "s/20\d\d\d\d\d\d/$(YYYYMMDD)/" parallel-latest.tar.*directive
	gpg --clearsign --yes parallel-latest.tar.bz2.directive

	(echo '#!/bin/bash'; \
	 echo; \
	 echo "# To check the signature run:"; \
	 echo "#  echo | gpg"; \
	 echo "#  gpg --auto-key-locate keyserver --keyserver-options auto-key-retrieve parallel-$(YYYYMMDD).tar.bz2.sig"; \
	 echo; \
	 echo "echo | gpg 2>/dev/null"; \
	 echo 'gpg --auto-key-locate keyserver --keyserver-options auto-key-retrieve $$0'; \
	 echo 'exit $$?' ; \
	 echo; \
	 gpg -ab -o - parallel-$(YYYYMMDD).tar.bz2; \
	) > parallel-$(YYYYMMDD).tar.bz2.sig

	(echo '#!/bin/bash'; \
	 echo; \
	 echo "# To check the signature run:"; \
	 echo "#  echo | gpg"; \
	 echo "#  gpg --auto-key-locate keyserver --keyserver-options auto-key-retrieve parallel-latest.tar.bz2.sig"; \
	 echo; \
	 echo "echo | gpg 2>/dev/null"; \
	 echo 'gpg --auto-key-locate keyserver --keyserver-options auto-key-retrieve $$0'; \
	 echo 'exit $$?' ; \
	 echo; \
	 gpg -ab -o - parallel-$(YYYYMMDD).tar.bz2; \
	) > parallel-latest.tar.bz2.sig

	gpg --auto-key-locate keyserver --keyserver-options auto-key-retrieve parallel-latest.tar.bz2.sig
	gpg --auto-key-locate keyserver --keyserver-options auto-key-retrieve parallel-$(YYYYMMDD).tar.bz2.sig

	../ftpsync/src/ftpsync parallel-$(YYYYMMDD).tar.bz2{,.sig,*asc} ftp://ftp-upload.gnu.org/incoming/alpha/

# This can take 7 minutes
	pushd /tmp; \
	rm -rf /tmp/parallel-$(YYYYMMDD)*; \
	while ! wget http://alpha.gnu.org/gnu/parallel/parallel-$(YYYYMMDD).tar.bz2 ; do sleep 2; done; \
	tar xjvf parallel-$(YYYYMMDD).tar.bz2; \
	cd parallel-$(YYYYMMDD); \
	./configure; \
	make -j && sudo make -j install; \
	pushd; \
	sudo cp /usr/local/bin/parallel /usr/local/bin/parallel-$(YYYYMMDD)

monitorman:
# If man page changed: open new pdfman
	inotifywait -qmre MOVED_TO -e CLOSE_WRITE --format %w%f . | parallel -uj1 'echo {=/\.pod$$/ or skip()=};make -j && sudo make install; pdfman {/.} &'

reuse:
	rm -rf /tmp/reuse
	mkdir /tmp/reuse
	git commit -a -m dummy
	(wd=`pwd`; \
	cd /tmp/reuse; \
	git clone "$$wd"; \
	cd parallel; \
	reuse lint || \
	(echo Use; \
	echo '  reuse addheader --copyright="Ole Tange, http://ole.tange.dk and Free Software and Foundation, Inc." --license="GPL-3.0-or-later" source-files'; \
	echo or; \
	echo '  reuse addheader --copyright="Ole Tange, http://ole.tange.dk and Free Software and Foundation, Inc." --license="GPL-3.0-or-later" --explicit-license bin-files' \
	) )
	git reset HEAD~ >/dev/null
	git commit -c ORIG_HEAD >/dev/null

testurls:
	mkdir -p urls
	cd urls && ../src/testurls

reconf:
	rm -fr autom4te.cache aclocal.m4 config.h config.h.in config.log Makefile.in missing install-sh
	rm -rf src/Makefile.in
	autoreconf --install -W gnu
	./configure
	make -j
	sudo make install

pack_unpack_and_test_build:
	echo '### Building tar.bz2'
	./configure
	make dist
	make dist-bzip2
	echo "### Unpack parallel-$(YYYYMMDD).tar.bz2"
	cp parallel-$(YYYYMMDD).tar.bz2 /tmp
	cd /tmp && \
	tar xjf parallel-$(YYYYMMDD).tar.bz2 && \
	cd parallel-$(YYYYMMDD) && \
	./configure && make -j && sudo make -j install

# This ought to be correct, but fails on Centos
# bashcompletiondir=$(DESTDIR)${datarootdir}/bash-completion/completions
# zshcompletiondir=$(DESTDIR)${datarootdir}/zsh/site-functions
bashcompletiondir=$(DESTDIR)${prefix}/share/bash-completion/completions
zshcompletiondir=$(DESTDIR)${prefix}/share/zsh/site-functions
bashcompletion=${bashcompletiondir}/parallel
zshcompletion=${zshcompletiondir}/_parallel
install-data-hook:
	mkdir -p ${zshcompletiondir} ${bashcompletiondir}
	$(DESTDIR)$(bindir)/parallel --shell-completion bash > ${bashcompletion}
# Make zsh eval the --shell-completion code dynamically so if
# a newer version of GNU Parallel is installed by a normal
# user, this newer version will generate the
# --shell-completion code.
	echo '#compdef parallel' > ${zshcompletion}
	echo '(( $$+functions[_comp_parallel] )) ||' >> ${zshcompletion}
	echo '  eval "$$(parallel --shell-completion auto)" &&' >> ${zshcompletion}
	echo '  _comp_parallel' >> ${zshcompletion}

uninstall-hook:
	rm -rf ${zshcompletiondir} ${bashcompletiondir}

EXTRA_DIST = CITATION CITATION.cff CREDITS LICENSES/CC-BY-SA-4.0.txt LICENSES/GFDL-1.3-or-later.txt LICENSES/GPL-3.0-or-later.txt
