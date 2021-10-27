#! /bin/sh

echo
echo "Solution Stack Setup/Preparation ..."
echo

solutionstack="ss"

##
# Gather inputs
##

  # get StackLayer
  read -p "Please enter the relevant SUSE layer (e.g. Kubernetes or Linux) : "  StackLayer

  # get PartnerName
  read -p "Please enter the name of the collaborative partner : " PartnerName

  # get DocumentType
  echo "Please enter the document scope type"
  echo "   (e.g. GS - Getting Started,"
  echo "         RI - Reference Implementation,"
  read -p "         RC - Reference Configuation) : " DocumentType
  documenttype=$( echo ${DocumentType} | tr '[:upper:]' '[:lower:]' )

##
# setup structure, common elements
##

  echo
  echo "=== Create default directory structure"

  [ -d ${PartnerName} ] || mkdir ${PartnerName}
  cd ${PartnerName}

    touch DC-TRD-${StackLayer}-${solutionstack}-${PartnerName}-${documenttype}
    [ -d adoc ] || mkdir -p adoc

    echo "    - for Asciidoc (and common elements)"
    cd adoc && {
	[ -L common_gfdl1.2_i.adoc ] || \
		ln -s ../../../common/adoc/common_gfdl1.2_i.adoc .
	[ -L common_sbp_legal_notice.adoc ] || \
		ln -s ../../../common/adoc/common_sbp_legal_notice.adoc .
	[ -L common_trd_legal_notice.adoc ] || \
		ln -s ../../../common/adoc/common_trd_legal_notice.adoc .
	[ -L common_docinfo_vars.adoc ] || \
		ln -s ../../../common/adoc/common_docinfo_vars.adoc .
	[ -e TRD-${StackLayer}-${solutionstack}-${PartnerName}-${documenttype}.adoc ] || { \
		touch TRD-${StackLayer}-${solutionstack}-${PartnerName}--${documenttype}.adoc
	}
	[ -e TRD-${StackLayer}-${solutionstack}-${PartnerName}-${documenttype}-docinfo.adoc ] || { \
		touch TRD-${StackLayer}-${solutionstack}-${PartnerName}--${documenttype}-docinfo.adoc
	}
	[ -e TRD-${StackLayer}-${solutionstack}-${PartnerName}-${documenttype}-docinfo.xml ] || { \
		touch TRD-${StackLayer}-${solutionstack}-${PartnerName}-${documenttype}-docinfo.xml
	}
    } && cd ..

    [ -d media/src/png ] || mkdir -p media/src/png
    [ -d media/src/svg ] || mkdir -p media/src/svg
    cd media/src/svg && {
	[ -L suse.svg ] || \
		ln -s ../../../../../common/images/src/svg/suse.svg .
	[ -L suse-white-logo-green.svg ] || \
		ln -s ../../../../../common/images/src/svg/suse-white-logo-green.svg .
    } && cd ../../..

    [ -L images ] || \
	    ln -s media images

    echo
