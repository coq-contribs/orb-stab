all: Makefile.coq
	+make -f Makefile.coq all

clean: Makefile.coq
	+make -f Makefile.coq clean
	rm -f Makefile.coq

ifeq ($(USE_GIT_SUBMODULES),yes)

# This is what we have to do if we cannot rely on things installed via OPAM
Makefile.coq: Make
	$(COQBIN)coq_makefile -f Make -o Makefile.coq -R algebra Algebra -R lin-alg LinAlg

else

# This is what we do if we can rely on things installed via OPAM
D=`coqtop -where`/user-contrib/
Makefile.coq: Make
	$(COQBIN)coq_makefile -f Make -o Makefile.coq -R $(D)Algebra Algebra -R $(D)LinAlg LinAlg

endif

%: Makefile.coq
	+make -f Makefile.coq $@

.PHONY: all clean
