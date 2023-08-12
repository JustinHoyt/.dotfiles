# SPDX-FileCopyrightText: 2002-2023 Ole Tange, http://ole.tange.dk and Free Software and Foundation, Inc.
#
# SPDX-License-Identifier: GPL-3.0-or-later

bin_SCRIPTS = parallel sql niceload parcat parset parsort	\
	env_parallel env_parallel.ash env_parallel.bash		\
	env_parallel.csh env_parallel.dash env_parallel.fish	\
	env_parallel.ksh env_parallel.mksh env_parallel.pdksh	\
	env_parallel.sh env_parallel.tcsh env_parallel.zsh

POD_FILES = parcat.pod parset.pod sem.pod parallel.pod			\
	env_parallel.pod niceload.pod parallel_examples.pod		\
	parallel_tutorial.pod parallel_book.pod parallel_design.pod	\
	parallel_alternatives.pod

MAN_FILES = parallel.1 env_parallel.1 sem.1 sql.1 niceload.1		\
	parallel_examples.7 parallel_tutorial.7 parallel_book.7		\
	parallel_design.7 parallel_alternatives.7 parcat.1 parset.1	\
	parsort.1

PDF_MAN = parallel.pdf env_parallel.pdf sem.pdf sql.pdf		\
	niceload.pdf parallel_examples.pdf parallel_tutorial.pdf	\
	parallel_book.pdf parallel_design.pdf				\
	parallel_alternatives.pdf parcat.pdf parset.pdf parsort.pdf

PDF_OTHER = parallel_cheat_bw.pdf parallel_options_map.pdf

PDF_FILES = $(PDF_MAN) $(PDF_OTHER)

RST_FILES = parallel.rst env_parallel.rst sem.rst sql.rst		\
	niceload.rst parallel_examples.rst parallel_tutorial.rst	\
	parallel_book.rst parallel_design.rst				\
	parallel_alternatives.rst parcat.rst parset.rst parsort.rst

TEXI_FILES = parallel.texi env_parallel.texi sem.texi sql.texi		\
	niceload.texi parallel_examples.texi parallel_tutorial.texi	\
	parallel_book.texi parallel_design.texi				\
	parallel_alternatives.texi parcat.texi parset.texi		\
	parsort.texi

HTML_FILES = parallel.html env_parallel.html sem.html sql.html		\
	niceload.html parallel_examples.html parallel_tutorial.html	\
	parallel_book.html parallel_design.html				\
	parallel_alternatives.html parcat.html parset.html		\
	parsort.html

install-exec-hook:
	rm "$(DESTDIR)$(bindir)"/sem || true
	$(LN_S) parallel "$(DESTDIR)$(bindir)"/sem

if DOCUMENTATION
man_MANS = $(MAN_FILES)
doc_DATA = $(HTML_FILES) $(TEXI_FILES) $(RST_FILES) $(PDF_FILES)
endif

DISTCLEANFILES = $(MAN_FILES) $(HTML_FILES) $(TEXI_FILES)	\
	$(RST_FILES) $(PDF_FILES)


EXTRA_DIST = $(bin_SCRIPTS) sem $(POD_FILES) \
	parallel_cheat_bw.fodt pod2graph $(DISTCLEANFILES)

web: sphinx
	true

sphinx: *.rst
	cd sphinx && make && cd ..

# Build documentation file if the tool to build exists.
# Otherwise: Use the distributed version
parallel.1: parallel.pod
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=1 "$(srcdir)"/parallel.pod > "$(srcdir)"/parallel.1n \
	&& mv "$(srcdir)"/parallel.1n "$(srcdir)"/parallel.1 \
	|| echo "Warning: pod2man not found. Using old parallel.1"

env_parallel.1: env_parallel.pod
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=1 "$(srcdir)"/env_parallel.pod > "$(srcdir)"/env_parallel.1n \
	&& mv "$(srcdir)"/env_parallel.1n "$(srcdir)"/env_parallel.1 \
	|| echo "Warning: pod2man not found. Using old env_parallel.1"

