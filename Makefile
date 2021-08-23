#
#*++
# PROJECT:
#	elevator
# MODULE:
#	Makefile for the elevator program, a visual integration test for the Simple C/C++ 
#	Coroutines (sccor) Library using ncurses.
#
# ABSTRACT:
#	This Makefile creates an elevator literate program and macOS or Windows Cygwin
#       executable.
#
#	Debug or Release versions of the elevator executable may be selected.
#	By default a Debug executable is built. Use "make CFG=Release" for a
#	Release version.
#
#       "make doc"     creates the elevator literate program, doc/elevator.pdf.
#       "make code"    tangles the elevator C++ source file, code/elevator.cpp,
#.      		 the shared pipe interface header file, include/pipe_interface.h,
#       		 and the shared pipe constants file, code/pipe_interface.cpp.
#       "make outfile" creates the macOS or Cygwin elevator executable, either 
#                        Release/elevator or Debug/elevator, depending on CFG.
#       "make"         with no parameters creates all files.
#*--
#

RM=rm
MKDIR=mkdir
GCC=clang++

all : doc code outfile

BASE = ..
DOCDIR	= ./doc
IMAGEDIR = ./images
CODEDIR	= ./code
INCLUDEDIR = ./include
SCCOR = sccor

REQUIRED_DIRS = \
	$(DOCDIR)\
	$(CODEDIR)\
	$(NULL)

_MKDIRS := $(shell for d in $(REQUIRED_DIRS) ;	\
	     do					\
	       [ -d $$d ] || mkdir -p $$d ;	\
	     done)

VERSION=1.0

vpath %.pdf  $(DOCDIR)
vpath %.html $(DOCDIR)
vpath %.uxf  $(IMAGEDIR)
vpath %.cpp  $(CODEDIR)

PROGNAME = elevator

# If no configuration is specified, "Debug" will be used.
ifndef CFG
CFG=Debug
endif

# Set architecture and PIC options.
ARCH_OPT=
PIC_OPT=
DEFS =
OS := $(shell uname)
ifeq ($(OS),Darwin)
# It's macOS.
ARCH_OPT += -arch x86_64
PIC_OPT += -Wl,-no_pie
else ifeq ($(OS),$(filter CYGWIN_NT%, $(OS)))
# It's Windows.
DEFS = -D"CYGWIN"
else
$(error The elevator program requires macOS Big Sur (11.0.1) or later or Cygwin.)
endif

OUTDIR=./$(CFG)
OUTFILE=$(OUTDIR)/$(PROGNAME)
SCCORDIR = $(BASE)/$(SCCOR)/$(CFG)
OBJ = $(OUTDIR)/$(PROGNAME).o 

#
# Configuration: Debug
#
ifeq "$(CFG)" "Debug"
COMPILE=$(GCC) -c $(ARCH_OPT) $(DEFS) -fno-stack-protector -std=c++17 -O0 -g -o "$(OUTDIR)/$(*F).o" -I$(INCLUDEDIR) "$<"
LINK=$(GCC) $(ARCH_OPT) $(DEFS) -g -o "$(OUTFILE)" $(PIC_OPT) $(OBJ) $(SCCORDIR)/sccorlib.a -lncurses
endif

#
# Configuration: Release
#
ifeq "$(CFG)" "Release"
COMPILE=$(GCC) -c $(ARCH_OPT) $(DEFS) -fno-stack-protector -std=c++17 -O0 -o "$(OUTDIR)/$(*F).o" -I$(INCLUDEDIR) "$<"
LINK=$(GCC) $(ARCH_OPT) $(DEFS) -o "$(OUTFILE)" $(PIC_OPT) $(OBJ) $(SCCORDIR)/sccorlib.a -lncurses
endif

# Pattern rules
$(OUTDIR)/%.o : $(CODEDIR)/%.cpp
	$(COMPILE)

$(OUTFILE): $(OUTDIR)  $(OBJ)
	$(LINK)

$(OUTDIR):
	$(MKDIR) -p "$(OUTDIR)"

# These are the files that are included in the main "aweb" file for the
# domain workbook.
DOCPARTS=\
	intro.txt\
	implementation.txt\
	code_organization.txt\
	litprog.txt\
	edit_warning.txt\
	copyright_info.txt\
	bibliography.txt\
	$(NULL)

