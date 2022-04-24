#!/usr/bin/env bash

__powerline() {
    # Unicode symbols
    readonly GIT_BRANCH_CHANGED_SYMBOL='+'
    readonly GIT_NEED_PULL_SYMBOL='⇣'
    readonly GIT_NEED_PUSH_SYMBOL='⇡'
    readonly PS_SYMBOL='🐧'

    # Solarized colorscheme
    readonly BG_BASE00="\\[$(tput setab 11)\\]"
    readonly BG_BASE01="\\[$(tput setab 10)\\]"
    readonly BG_BASE02="\\[$(tput setab 0)\\]"
    readonly BG_BASE03="\\[$(tput setab 8)\\]"
    readonly BG_BASE0="\\[$(tput setab 12)\\]"
    readonly BG_BASE1="\\[$(tput setab 14)\\]"
    readonly BG_BASE2="\\[$(tput setab 7)\\]"
    readonly BG_BASE3="\\[$(tput setab 15)\\]"
    readonly BG_BLUE="\\[$(tput setab 4)\\]"
    readonly BG_DARKGREY1="\\[\\e[48;5;232m\\]"
    readonly BG_DARKGREY2="\\[\\e[48;5;234m\\]"
    readonly BG_DARKGREY3="\\[\\e[48;5;236m\\]"
    readonly BG_DARKGREEN1="\\[\\e[48;5;022m\\]"
    readonly BG_COLOR1="\\[\\e[48;5;240m\\]"
    readonly BG_COLOR2="\\[\\e[48;5;238m\\]"
    readonly BG_COLOR3="\\[\\e[48;5;238m\\]"
    #readonly BG_COLOR4="\\[\\e[48;5;31m\\]"
    readonly BG_COLOR4=$BG_DARKGREEN1
    readonly BG_COLOR5="\\[\\e[48;5;31m\\]"
    readonly BG_COLOR6="\\[\\e[48;5;237m\\]"
    readonly BG_COLOR7="\\[\\e[48;5;237m\\]"
    readonly BG_COLOR8="\\[\\e[48;5;161m\\]"
    readonly BG_COLOR9="\\[\\e[48;5;161m\\]"
    readonly BG_CYAN="\\[$(tput setab 6)\\]"
    readonly BG_GREEN="\\[$(tput setab 2)\\]"
    readonly BG_MAGENTA="\\[$(tput setab 5)\\]"
    readonly BG_ORANGE="\\[$(tput setab 9)\\]"
    readonly BG_RED="\\[$(tput setab 1)\\]"
    readonly BG_VIOLET="\\[$(tput setab 13)\\]"
    readonly BG_YELLOW="\\[$(tput setab 3)\\]"
    readonly BOLD="\\[$(tput bold)\\]"
    readonly DIM="\\[$(tput dim)\\]"
    readonly FG_BASE00="\\[$(tput setaf 11)\\]"
    readonly FG_BASE01="\\[$(tput setaf 10)\\]"
    readonly FG_BASE02="\\[$(tput setaf 0)\\]"
    readonly FG_BASE03="\\[$(tput setaf 8)\\]"
    readonly FG_BASE0="\\[$(tput setaf 12)\\]"
    readonly FG_BASE1="\\[$(tput setaf 14)\\]"
    readonly FG_BASE2="\\[$(tput setaf 7)\\]"
    readonly FG_BASE3="\\[$(tput setaf 15)\\]"
    readonly FG_BLUE="\\[$(tput setaf 4)\\]"
    readonly FG_COLOR1="\\[\\e[38;5;250m\\]"
    readonly FG_COLOR2="\\[\\e[38;5;240m\\]"
    readonly FG_COLOR3="\\[\\e[38;5;250m\\]"
    readonly FG_COLOR4="\\[\\e[38;5;238m\\]"
    #readonly FG_COLOR6="\\[\\e[38;5;31m\\]"
    readonly FG_COLOR6="\\[\\e[38;5;022m\\]"
    readonly FG_COLOR7="\\[\\e[38;5;250m\\]"
    readonly FG_COLOR8="\\[\\e[38;5;237m\\]"
    readonly FG_COLOR9="\\[\\e[38;5;161m\\]"
    readonly FG_BROWN1="\\[\\e[38;5;1m\\]"
    readonly FG_GRASS22="\\[\\e[38;5;22m\\]"
    readonly FG_BROWN52="\\[\\e[38;5;52m\\]"
    readonly FG_CYAN="\\[$(tput setaf 6)\\]"
    readonly FG_GREEN="\\[$(tput setaf 2)\\]"
    readonly FG_MAGENTA="\\[$(tput setaf 5)\\]"
    readonly FG_ORANGE="\\[$(tput setaf 9)\\]"
    readonly FG_RED="\\[$(tput setaf 1)\\]"
    readonly FG_VIOLET="\\[$(tput setaf 13)\\]"
    readonly FG_YELLOW="\\[$(tput setaf 3)\\]"
    readonly RESET="\\[$(tput sgr0)\\]"
    readonly REVERSE="\\[$(tput rev)\\]"

    __git_info() {
        # no .git directory
    	[ -d .git ] || return

        local aheadN
        local behindN
        local branch
        local marks
        local stats

        # get current branch name or short SHA1 hash for detached head
        branch="$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always 2>/dev/null)"
        [ -n "$branch" ] || return  # git branch not found

        # how many commits local branch is ahead/behind of remote?
        stats="$(git status --porcelain --branch | grep '^##' | grep -o '\[.\+\]$')"
        aheadN="$(echo "$stats" | grep -o 'ahead \d\+' | grep -o '\d\+')"
        behindN="$(echo "$stats" | grep -o 'behind \d\+' | grep -o '\d\+')"
        [ -n "$aheadN" ] && marks+=" $GIT_NEED_PUSH_SYMBOL$aheadN"
        [ -n "$behindN" ] && marks+=" $GIT_NEED_PULL_SYMBOL$behindN"

        # print the git branch segment without a trailing newline
        # branch is modified?
        if [ -n "$(git status --porcelain)" ]; then
            printf "%s" "${BG_COLOR8}$RESET$BG_COLOR8 $branch$marks $FG_COLOR9"
        else
            printf "%s" "${BG_BLUE}$RESET$BG_BLUE $branch$marks $RESET$FG_BLUE"
        fi
    }

    ps1() {
        # Check the exit code of the previous command and display different
        # colors in the prompt accordingly.
        if [ "$?" -eq 0 ]; then
            local BG_EXIT="$BG_GREEN"
            local FG_EXIT="$FG_GREEN"
        else
            local BG_EXIT="$BG_RED"
            local FG_EXIT="$FG_RED"
        fi
        PS1=""
        if [ $(whoami) = "root" ]; then
          PS1+="${BG_RED}${FG_RED}|${RESET}${FG_RED}ROOT${BG_RED}|${RESET}"
        fi

        # add box name
        PS1+="${FG_COLOR1}${BOLD}${FG_GRASS22}${BOXNAME}${RESET}"

        # if conda env is set, add it. Otherwise, skip.
        if [ ! -z "${CONDA_DEFAULT_ENV}" ]; then
          PS1+=${BG_DARKGREY1}"|"${CONDA_DEFAULT_ENV}"|"${RESET}
        fi
        PS1+="${BG_COLOR4}\\w"
        PS1+="$RESET${FG_COLOR6}"
        PS1+="$(__git_info)"
        PS1+="$BG_EXIT$RESET"
        PS1+="$BG_EXIT$FG_BASE3 ${PS_SYMBOL} ${RESET}${FG_EXIT}${RESET} "
    }

    PROMPT_COMMAND=ps1
}