parallel_examples.7: parallel_examples.pod
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=7 "$(srcdir)"/parallel_examples.pod > "$(srcdir)"/parallel_examples.7n \
	&& mv "$(srcdir)"/parallel_examples.7n "$(srcdir)"/parallel_examples.7 \
	|| echo "Warning: pod2man not found. Using old parallel_examples.7"

parallel_tutorial.7: parallel_tutorial.pod
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=7 "$(srcdir)"/parallel_tutorial.pod > "$(srcdir)"/parallel_tutorial.7n \
	&& mv "$(srcdir)"/parallel_tutorial.7n "$(srcdir)"/parallel_tutorial.7 \
	|| echo "Warning: pod2man not found. Using old parallel_tutorial.7"

parallel_book.7: parallel_book.pod
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=7 "$(srcdir)"/parallel_book.pod > "$(srcdir)"/parallel_book.7n \
	&& mv "$(srcdir)"/parallel_book.7n "$(srcdir)"/parallel_book.7 \
	|| echo "Warning: pod2man not found. Using old parallel_book.7"

parallel_design.7: parallel_design.pod
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=7 "$(srcdir)"/parallel_design.pod > "$(srcdir)"/parallel_design.7n \
	&& mv "$(srcdir)"/parallel_design.7n "$(srcdir)"/parallel_design.7 \
	|| echo "Warning: pod2man not found. Using old parallel_design.7"

parallel_alternatives.7: parallel_alternatives.pod
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=7 "$(srcdir)"/parallel_alternatives.pod > "$(srcdir)"/parallel_alternatives.7n \
	&& mv "$(srcdir)"/parallel_alternatives.7n "$(srcdir)"/parallel_alternatives.7 \
	|| echo "Warning: pod2man not found. Using old parallel_alternatives.7"

sem.1: sem.pod
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=1 "$(srcdir)"/sem.pod > "$(srcdir)"/sem.1n \
	&& mv "$(srcdir)"/sem.1n "$(srcdir)"/sem.1 \
	|| echo "Warning: pod2man not found. Using old sem.1"

sql.1: sql
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=1 "$(srcdir)"/sql > "$(srcdir)"/sql.1n \
	&& mv "$(srcdir)"/sql.1n "$(srcdir)"/sql.1 \
	|| echo "Warning: pod2man not found. Using old sql.1"

niceload.1: niceload.pod
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=1 "$(srcdir)"/niceload.pod > "$(srcdir)"/niceload.1n \
	&& mv "$(srcdir)"/niceload.1n "$(srcdir)"/niceload.1 \
	|| echo "Warning: pod2man not found. Using old niceload.1"

parcat.1: parcat.pod
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=1 "$(srcdir)"/parcat.pod > "$(srcdir)"/parcat.1n \
	&& mv "$(srcdir)"/parcat.1n "$(srcdir)"/parcat.1 \
	|| echo "Warning: pod2man not found. Using old parcat.1"

parset.1: parset.pod
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=1 "$(srcdir)"/parset.pod > "$(srcdir)"/parset.1n \
	&& mv "$(srcdir)"/parset.1n "$(srcdir)"/parset.1 \
	|| echo "Warning: pod2man not found. Using old parset.1"

parsort.1: parsort
	pod2man --release='$(PACKAGE_VERSION)' --center='$(PACKAGE_NAME)' \
		--section=1 "$(srcdir)"/parsort > "$(srcdir)"/parsort.1n \
	&& mv "$(srcdir)"/parsort.1n "$(srcdir)"/parsort.1 \
	|| echo "Warning: pod2man not found. Using old parsort.1"

parallel.html: parallel.pod
	pod2html --title "GNU Parallel" "$(srcdir)"/parallel.pod > "$(srcdir)"/parallel.htmln \
	&& mv "$(srcdir)"/parallel.htmln "$(srcdir)"/parallel.html \
	|| echo "Warning: pod2html not found. Using old parallel.html"
	rm -f "$(srcdir)"/pod2htm*

