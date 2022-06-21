export GEORGE_ADDONS_FOLDER=secret

export DATACRUNCH_IP=secret
export RASPI_IP=secret
export REYMONTE_IP=secret
export PAPERSPACE_APIKEY=secret
export PAPERSPACE_REYMONTE_MACHINENAME=secret
export REYMONTE_IMAGE_REGISTRY_ADDRESS=secret
export REYMONTE_IMAGE_REGISTRY_USER=secret
export REYMONTE_IMAGE_REGISTRY_PASS=secret
export BOXNAME="\e[53m\e[4m|set me${BG_DARKGREY1}|\e[55m"

export UZDROWICIEL_SFTP_ACCOUNTNAME=secret
export UZDROWICIEL_SFTP_PASS=secret
export UZDROWICIEL_SFTP_SERVER=secret


export REYMONTE_IMAGE_REGISTRY_ADDRESS=secret
export REYMONTE_IMAGE_REGISTRY_USER=secret
export REYMONTE_IMAGE_REGISTRY_PASS=secret

export GEOREY_NOTES_LOCATION=secret
# private keyfile to access george@dev.reactai.com  -- a machine kindly provided to me by Charles
export KEY_DEV_REACTAI_COM_FILE=secret

export github_public_push_email=secret
# git config user.email ${github_public_push_email}
# git config user.name "George Rey"

## A little list of benchmarks of cloud CPUs
#
# The cloud CPUs are much slower than the desktop CPUs. The are a couple reasons for this, mainly:
# * The cloud CPUs are downclocked to save on power. Energy cost is the main cost of the cloud compute providers.
# * When taking 1 vCPU out of a 32-core, 64-thread chip, you also get 1/64th of the memory bandwidth and other resources
# * There might be "noisy neighbours", that is, other tenants on the same machine that already use up the resources
# * These CPUs are often old: 1,2,3 generations behind current desktop chips.
#
#
## Definitions
#
# POPD = Peta Integer operations per dollar :: (MIPS*3600)*1e-9 / (price/hour);
# higher is better (more effective per dollar)
#
# electricity price = 0.257usd/kWh; assume 500W per kWh effective
#
# benchmark command: `7zip b` :: take last line of output:
# CPU USED is the reported CPU load during benchmark, used by the benchmark threads only. It could be used to calculate correction factor.
# R/U rating, per core means performance per core;
# R/U rating, total means performance in parallel for all CPUs used
# report "Tot" line
# can report on 1 core used or all cores used
#
# it is normal for the output to vary by 2%-5% between runs, and it does depend on the weather

# By default, use all cores for benchmark : ( 7za b )
# additionally, can use only 1 core and small dictionary, average 16 times : ( 7za b 16 -mmt1 -md22 )
#
#
#
# provider                     | CPU                                               | cores booked/
#                              |                                                   |       | CPU used /
#                              |                                                   |       |       | core perf /
#                              |                                                   |       |       |       | all cores MIPS /
#                              |                                                   |       |       |       |       | price per hour /
#                              |                                                   |       |       |       |       |      | POPD
# TP8 laptop, 100W             | Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz (806EC)  |    8C |   707 |  1981 | 13822 | 0.012| 4.146
# R3 desktop, 500W             | AMD Ryzen 9 3900X 12-Core                         |   24C |  2229 |  3614 | 80643 | 0.128| 2.268
# R3 desktop, 500W -mmt1 -md22 | AMD Ryzen 9 3900X 12-Core                         | 1/24C |   100 |  5519 |   --- | 0.128|   ---
# Paperspace C5                | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz (406F1) |    4C |   377 |  2687 | 10084 | 0.08 | 0.453
# Paperspace C2                | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz (406F1) |    2C |   192 |  2453 |  4693 | 0.009|  1.877
# Datacrunch CPU16V            | AMD EPYC-Rome Processor (830F10)                  |   16C |  1336 |  3875 | 51866 | 0.40 |  0.466
# Datacrunch CPU32V            | AMD EPYC-Rome Processor (830F10)                  |   32C |  2839 |  3443 | 97603 | 0.80 |  0.439
# Paperspace C9                | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz         |   24C |  2152 |  2023 | 43421 | 0.90 |  0.173
# Paperspace C9                | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz (406F1) |   24C |  2128 |  2025 | 43004 | 0.90 |  0.172
# ???????                      | AMD EPYC 7642 48-Core Processor,                  |   22C |  1807 |  3646 | 65944 |      |
# free and friends
# Gradient Free-GPU            | Intel(R) Xeon(R) CPU E5-2623 v4 @ 2.60GHz (406F1) |    8C |   583 |  2276 | 13254 | 0.00 | +inf ?
# Gradient Free-GPU            | Intel(R) Xeon(R) CPU E5-2623 v4 @ 2.60GHz (406F1) |    8C |   585 |  2574 | 15052 | 0.00 | +inf ?
# react.ai dev                 | Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz (50654)  |   64C |  5837 |  2381 |138762 | 0.00 | +inf ?
# react.ai dev -mmt1 -md22     | Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz (50654)  | 1/64C |   100 |  4367 |   --- | 0.00 | +inf ?
# Android Tablet               | ?? Huawei-something @ 4.5W                        |    8C |   697 |  1542 |  1077 | ?.?? | +?
# Bitbucket "x2"               | CPUs Intel(R) Xeon(R) Platinum 8175M CPU @ 2.50GHz|    8C |   396 |  2491 |  9866 | ?.?? | +?
# STL bpfeil-precision3440     | Intel(R) i7-10800 @ 2.90GHz                       |   16C |  1486 |  3412 | 50433 | ?.?? | +inf?
# STL bpfeil-precision3440     | Intel(R) i7-10800 @ 2.90GHz                       |    1C |   100 |  5508 |  5508 | ?.?? | +inf?