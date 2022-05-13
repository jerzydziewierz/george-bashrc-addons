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
# TPISh = price per Tera integer ops per second per dolar :: MIPS/price*1e6
# 7zip b
# provider          | CPU                                               | cores booked/
#                   |                                                   |     | CPU used /
#                   |                                                   |     |       | core perf /
#                   |                                                   |     |       |       | all cores MIPS /
#                   |                                                   |     |       |       |       | price per hour /
#                   |                                                   |     |       |       |       |      | price per TIPSh
# R3 desktop        | AMD Ryzen 9 3900X 12-Core Processor               | 24C |  2229 |  3614 | 80643 |      | ~0?
# TP8 laptop        | Intel(R) Core(TM) i7-8665U CPU @ 1.90GHz (806EC)  |  8C |   707 |  1981 | 13822 |      |
# Paperspace C??    | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz (406F1) |  4C |   377 |  2687 | 10084 |      |
# ???????           | AMD EPYC 7642 48-Core Processor,                  | 22C |  1807 |  3646 | 65944 |      |
# Paperspace C9     | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz (406F1) | 24C |  2128 |  2025 | 43004 | 0.90 | 20.7
# Paperspace C9     | Intel(R) Xeon(R) CPU E5-2620 v4 @ 2.10GHz         | 24C |  2152 |  2023 | 43421 | 0.90 | 20.7
# Datacrunch CPU32V | AMD EPYC-Rome Processor (830F10)                  | 32C |  2839 |  3443 | 97603 | 0.80 |  8.20
# Datacrunch CPU16V | AMD EPYC-Rome Processor (830F10)                  | 16C |  1336 |  3875 | 51866 | 0.40 |  7.71