# Depending on parallel.html to avoid stupid pod2html race condition
env_parallel.html: env_parallel.pod parallel.html
	pod2html --title "GNU Parallel with environment" "$(srcdir)"/env_parallel.pod > "$(srcdir)"/env_parallel.htmln \
	&& mv "$(srcdir)"/env_parallel.htmln "$(srcdir)"/env_parallel.html \
	|| echo "Warning: pod2html not found. Using old env_parallel.html"
	rm -f "$(srcdir)"/pod2htm*

# Depending on env_parallel.html to avoid stupid pod2html race condition
parallel_examples.html: parallel_examples.pod env_parallel.html
	pod2html --title "GNU Parallel examples" "$(srcdir)"/parallel_examples.pod > "$(srcdir)"/parallel_examples.htmln \
	&& mv "$(srcdir)"/parallel_examples.htmln "$(srcdir)"/parallel_examples.html \
	|| echo "Warning: pod2html not found. Using old parallel_examples.html"
	rm -f "$(srcdir)"/pod2htm*

# Depending on parallel_examples.html to avoid stupid pod2html race condition
parallel_tutorial.html: parallel_tutorial.pod parallel_examples.html
	pod2html --title "GNU Parallel tutorial" "$(srcdir)"/parallel_tutorial.pod > "$(srcdir)"/parallel_tutorial.htmln \
	&& mv "$(srcdir)"/parallel_tutorial.htmln "$(srcdir)"/parallel_tutorial.html \
	|| echo "Warning: pod2html not found. Using old parallel_tutorial.html"
	rm -f "$(srcdir)"/pod2htm*

# Depending on parallel_tutorial.html to avoid stupid pod2html race condition
parallel_book.html: parallel_book.pod parallel_tutorial.html
	pod2html --title "GNU Parallel book" "$(srcdir)"/parallel_book.pod > "$(srcdir)"/parallel_book.htmln \
	&& mv "$(srcdir)"/parallel_book.htmln "$(srcdir)"/parallel_book.html \
	|| echo "Warning: pod2html not found. Using old parallel_book.html"
	rm -f "$(srcdir)"/pod2htm*

# Depending on parallel_book.html to avoid stupid pod2html race condition
parallel_design.html: parallel_design.pod parallel_book.html
	pod2html --title "GNU Parallel design" "$(srcdir)"/parallel_design.pod > "$(srcdir)"/parallel_design.htmln \
	&& mv "$(srcdir)"/parallel_design.htmln "$(srcdir)"/parallel_design.html \
	|| echo "Warning: pod2html not found. Using old parallel_design.html"
	rm -f "$(srcdir)"/pod2htm*

# Depending on parallel_design.html to avoid stupid pod2html race condition
parallel_alternatives.html: parallel_alternatives.pod parallel_design.html
	pod2html --title "GNU Parallel alternatives" "$(srcdir)"/parallel_alternatives.pod > "$(srcdir)"/parallel_alternatives.htmln \
	&& mv "$(srcdir)"/parallel_alternatives.htmln "$(srcdir)"/parallel_alternatives.html \
	|| echo "Warning: pod2html not found. Using old parallel_alternatives.html"
	rm -f "$(srcdir)"/pod2htm*

# Depending on parallel_alternatives.html to avoid stupid pod2html race condition
sem.html: sem.pod parallel_alternatives.html
	pod2html --title "sem (GNU Parallel)" "$(srcdir)"/sem.pod > "$(srcdir)"/sem.htmln \
	&& mv "$(srcdir)"/sem.htmln "$(srcdir)"/sem.html \
	|| echo "Warning: pod2html not found. Using old sem.html"
	rm -f "$(srcdir)"/pod2htm*

# Depending on sem.html to avoid stupid pod2html race condition
sql.html: sql sem.html
	pod2html --title "GNU SQL" "$(srcdir)"/sql > "$(srcdir)"/sql.htmln \
	&& mv "$(srcdir)"/sql.htmln "$(srcdir)"/sql.html \
	|| echo "Warning: pod2html not found. Using old sql.html"
	rm -f "$(srcdir)"/pod2htm*