# List diagrams here. Include the "uxf" extension. All files listed
# here should be in the "figures" directory. For example:
#	class-diagram.uxf\
#	collaboration.uxf\
#	foo-sm.uxf\

DIAGRAMS =\
	$(NULL)

DOCSRC 	=\
	$(PROGNAME).aweb\
	$(NULL)

FIFO_HEADER = fifo.h

PIPE_HEADER = pipe_interface.h

PIPE_COMMANDS = pipe_commands.cpp

CODEFILES =\
	$(PROGNAME).cpp\
	$(PIPE_COMMANDS)\
	$(NULL)

CODE =\
	$(patsubst %,$(CODEDIR)/%,$(CODEFILES))\
	$(patsubst %,$(INCLUDEDIR)/%,$(PIPE_HEADER))\
	$(patsubst %,$(INCLUDEDIR)/%,$(FIFO_HEADER))\
	$(NULL)

IMAGES =\
	$(patsubst %.uxf,$(IMAGEDIR)/%.pdf,$(DIAGRAMS))\
	$(NULL)

PDF =\
	$(DOCDIR)/$(patsubst %.aweb,%.pdf,$(DOCSRC))\
	$(NULL)

CLEANFILES =\
	$(CODE)\
	$(OUTFILE)\
	$(IMAGES)\
	$(PDF)\
	$(NULL)

A2XOPTS =\
	--no-xmllint\
	$(NULL)

# The verbose option added to A2XOPTS can be used to diagnose errors
# in the asciidoc processing.
# 	--verbose

ATANGLEOPTS =\
	$(NULL)

# The -report option to atangle can be used to provide a diagnostic
# report, containing Chunk Definitions, Chunks Referenced but not 
# Defined, and Chunks Defined but not Referenced.
# 	-report
 
DBLATEX_PARAMS =\
	bibliography.numbered=0\
	index.numbered=0\
	doc.publisher.show=0\
	doc.lot.show=figure,table,equation\
	toc.section.depth=6\
	doc.section.depth=0\
	$(NULL)

# Move and uncomment these lines into the DBLATEX_PARAMS macro to
# produce a draft with a big watermark across the page.
# draft.mode=yes
# draft.watermark=1

DOCINFO	=\
	$(patsubst %.aweb,%-docinfo.xml,$(DOCSRC))\
	docinfo.xml\
	$(NULL)

EXTRAS =\
	$(DOCINFO)\
	$(NULL)

ASCIIDOC_ATTRS =\
	docinfo2\
	$(NULL)


DBLATEX_OPTS =\
	--dblatex-opts="-s ./asciidoc-dblatex-elevatorlogo.sty"\
	--dblatex-opts="$(patsubst %,--param=%,$(DBLATEX_PARAMS))"\
	--dblatex-opts="--fig-path=$(IMAGEDIR)"\
	$(NULL)

ASCIIDOC_OPTS =\
	$(patsubst %,--attribute=%,$(ASCIIDOC_ATTRS))\
	$(NULL)

.PHONY : all code outfile doc clean

doc : $(PDF)

code : $(CODE)\

outfile : $(OUTFILE)

clean :
	$(RM) -f $(CLEANFILES)

$(DOCSRC) : $(DOCPARTS)

$(PDF) : $(DOCSRC) $(DOCPARTS) $(EXTRAS) $(IMAGES)
	@mkdir -p $(DOCDIR)
	a2x $(A2XOPTS) --doctype=article  --format=pdf\
	    --destination-dir=$(DOCDIR)\
	    $(ASCIIDOC_OPTS) $(DBLATEX_OPTS) $<

$(CODE) : $(DOCSRC) $(DOCPARTS)
	@mkdir -p $(CODEDIR)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output $@ $(DOCSRC)

$(PIPE_HEADER) : $(DOCSRC) $(DOCPARTS)
	@mkdir -p $(CODEDIR)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output ./include $(DOCSRC)

$(FIFO_HEADER) : $(DOCSRC) $(DOCPARTS)
	@mkdir -p $(CODEDIR)
	atangle $(ATANGLEOPTS) -root $(notdir $@) -output ./include $(DOCSRC)

%.pdf : %.uxf
	umlet -action=convert -format=pdf\
		-filename=$< -output=$(basename $@)


