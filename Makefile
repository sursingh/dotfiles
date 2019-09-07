
DESTDIR?=${HOME}
SRCDIR=${CURDIR}

FILES=$(wildcard ${SRCDIR}/dot_*)
DEST_FILES=$(patsubst ${SRCDIR}/dot_%, ${DESTDIR}/.%, ${FILES})

all: install


install: update

update:
	git stash
	git submodule update --depth 5 --init --recursive --remote
	git stash pop
	git mergetool -t vimdiff
	(cd dot_vim/bundle/youcompleteme; python3 install.py)

push:
	git push git@github.com:sursingh/dotfiles.git

install: ${DEST_FILES}

${DEST_FILES}: ${DESTDIR}/.% : ${SRCDIR}/dot_%
	ln -s $< $@

clean:
	rm -f ${DEST_FILES}