# Depending on sql.html to avoid stupid pod2html race condition
niceload.html: niceload.pod sql.html
	pod2html --title "GNU niceload" "$(srcdir)"/niceload.pod > "$(srcdir)"/niceload.htmln \
	&& mv "$(srcdir)"/niceload.htmln "$(srcdir)"/niceload.html \
	|| echo "Warning: pod2html not found. Using old niceload.html"
	rm -f "$(srcdir)"/pod2htm*

# Depending on niceload.html to avoid stupid pod2html race condition
parcat.html: parcat.pod niceload.html
	pod2html --title "GNU parcat" "$(srcdir)"/parcat.pod > "$(srcdir)"/parcat.htmln \
	&& mv "$(srcdir)"/parcat.htmln "$(srcdir)"/parcat.html \
	|| echo "Warning: pod2html not found. Using old parcat.html"
	rm -f "$(srcdir)"/pod2htm*

# Depending on parcat.html to avoid stupid pod2html race condition
parset.html: parset.pod parcat.html
	pod2html --title "GNU parset" "$(srcdir)"/parset.pod > "$(srcdir)"/parset.htmln \
	&& mv "$(srcdir)"/parset.htmln "$(srcdir)"/parset.html \
	|| echo "Warning: pod2html not found. Using old parset.html"
	rm -f "$(srcdir)"/pod2htm*

# Depending on parset.html to avoid stupid pod2html race condition
parsort.html: parsort parset.html
	pod2html --title "GNU parsort" "$(srcdir)"/parsort > "$(srcdir)"/parsort.htmln \
	&& mv "$(srcdir)"/parsort.htmln "$(srcdir)"/parsort.html \
	|| echo "Warning: pod2html not found. Using old parsort.html"
	rm -f "$(srcdir)"/pod2htm*

parallel.texi: parallel.pod
	pod2texi --output="$(srcdir)"/parallel.texi "$(srcdir)"/parallel.pod \
	|| echo "Warning: pod2texi not found. Using old parallel.texi"

env_parallel.texi: env_parallel.pod
	pod2texi --output="$(srcdir)"/env_parallel.texi "$(srcdir)"/env_parallel.pod \
	|| echo "Warning: pod2texi not found. Using old env_parallel.texi"

parallel_examples.texi: parallel_examples.pod
	pod2texi --output="$(srcdir)"/parallel_examples.texi "$(srcdir)"/parallel_examples.pod \
	|| echo "Warning: pod2texi not found. Using old parallel_examples.texi"

parallel_tutorial.texi: parallel_tutorial.pod
	pod2texi --output="$(srcdir)"/parallel_tutorial.texi "$(srcdir)"/parallel_tutorial.pod \
	|| echo "Warning: pod2texi not found. Using old parallel_tutorial.texi"

parallel_book.texi: parallel_book.pod
	pod2texi --output="$(srcdir)"/parallel_book.texi "$(srcdir)"/parallel_book.pod \
	|| echo "Warning: pod2texi not found. Using old parallel_book.texi"

parallel_design.texi: parallel_design.pod
	pod2texi --output="$(srcdir)"/parallel_design.texi "$(srcdir)"/parallel_design.pod \
	|| echo "Warning: pod2texi not found. Using old parallel_design.texi"

parallel_alternatives.texi: parallel_alternatives.pod
	pod2texi --output="$(srcdir)"/parallel_alternatives.texi "$(srcdir)"/parallel_alternatives.pod \
	|| echo "Warning: pod2texi not found. Using old parallel_alternatives.texi"

sem.texi: sem.pod
	pod2texi --output="$(srcdir)"/sem.texi "$(srcdir)"/sem.pod \
	|| echo "Warning: pod2texi not found. Using old sem.texi"

sql.texi: sql
	pod2texi --output="$(srcdir)"/sql.texi "$(srcdir)"/sql \
	|| echo "Warning: pod2texi not found. Using old sql.texi"

