
DESTDIR?=${HOME}
SRCDIR=${CURDIR}

FILES=$(wildcard ${SRCDIR}/dot_*)
DEST_FILES=$(patsubst ${SRCDIR}/dot_%, ${DESTDIR}/.%, ${FILES})

all: install

install: update

update:
	git submodule update --depth 1000 --init --recursive
	(\
	    cd dot_vim/bundle/youcompleteme; \
	    git submodule sync --recursive; \
	    git submodule update --init --recursive; \
	    python3 install.py\
	)

push:
	git push git@github.com:sursingh/dotfiles.git

install: ${DEST_FILES}

${DEST_FILES}: ${DESTDIR}/.% : ${SRCDIR}/dot_%
	ln -s $< $@

clean:
	rm -f ${DEST_FILES}
