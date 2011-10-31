################################################################################
##
##  Makefile
##      Author: Jitao David Zhang <jitao_david.zhang@roche.com>
##	Department of Bioinformatics, F. Hoffmann-La Roche AG
##      Description: Makefile for building distributions etc.
##                   the Makefile provides the following targets:
##                   
##                   - make install  calls R CMD INSTALL
##                   - make check    calls R CMD check (with RUnit)
##                   - make dist     calls R CMD build
##
################################################################################

R=R
PKG          := rqubic
PKG_VERSION  := 1.0

PKG_ROOT_DIR := $(shell pwd)
PKG_SRC_DIR := $(PKG_ROOT_DIR)/src
PKG_DIST_ROOT_DIR := ../$(PKG).tmp
PKG_HIDDEN_FILES  := Makefile 

install: 
	@echo '====== Installing Package ======'
	@(cd ..; ${R} CMD INSTALL $(PKG))
	@echo '====== Installing finished ======'
	@echo ' '

check:	clean
	@echo '====== Checking Package ======'
	@(export R_DEVELOP_MODE=TRUE; cd ..; ${R} CMD check $(PKG))
	@echo '====== Checking finished ======'
	@echo ' '

dist:	
	@echo '====== Building Distribution ======'
	cp -rp $(PKG_ROOT_DIR) $(PKG_DIST_ROOT_DIR)
	@(cd ..; $(RM) -r $(PKG_HIDDEN_FILES); R CMD build $(PKG))
	$(RM) -r $(PKG_DIST_ROOT_DIR)
	@echo '====== Building finished ======'
	@echo ' '
	@echo '====== Checking Package ======'
	@(export R_DEVELOP_MODE=TRUE; ${R} CMD check $(PKG)_$(PKG_VERSION).tar.gz)
	@echo '====== Checking finished  ======'
	@echo ' '
clean:
	@echo '====== Cleaning Package ======'
	$(RM) -f $(PKG_SRC_DIR)/*.o $(PKG_SRC_DIR)/*.so
	@echo '====== Cleaning finished  ======'
	@echo ' '