niceload.texi: niceload.pod
	pod2texi --output="$(srcdir)"/niceload.texi "$(srcdir)"/niceload.pod \
	|| echo "Warning: pod2texi not found. Using old niceload.texi"

parcat.texi: parcat.pod
	pod2texi --output="$(srcdir)"/parcat.texi "$(srcdir)"/parcat.pod \
	|| echo "Warning: pod2texi not found. Using old parcat.texi"

parset.texi: parset.pod
	pod2texi --output="$(srcdir)"/parset.texi "$(srcdir)"/parset.pod \
	|| echo "Warning: pod2texi not found. Using old parset.texi"

parsort.texi: parsort
	pod2texi --output="$(srcdir)"/parsort.texi "$(srcdir)"/parsort \
	|| echo "Warning: pod2texi not found. Using old parsort.texi"

parallel.rst: parallel.pod
	./pod2rst-fix < "$(srcdir)"/parallel.pod > "$(srcdir)"/parallel.rst \
	|| echo "Warning: pod2rst not found. Using old parallel.rst"

env_parallel.rst: env_parallel.pod
	./pod2rst-fix < "$(srcdir)"/env_parallel.pod > "$(srcdir)"/env_parallel.rst \
	|| echo "Warning: pod2rst not found. Using old env_parallel.rst"

parallel_examples.rst: parallel_examples.pod
	./pod2rst-fix < "$(srcdir)"/parallel_examples.pod > "$(srcdir)"/parallel_examples.rst \
	|| echo "Warning: pod2rst not found. Using old parallel_examples.rst"

parallel_tutorial.rst: parallel_tutorial.pod
	./pod2rst-fix < "$(srcdir)"/parallel_tutorial.pod > "$(srcdir)"/parallel_tutorial.rst \
	|| echo "Warning: pod2rst not found. Using old parallel_tutorial.rst"

parallel_book.rst: parallel_book.pod
	./pod2rst-fix < "$(srcdir)"/parallel_book.pod > "$(srcdir)"/parallel_book.rst \
	|| echo "Warning: pod2rst not found. Using old parallel_book.rst"

parallel_design.rst: parallel_design.pod
	./pod2rst-fix < "$(srcdir)"/parallel_design.pod > "$(srcdir)"/parallel_design.rst \
	|| echo "Warning: pod2rst not found. Using old parallel_design.rst"

parallel_alternatives.rst: parallel_alternatives.pod
	./pod2rst-fix < "$(srcdir)"/parallel_alternatives.pod > "$(srcdir)"/parallel_alternatives.rst \
	|| echo "Warning: pod2rst not found. Using old parallel_alternatives.rst"

sem.rst: sem.pod
	./pod2rst-fix < "$(srcdir)"/sem.pod > "$(srcdir)"/sem.rst \
	|| echo "Warning: pod2rst not found. Using old sem.rst"

sql.rst: sql
	./pod2rst-fix < "$(srcdir)"/sql > "$(srcdir)"/sql.rst \
	|| echo "Warning: pod2rst not found. Using old sql.rst"

niceload.rst: niceload.pod
	./pod2rst-fix < "$(srcdir)"/niceload.pod > "$(srcdir)"/niceload.rst \
	|| echo "Warning: pod2rst not found. Using old niceload.rst"

parcat.rst: parcat.pod
	./pod2rst-fix < "$(srcdir)"/parcat.pod > "$(srcdir)"/parcat.rst \
	|| echo "Warning: pod2rst not found. Using old parcat.rst"

parset.rst: parset.pod
	./pod2rst-fix < "$(srcdir)"/parset.pod > "$(srcdir)"/parset.rst \
	|| echo "Warning: pod2rst not found. Using old parset.rst"

parsort.rst: parsort
	./pod2rst-fix < "$(srcdir)"/parsort > "$(srcdir)"/parsort.rst \
	|| echo "Warning: pod2rst not found. Using old parsort.rst"

