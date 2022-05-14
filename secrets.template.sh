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

## little list of benchmarks of cloud CPUs
# benchmark
# POPD = Peta Integer operations per dollar :: (MIPS*3600)*1e-9 / (price/hour) , the more the better for me (cheaper the instance)
# electricity price = 0.257usd/kWh; assume 500W per kWh
# 7zip b
# assum
# provider          | CPU                                               | cores booked/
#                   |                                                   |     | CPU used /
#                   |                                                   |     |       | core perf /
#                   |                                                   |     |       |       | all cores MIPS /
#                   |                                                   |     |       |       |       | price per hour /
#                   |                                                   |     |       |       |       |      | POPD
# R3 desktop, 500W  | AMD Ryzen 9 3900X 12-Core Processor               | 24C |  2229 |  3614 | 80643 | 0.128| 2.268
# TP8 laptop, 100W  | Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz (806EC)  |  8C |   707 |  1981 | 13822 | 0.012| 4.146
# Paperspace C5     | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz (406F1) |  4C |   377 |  2687 | 10084 | 0.08 | 0.453
# ???????           | AMD EPYC 7642 48-Core Processor,                  | 22C |  1807 |  3646 | 65944 |      |
# Paperspace C2     | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz (406F1) |  2C |   192 |  2453 |  4693 | 0.009|  1.877
# Paperspace C9     | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz (406F1) | 24C |  2128 |  2025 | 43004 | 0.90 |  0.172
# Paperspace C9     | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz         | 24C |  2152 |  2023 | 43421 | 0.90 |  0.173
# Gradient Free-GPU | Intel(R) Xeon(R) CPU E5-2623 v4 @ 2.60GHz (406F1) |  8C |   583 |  2276 | 13254 | 0.00 | +inf ?
# Datacrunch CPU32V | AMD EPYC-Rome Processor (830F10)                  | 32C |  2839 |  3443 | 97603 | 0.80 |  0.439
# Datacrunch CPU16V | AMD EPYC-Rome Processor (830F10)                  | 16C |  1336 |  3875 | 51866 | 0.40 |  0.466