
DESTDIR?=${HOME}
SRCDIR=${CURDIR}

FILES=$(wildcard ${SRCDIR}/dot_*)
DEST_FILES=$(patsubst ${SRCDIR}/dot_%, ${DESTDIR}/.%, ${FILES})

all: install


install: update

update:
	git pull --rebase
	git submodule update --init --recursive --remote
	(cd dot_vim; ./update.sh)

push: update
	git push git@github.com:sursingh/dotfiles.git

install: ${DEST_FILES}

${DEST_FILES}: ${DESTDIR}/.% : ${SRCDIR}/dot_%
	ln -s $< $@

clean:
	rm -f ${DEST_FILES}