if [ -n "${powerline_fonts_enabled}" ] ; then 
    # echo "powerline fonts enabled."
    : # this is a no-op
else
    readonly powerline_fonts_enabled=1
    __powerline
    unset __powerline
fi

# interesting unicode characters to try:
# ⌘ ⏎ ⏏ ⏐ ⏑ ⏒ ⏓ ⏔ ⏕ ⏖ ⏗ ⏘ ⏙ ⏚ ⏛ ⏜ ⏝ ⏞ ⏟ ⏠ ⏡ ⏢ ⏣ ⏤ ⏥ ⏦ ⏧ ⏨ ⏩ ⏪ ⏫ ⏬ ⏭ ⏮ ⏯ ⏰ ⏱ ⏲ ⏳ ⏴ ⏵ ⏶ ⏷ ⏸ ⏹ ⏺ ⏻ ⏼ ⏽ ⏾ ⏿
# more interesting unicode characters: ۩
# Ϡ  ϡ  Ϣ  ֍  ֎  ֏ Դ Է Ը Թ Ժ Խ Ծ Կ Հ Ձ Ղ Ճ Շ Ո Չ Պ Ջ Վ Ց Փ Ք Ֆ բ ժ ի խ ծ կ ձ շ չ  պ  ջվ  տ  րփ ֆ  ֍  ֎  ֏
# ۞  ۩ ߶  ߷ ߁  ߂  ߃  ߄  ߅  ߆  ߇  ߈  ߉  ࠁ  ࠂ  ࠃ  ࠄ  ࠅ  ࠆ  ࠇ  ࠈ  ࠉ  ࠊ  ࠋ  ࠌ  ࠍ
# entire page of `unicode 1600..`
#  ⃠
# unicode 2500..
# unicode 2600..
# unicode 2700..
# ⧠  ⧡  ⧢  ⧣  ⧤  ⧥  ⧦  ⧧  ⧨  ⧩  ⧪  ⧫  ⧬  ⧭  ⧮  ⧯
# ⧰  ⧱  ⧲  ⧳  ⧴  ⧵  ⧶  ⧷  ⧸  ⧹  ⧺  ⧻  ⧼  ⧽  ⧾  ⧿
# 2A0.  ⨀  ⨁  ⨂  ⨃  ⨄  ⨅  ⨆  ⨇  ⨈  ⨉  ⨊  ⨋  ⨌  ⨍  ⨎  ⨏
# 2A1.  ⨐  ⨑  ⨒  ⨓  ⨔  ⨕  ⨖  ⨗  ⨘  ⨙  ⨚  ⨛  ⨜  ⨝  ⨞  ⨟
# 2A2.  ⨠  ⨡  ⨢  ⨣  ⨤  ⨥  ⨦  ⨧  ⨨  ⨩  ⨪  ⨫  ⨬  ⨭  ⨮  ⨯
#  2B0.  ⬀  ⬁  ⬂  ⬃  ⬄  ⬅  ⬆  ⬇  ⬈  ⬉  ⬊  ⬋  ⬌  ⬍  ⬎  ⬏
#  2B1.  ⬐  ⬑  ⬒  ⬓  ⬔  ⬕  ⬖  ⬗  ⬘  ⬙  ⬚ ⬛ ⬜  ⬝  ⬞  ⬟
#  2B2.  ⬠  ⬡  ⬢  ⬣  ⬤  ⬥  ⬦  ⬧  ⬨  ⬩  ⬪  ⬫  ⬬  ⬭  ⬮  ⬯
# 2B3.  ⬰  ⬱  ⬲  ⬳  ⬴  ⬵  ⬶  ⬷  ⬸  ⬹  ⬺  ⬻  ⬼  ⬽  ⬾  ⬿
# 2B4.  ⭀  ⭁  ⭂  ⭃  ⭄  ⭅  ⭆  ⭇  ⭈  ⭉  ⭊  ⭋  ⭌  ⭍  ⭎  ⭏
# 2B5. ⭐  ⭑  ⭒  ⭓  ⭔ ⭕  ⭖  ⭗  ⭘  ⭙  ⭚  ⭛  ⭜  ⭝  ⭞  ⭟
# 2B6.  ⭠  ⭡  ⭢  ⭣  ⭤  ⭥  ⭦  ⭧  ⭨  ⭩  ⭪  ⭫  ⭬  ⭭  ⭮  ⭯
# 2B7.  ⭰  ⭱  ⭲  ⭳ ⭴ ⭵  ⭶  ⭷  ⭸  ⭹  ⭺  ⭻  ⭼  ⭽  ⭾  ⭿
# 2B8.  ⮀  ⮁  ⮂  ⮃  ⮄  ⮅  ⮆  ⮇  ⮈  ⮉  ⮊  ⮋  ⮌  ⮍  ⮎  ⮏
# 2B9.  ⮐  ⮑  ⮒  ⮓  ⮔  ⮕ ⮖ ⮗  ⮘  ⮙  ⮚  ⮛  ⮜  ⮝  ⮞  ⮟
# 2BA.  ⮠  ⮡  ⮢  ⮣  ⮤  ⮥  ⮦  ⮧  ⮨  ⮩  ⮪  ⮫  ⮬  ⮭  ⮮  ⮯
# 2BB.  ⮰  ⮱  ⮲  ⮳  ⮴  ⮵  ⮶  ⮷  ⮸  ⮹  ⮺  ⮻  ⮼  ⮽  ⮾  ⮿
# 2BC.  ⯀  ⯁  ⯂  ⯃  ⯄  ⯅  ⯆  ⯇  ⯈  ⯉  ⯊  ⯋  ⯌  ⯍  ⯎  ⯏
# ㍘ ㍙ ㍚ ㍛ ㍜ ㍝ ㍞ ㍟
# 336. ㍠ ㍡ ㍢ ㍣ ㍤ ㍥ ㍦ ㍧ ㍨ ㍩ ㍪ ㍫ ㍬ ㍭ ㍮ ㍯
# 337. ㍰ ㍱ ㍲ ㍳ ㍴ ㍵ ㍶ ㍷ ㍸ ㍹ ㍺ ㍻ ㍼ ㍽ ㍾ ㍿
# 338. ㎀ ㎁ ㎂ ㎃ ㎄ ㎅ ㎆ ㎇ ㎈ ㎉ ㎊ ㎋ ㎌ ㎍ ㎎ ㎏
# 339. ㎐ ㎑ ㎒ ㎓ ㎔ ㎕ ㎖ ㎗ ㎘ ㎙ ㎚ ㎛ ㎜ ㎝ ㎞ ㎟
# 33A. ㎠ ㎡ ㎢ ㎣ ㎤ ㎥ ㎦ ㎧ ㎨ ㎩ ㎪ ㎫ ㎬ ㎭ ㎮ ㎯
# 33B. ㎰ ㎱ ㎲ ㎳ ㎴ ㎵ ㎶ ㎷ ㎸ ㎹ ㎺ ㎻ ㎼ ㎽ ㎾ ㎿
# 33C. ㏀ ㏁ ㏂ ㏃ ㏄ ㏅ ㏆ ㏇ ㏈ ㏉ ㏊ ㏋ ㏌ ㏍ ㏎ ㏏
# 33D. ㏐ ㏑ ㏒ ㏓ ㏔ ㏕ ㏖ ㏗ ㏘ ㏙ ㏚ ㏛ ㏜ ㏝ ㏞ ㏟
#   ꕱ  ꕲ  ꕳ  ꕴ  ꕵ  ꕶ  ꕷ  ꕸ  ꕹ  ꕺ  ꕻ  ꕼ  ꕽ  ꕾ  ꕿ
#     A60.  ꘀ  ꘁ  ꘂ  ꘃ  ꘄ  ꘅ  ꘆ  ꘇ  ꘈ  ꘉ  ꘊ  ꘋ  ꘌ  ꘍  ꘎  ꘏
#     A61.  ꘐ  ꘑ  ꘒ  ꘓ  ꘔ  ꘕ  ꘖ  ꘗ  ꘘ  ꘙ  ꘚ  ꘛ  ꘜ  ꘝ  ꘞ  ꘟ
#     A62.  ꘠  ꘡  ꘢  ꘣  ꘤  ꘥  ꘦  ꘧  ꘨  ꘩  ꘪ  ꘫ ꘬ ꘭ ꘮ ꘯
#     A64.  Ꙁ  ꙁ  Ꙃ  ꙃ  Ꙅ  ꙅ  Ꙇ  ꙇ  Ꙉ  ꙉ  Ꙋ  ꙋ  Ꙍ  ꙍ  Ꙏ  ꙏ
#     A65.  Ꙑ  ꙑ  Ꙓ  ꙓ  Ꙕ  ꙕ  Ꙗ  ꙗ  Ꙙ  ꙙ  Ꙛ  ꙛ  Ꙝ  ꙝ  Ꙟ  ꙟ
#     A66.  Ꙡ  ꙡ  Ꙣ  ꙣ  Ꙥ  ꙥ  Ꙧ  ꙧ  Ꙩ  ꙩ  Ꙫ  ꙫ  Ꙭ  ꙭ  ꙮ
#                                         
#     E01.                                
#     E02.                                
#     E03.                                
#     E04.                                
#     E05.                                
#     E06.                                
#     E07.                                
#     E08.                                
#     E09.                                
#     E0A.                                
#     E0B.                                
#     E0C.                                
#     E0D.                                

