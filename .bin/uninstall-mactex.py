#!/usr/bin/env python

from os import path
import sys
import subprocess
import platform
import os
import logging
import errno

SELF = path.basename(sys.argv[0])

logging.basicConfig(level=logging.DEBUG)
log = logging.getLogger(SELF)



if platform.system() != "Darwin":
    log.critical("%s: This script only works on OS X" % SELF)
    sys.exit(1)

BOM_DIR = "/var/db/receipts/"
INSTALL_DIR = "/usr/local"

GS_VERSION = "9.05"
IM_VESION = "6.7.6-9"

GS_BOM = path.join(BOM_DIR, "org.tug.mactex.ghostscript%s.bom" % GS_VERSION)
IM_BOM = path.join(BOM_DIR, "org.tug.mactex.imagemagick-convert-%s.bom" % IM_VESION)


def is_dir_empty(dir):
    """
    Check if the dir passed in @p dir is empty.
    """
    return os.listdir(dir)


def remove_bom(bom_filename):
    """
    Remove all files installed by a given BOM
    Also removes empty directories.
"""
    log.info("Removing from BOM file %s" % bom_filename)
    
    output = subprocess.check_output(
        "lsbom \"%s\" | awk '{ print $1 }'" % bom_filename,
        shell=True)
    file_list = output.split('\n')
    # Prepend the install dir
    file_list = [path.join(INSTALL_DIR, x) for x in file_list]

    # Delete the files, while also collecting their directories
    dirs = set()
    for f in file_list:
        f = path.normpath(f)

        file_dir = None
        if path.isdir(f):
            file_dir = f
        else:
            file_dir = path.dirname(f)
            try:
                os.remove(f)
                log.info("Removed file %r" % f)
            except OSError as e:
                if e.errno == errno.ENOENT:
                    continue
                elif e.errno == errno.EACCES:
                    raise
        dirs.add(file_dir)

    dirs = list(dirs)
    dirs = [path.normpath(x) for x in dirs]
    dirs.sort(reverse=True)

    log.info("Removing empty directories")
    for d in dirs:
        try:
            os.rmdir(d)
            log.info("Removed directory %r" % d)
        except OSError as e:
            if e.errno == errno.ENOTEMPTY:
                log.debug("Not removing non-empty directory %r" % d)
                continue
            elif e.errno == errno.EACCES:
                log.debug("No permissions to remove directory %r" % d)
            raise

log.info("Uninstalling GhostScript")
remove_bom(GS_BOM)

log.info("Uninstalling ImageMagick")
remove_bom(IM_BOM)