parallel.pdf: parallel.pod
	pod2pdf --output-file "$(srcdir)"/parallel.pdf "$(srcdir)"/parallel.pod --title "GNU Parallel" \
	|| echo "Warning: pod2pdf not found. Using old parallel.pdf"

env_parallel.pdf: env_parallel.pod
	pod2pdf --output-file "$(srcdir)"/env_parallel.pdf "$(srcdir)"/env_parallel.pod --title "GNU Parallel with environment" \
	|| echo "Warning: pod2pdf not found. Using old env_parallel.pdf"

parallel_examples.pdf: parallel_examples.pod
	pod2pdf --output-file "$(srcdir)"/parallel_examples.pdf "$(srcdir)"/parallel_examples.pod --title "GNU Parallel Examples" \
	|| echo "Warning: pod2pdf not found. Using old parallel_examples.pdf"

parallel_tutorial.pdf: parallel_tutorial.pod
	pod2pdf --output-file "$(srcdir)"/parallel_tutorial.pdf "$(srcdir)"/parallel_tutorial.pod --title "GNU Parallel Tutorial" \
	|| echo "Warning: pod2pdf not found. Using old parallel_tutorial.pdf"

parallel_book.pdf: parallel_book.pod
	pod2pdf --output-file "$(srcdir)"/parallel_book.pdf "$(srcdir)"/parallel_book.pod --title "GNU Parallel Book" \
	|| echo "Warning: pod2pdf not found. Using old parallel_book.pdf"

parallel_design.pdf: parallel_design.pod
	pod2pdf --output-file "$(srcdir)"/parallel_design.pdf "$(srcdir)"/parallel_design.pod --title "GNU Parallel Design" \
	|| echo "Warning: pod2pdf not found. Using old parallel_design.pdf"

parallel_alternatives.pdf: parallel_alternatives.pod
	pod2pdf --output-file "$(srcdir)"/parallel_alternatives.pdf "$(srcdir)"/parallel_alternatives.pod --title "GNU Parallel alternatives" \
	|| echo "Warning: pod2pdf not found. Using old parallel_alternatives.pdf"

sem.pdf: sem.pod
	pod2pdf --output-file "$(srcdir)"/sem.pdf "$(srcdir)"/sem.pod --title "GNU sem" \
	|| echo "Warning: pod2pdf not found. Using old sem.pdf"

sql.pdf: sql
	pod2pdf --output-file "$(srcdir)"/sql.pdf "$(srcdir)"/sql --title "GNU SQL" \
	|| echo "Warning: pod2pdf not found. Using old sql.pdf"

niceload.pdf: niceload.pod
	pod2pdf --output-file "$(srcdir)"/niceload.pdf "$(srcdir)"/niceload.pod --title "GNU niceload" \
	|| echo "Warning: pod2pdf not found. Using old niceload.pdf"

parcat.pdf: parcat.pod
	pod2pdf --output-file "$(srcdir)"/parcat.pdf "$(srcdir)"/parcat.pod --title "GNU parcat" \
	|| echo "Warning: pod2pdf not found. Using old parcat.pdf"

parset.pdf: parset.pod
	pod2pdf --output-file "$(srcdir)"/parset.pdf "$(srcdir)"/parset.pod --title "GNU parset" \
	|| echo "Warning: pod2pdf not found. Using old parset.pdf"

parsort.pdf: parsort
	pod2pdf --output-file "$(srcdir)"/parsort.pdf "$(srcdir)"/parsort --title "GNU parsort" \
	|| echo "Warning: pod2pdf not found. Using old parsort.pdf"

parallel_cheat_bw.pdf: parallel_cheat_bw.fodt
	libreoffice --headless --convert-to pdf parallel_cheat_bw.fodt \
	|| echo "Warning: libreoffice failed. Using old parallel_cheat_bw.pdf"

parallel_options_map.pdf: parallel.pod pod2graph
	./pod2graph parallel.pod > parallel_options_map.pdf \
	|| echo "Warning: pod2graph failed. Using old parallel_options_map.pdf"

sem: parallel
	ln -fs parallel sem