#   
#          
  #     E17.                                
# press   + 
#   
# entire page unicode F000..
# pages 13000 to 13400 . . . egiptian hieroglyphs, many of them useful today
#0001 300.  𓀀  𓀁  𓀂  𓀃  𓀄  𓀅  𓀆  𓀇  𓀈  𓀉  𓀊  𓀋  𓀌  𓀍  𓀎  𓀏
#0001 301.  𓀐  𓀑  𓀒  𓀓  𓀔  𓀕  𓀖  𓀗  𓀘  𓀙  𓀚  𓀛  𓀜  𓀝  𓀞  𓀟
#0001 302.  𓀠  𓀡  𓀢  𓀣  𓀤  𓀥  𓀦  𓀧  𓀨  𓀩  𓀪  𓀫  𓀬  𓀭  𓀮  𓀯
#0001 303.  𓀰  𓀱  𓀲  𓀳  𓀴  𓀵  𓀶  𓀷  𓀸  𓀹  𓀺  𓀻  𓀼  𓀽  𓀾  𓀿
#0001 304.  𓁀  𓁁  𓁂  𓁃  𓁄  𓁅  𓁆  𓁇  𓁈  𓁉  𓁊  𓁋  𓁌  𓁍  𓁎  𓁏
#0001 305.  𓁐  𓁑  𓁒  𓁓  𓁔  𓁕  𓁖  𓁗  𓁘  𓁙  𓁚  𓁛  𓁜  𓁝  𓁞  𓁟
#0001 306.  𓁠  𓁡  𓁢  𓁣  𓁤  𓁥  𓁦  𓁧  𓁨  𓁩  𓁪  𓁫  𓁬  𓁭  𓁮  𓁯
#0001 307.  𓁰  𓁱  𓁲  𓁳  𓁴  𓁵  𓁶  𓁷  𓁸  𓁹  𓁺  𓁻  𓁼  𓁽  𓁾  𓁿
#0001 308.  𓂀  𓂁  𓂂  𓂃  𓂄  𓂅  𓂆  𓂇  𓂈  𓂉  𓂊  𓂋  𓂌  𓂍  𓂎  𓂏
#0001 309.  𓂐  𓂑  𓂒  𓂓  𓂔  𓂕  𓂖  𓂗  𓂘  𓂙  𓂚  𓂛  𓂜  𓂝  𓂞  𓂟
#0001 30A.  𓂠  𓂡  𓂢  𓂣  𓂤  𓂥  𓂦  𓂧  𓂨  𓂩  𓂪  𓂫  𓂬  𓂭  𓂮  𓂯
#0001 30B.  𓂰  𓂱  𓂲  𓂳  𓂴  𓂵  𓂶  𓂷  𓂸  𓂹  𓂺  𓂻  𓂼  𓂽  𓂾  𓂿

