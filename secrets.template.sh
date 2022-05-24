export DATACRUNCH_IP=secret
export RASPI_IP=secret
export REYMONTE_IP=secret
export PAPERSPACE_APIKEY=secret
export PAPERSPACE_REYMONTE_MACHINENAME=secret
export UZDROWICIEL_SFTP_ACCOUNTNAME=secret
export BOXNAME="\e[53m\e[4m|set me${BG_DARKGREY1}|\e[55m"


export REYMONTE_IMAGE_REGISTRY_ADDRESS=secret
export REYMONTE_IMAGE_REGISTRY_USER=secret
export REYMONTE_IMAGE_REGISTRY_PASS=secret

export GEOREY_NOTES_LOCATION=secret
# private keyfile to access george@dev.reactai.com  -- a machine kindly provided to me by Charles8
export KEY_DEV_REACTAI_COM_FILE=secret


## little list of benchmarks of cloud CPUs
# benchmark
# POPD = Peta Integer operations per dollar :: (MIPS*3600)*1e-9 / (price/hour) ,
# higher is better (more effective per dollar)
# electricity price = 0.257usd/kWh; assume 500W per kWh
# benchmark command: `7zip b` :: take last line of output:
# CPU USED is the reported CPU load during benchamrk, used by the benchmark threads only. It could be used to calculate correction factor.
# R/U rating, per core means performance per core;
# R/U rating, total means performance in parallel for all CPUs used
# report "Tot" line
# it is normal for the output to vary by 2%-5% between runs, and it does depend on the weather
#
# provider          | CPU                                               | cores booked/
#                   |                                                   |     | CPU used /
#                   |                                                   |     |       | core perf /
#                   |                                                   |     |       |       | all cores MIPS /
#                   |                                                   |     |       |       |       | price per hour /
#                   |                                                   |     |       |       |       |      | POPD
# TP8 laptop, 100W  | Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz (806EC)  |  8C |   707 |  1981 | 13822 | 0.012| 4.146
# R3 desktop, 500W  | AMD Ryzen 9 3900X 12-Core Processor               | 24C |  2229 |  3614 | 80643 | 0.128| 2.268
# Paperspace C5     | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz (406F1) |  4C |   377 |  2687 | 10084 | 0.08 | 0.453
# Paperspace C2     | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz (406F1) |  2C |   192 |  2453 |  4693 | 0.009|  1.877
# Datacrunch CPU16V | AMD EPYC-Rome Processor (830F10)                  | 16C |  1336 |  3875 | 51866 | 0.40 |  0.466
# Datacrunch CPU32V | AMD EPYC-Rome Processor (830F10)                  | 32C |  2839 |  3443 | 97603 | 0.80 |  0.439
# Paperspace C9     | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz         | 24C |  2152 |  2023 | 43421 | 0.90 |  0.173
# Paperspace C9     | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz (406F1) | 24C |  2128 |  2025 | 43004 | 0.90 |  0.172
# ???????           | AMD EPYC 7642 48-Core Processor,                  | 22C |  1807 |  3646 | 65944 |      |
# free and friends
# Gradient Free-GPU | Intel(R) Xeon(R) CPU E5-2623 v4 @ 2.60GHz (406F1) |  8C |   583 |  2276 | 13254 | 0.00 | +inf ?
# Gradient Free-GPU | Intel(R) Xeon(R) CPU E5-2623 v4 @ 2.60GHz (406F1) |  8C |   585 |  2574 | 15052 | 0.00 | +inf ?
# react.ai dev      | Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz (50654)  | 64C |  5837 |  2381 |138762 | 0.00 | +inf ?
# react.ai dev      | Intel(R) Xeon(R) Gold 6142 CPU @ 2.60GHz (50654)  | 64C |  5801 |  2343 |135749 | 0.00 | +inf ?
