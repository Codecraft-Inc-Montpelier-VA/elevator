#!/usr/bin/env ruby
#  Syntax: ruby goes.rb ["optional-parameters-for-elevator-simulator"]
#
#  This script runs the debug mode version of the elevator simulator application
#  repeatedly until 'q' is entered in the EVT test program.
#
#  Default parameters are for six floors (B, L, 2, 3, 4, and 5) and seven shafts.
#  By default, the elevator simulator supports a named path connection to the
#  test application.
#
#  Created by Cary Campbell on 2007-05-25.
#
################################ Copyright Notice ##############################
#
# This software is copyrighted ? 2007 - 2015 by Codecraft, Inc.
#
# The following terms apply to all files associated with the software
# unless explicitly disclaimed in individual files.
#
# The authors hereby grant permission to use, copy, modify, distribute,
# and license this software and its documentation for any purpose, provided
# that existing copyright notices are retained in all copies and that this
# notice is included verbatim in any distributions. No written agreement,
# license, or royalty fee is required for any of the authorized uses.
# Modifications to this software may be copyrighted by their authors
# and need not follow the licensing terms described here, provided that
# the new terms are clearly indicated on the first page of each file where
# they apply.
#
# IN NO EVENT SHALL THE AUTHORS OR DISTRIBUTORS BE LIABLE TO ANY PARTY
# FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES
# ARISING OUT OF THE USE OF THIS SOFTWARE, ITS DOCUMENTATION, OR ANY
# DERIVATIVES THEREOF, EVEN IF THE AUTHORS HAVE BEEN ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# THE AUTHORS AND DISTRIBUTORS SPECIFICALLY DISCLAIM ANY WARRANTIES,
# INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.  THIS SOFTWARE
# IS PROVIDED ON AN "AS IS" BASIS, AND THE AUTHORS AND DISTRIBUTORS HAVE
# NO OBLIGATION TO PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR
# MODIFICATIONS.
#
# GOVERNMENT USE: If you are acquiring this software on behalf of the
# U.S. government, the Government shall have only "Restricted Rights"
# in the software and related documentation as defined in the Federal
# Acquisition Regulations (FARs) in Clause 52.227.19 (c) (2).  If you
# are acquiring the software on behalf of the Department of Defense, the
# software shall be classified as "Commercial Computer Software" and the
# Government shall have only "Restricted Rights" as defined in Clause
# 252.227-7014 (b) (3) of DFARs.  Notwithstanding the foregoing, the
# authors grant the U.S. Government and others acting in its behalf
# permission to use and distribute the software in accordance with the
# terms specified in this license.
#
################################################################################

default_parms = '-f B#L2-5 -n 7 -p'
#directory     = 'debug'
directory     = 'release'
command       = 'elevator'

if ARGV.size > 0
  parms = ARGV.join
else
  parms = default_parms
end

if $0 == __FILE__
  exit_code = 0
  until exit_code != 0
    system("#{directory}/#{command} #{parms}")
    exit_code = $?.exitstatus
  end
end