#0001 D10.  𝄀  𝄁  𝄂  𝄃  𝄄  𝄅  𝄆  𝄇  𝄈  𝄉  𝄊  𝄋  𝄌  𝄍  𝄎  𝄏
#0001 D11.  𝄐  𝄑  𝄒  𝄓  𝄔  𝄕  𝄖  𝄗  𝄘  𝄙  𝄚  𝄛  𝄜  𝄝  𝄞  𝄟
#0001 D12.  𝄠  𝄡  𝄢  𝄣  𝄤  𝄥  𝄦 𝄧 𝄨  𝄩  𝄪  𝄫  𝄬  𝄭  𝄮  𝄯
#0001 D13.  𝄰  𝄱  𝄲  𝄳  𝄴  𝄵  𝄶  𝄷  𝄸  𝄹  𝄺  𝄻  𝄼  𝄽  𝄾  𝄿
#0001 D14.  𝅀  𝅁  𝅂  𝅃  𝅄  𝅅  𝅆  𝅇  𝅈  𝅉  𝅊  𝅋  𝅌  𝅍  𝅎  𝅏
#0001 D15.  𝅐  𝅑  𝅒  𝅓  𝅔  𝅕  𝅖  𝅗  𝅘  𝅙  𝅚  𝅛  𝅜  𝅝  𝅗𝅥  𝅘𝅥
#0001 D16.  𝅘𝅥𝅮  𝅘𝅥𝅯  𝅘𝅥𝅰  𝅘𝅥𝅱  𝅘𝅥𝅲   𝅥   𝅦   𝅧   𝅨   𝅩  𝅪  𝅫  𝅬   𝅭   𝅮   𝅯
#0001 D17.   𝅰   𝅱   𝅲  𝅳  𝅴  𝅵  𝅶  𝅷  𝅸  𝅹  𝅺   𝅻   𝅼   𝅽   𝅾   𝅿
#0001 D18.   𝆀   𝆁   𝆂  𝆃  𝆄   𝆅   𝆆   𝆇   𝆈   𝆉   𝆊   𝆋  𝆌  𝆍  𝆎  𝆏
#0001 D19.  𝆐  𝆑  𝆒  𝆓  𝆔  𝆕  𝆖  𝆗  𝆘  𝆙  𝆚  𝆛  𝆜  𝆝  𝆞  𝆟
#0001 D1A.  𝆠  𝆡  𝆢  𝆣  𝆤  𝆥  𝆦  𝆧  𝆨  𝆩   𝆪   𝆫   𝆬   𝆭  𝆮  𝆯
#0001 D1B.  𝆰  𝆱  𝆲  𝆳  𝆴  𝆵  𝆶  𝆷  𝆸  𝆹  𝆺  𝆹𝅥  𝆺𝅥  𝆹𝅥𝅮  𝆺𝅥𝅮  𝆹𝅥𝅯
#0001 D1C.  𝆺𝅥𝅯  𝇁  𝇂  𝇃  𝇄  𝇅  𝇆  𝇇  𝇈  𝇉  𝇊  𝇋  𝇌  𝇍  𝇎  𝇏
#0001 D1D.  𝇐  𝇑  𝇒  𝇓  𝇔  𝇕  𝇖  𝇗  𝇘  𝇙  𝇚  𝇛  𝇜  𝇝  𝇞  𝇟
#0001 D1E.  𝇠  𝇡  𝇢  𝇣  𝇤  𝇥  𝇦  𝇧  𝇨

# page 0001 F00 : game symbols (cards, domino, mahjongg e.t.c.)
# 🆎  🆏
#0001 F19.  🆐 🆑 🆒 🆓 🆔 🆕 🆖 🆗 🆘 🆙 🆚  🆛  🆜  🆝  🆞  🆟
 #0001 F1A.  🆠  🆡  🆢  🆣  🆤  🆥  🆦  🆧  🆨  🆩  🆪  🆫  🆬
# 🆓🆞🆬🆏
# Pages 0001F30...0001FC00 color icons.

