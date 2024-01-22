#!/bin/bash

###############################################################
#
# This Script will used to addTarget and unTarget of Data Source in domain
# This is supposed to use for Targeting/UnTargeting DS process which ASG perform while DR FailOver
# Author : Ishanka Ranasooriya
# Date : 2016 June 07
# Version : 1.0
#
###############################################################

DOMAIN="$1"
SITE="$2"
COMMAND="$3"
PROPNAME="DsDetails.properties"
BASEPATH="/batch/ASG_Scripts/AddRemoveTarget"
CONFDIR="${BASEPATH}/conf"
BINDIR="${BASEPATH}/bin"
CONFNAME="$DOMAIN-$SITE-$PROPNAME"
DOMAINHOME="/wls_domains/$DOMAIN"
LOGPATH="/batch/ASG_Scripts/AddRemoveTarget"
LOGNAME="errors.log"

if [ "$1" = "" ]; then
        echo "Usage: ./AddRemoveTarget.sh DOMAIN(ex:gpowdp03) SITE(ex:HW/RG) COMMAND:(add/remove)"
        exit 1
elif [ "$2" = "" ]; then
        echo "Usage: ./AddRemoveTarget.sh DOMAIN(ex:gpowdp03) SITE(ex:HW/RG) COMMAND:(add/remove)"
        exit 1
else
    if [ "$3" = "" ]; then
			echo "Usage: ./AddRemoveTarget.sh DOMAIN(ex:gpowdp03) SITE(ex:HW/RG) COMMAND:(add/remove)"
            exit 1
    fi
fi

##########################################################
##### Make sure only domain users can run our script #####
##########################################################

if [ "$(id -u)" = "0" ]; then
   echo "This script must be run as domain user" 1>&2
   exit 1
fi

if [ "$(id -u -n)" != "$DOMAIN" ]; then
        echo "This script must be run as domain user" 1>&2
        exit 1
fi

######################################
##### UnTargeting DS from Domain #####
######################################

if [ "$COMMAND" = "remove" ]; then

	cp $CONFDIR/$CONFNAME $BINDIR/$PROPNAME
	. $DOMAINHOME/bin/setDomainEnv.sh > /dev/null 2>&1
	cd $BINDIR
	java weblogic.WLST $BINDIR/UnTargate-DS.py 2> $LOGPATH/$LOGNAME
	rm -fr $BINDIR/$PROPNAME
	
fi

if [ "$COMMAND" = "add" ]; then

	cp $CONFDIR/$CONFNAME $BINDIR/$PROPNAME
	. $DOMAINHOME/bin/setDomainEnv.sh > /dev/null 2>&1
	cd $BINDIR
	java weblogic.WLST $BINDIR/Targate-DS.py 2> $LOGPATH/$LOGNAME
	rm -fr $BINDIR/$PROPNAME
	
fi
