#!/bin/bash
#====================================================
#	SCRIPT: BOT KH-VPN FREE SCRIPT
#	DEVELOPED BY:	LUNDY KUBTAPHAKON
#	CONTACT TELEGRAM:	http://t.me/dev_vpn
#	FACEBOOK:	@FREENETVPNDTAC
#====================================================
clear
fun_bar() {
    comando[0]="$1"
    comando[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${comando[0]} -y >/dev/null 2>&1
        ${comando[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "\033[1;33m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[1;31m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[1;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "\033[1;33m["
    done
    echo -e "\033[1;33m]\033[1;37m -\033[1;32m สำเร็จ !\033[1;37m"
    tput cnorm
}

fun_botOnOff() {
    [[ $(ps x | grep "bot_plus" | grep -v grep | wc -l) = '0' ]] && {
        clear
        echo -e "\E[44;1;37m             โปรแกรมติดตั้งบอท KH-VPN                \E[0m\n"
        echo -ne "\033[1;32mแจ้งโทเค็นของคุณ:\033[1;37m "
        read tokenbot
        echo ""
        echo -ne "\033[1;32mแจ้ง ID ของคุณ:\033[1;37m "
        read iduser
        clear
        echo -e "\033[1;32mการเริ่มต้นบอท KH-VPN \033[0m\n"
        fun_bot1() {
            [[ ! -e "/etc/SSHPlus/ShellBot.sh" ]] && wget -qO- https://raw.githubusercontent.com/shellscriptx/shellbot/master/ShellBot.sh >/etc/SSHPlus/ShellBot.sh
            cd /etc/SSHPlus
            screen -dmS bot_plus ./bot $tokenbot $iduser >/dev/null 2>&1
            [[ $(grep -wc "bot_plus" /etc/autostart) = '0' ]] && {
                echo -e "ps x | grep 'bot_plus' | grep -v 'grep' || cd /etc/SSHPlus && sudo screen -dmS bot_plus ./bot $tokenbot $iduser && cd $HOME" >>/etc/autostart
            } || {
                sed -i '/bot_plus/d' /etc/autostart
                echo -e "ps x | grep 'bot_plus' | grep -v 'grep' || cd /etc/SSHPlus && sudo screen -dmS bot_plus ./bot $tokenbot $iduser && cd $HOME" >>/etc/autostart
            }
            [[ $(crontab -l | grep -c "verifbot") = '0' ]] && (
                crontab -l 2>/dev/null
                echo "@daily /bin/verifbot"
            ) | crontab -
            cd $HOME
        }
        fun_bar 'fun_bot1'
        [[ $(ps x | grep "bot_plus" | grep -v grep | wc -l) != '0' ]] && echo -e "\n\033[1;32m BOT SSHPLUS ATIVADO !\033[0m" || echo -e "\n\033[1;31m ERRO! REANALISE SUAS INFORMACOES\033[0m"
        sleep 2
        menu
    } || {
        clear
        echo -e "\033[1;32mหยุดทำงานบอท... \033[0m\n"
        fun_bot2() {
            screen -r -S "bot_plus" -X quit
            screen -wipe 1>/dev/null 2>/dev/null
            [[ $(grep -wc "bot_plus" /etc/autostart) != '0' ]] && {
                sed -i '/bot_plus/d' /etc/autostart
            }
            [[ $(crontab -l | grep -c "verifbot") != '0' ]] && crontab -l | grep -v 'verifbot' | crontab -
            sleep 1
        }
        fun_bar 'fun_bot2'
        echo -e "\n\033[1;32m \033[1;31mบอทหยุดทำงาน! \033[0m"
        sleep 2
        menu
    }
}

fun_instbot() {
    echo -e "\E[44;1;37m             โปรแกรมติดตั้งบอท KH-VPN                \E[0m\n"
    echo -e "                 \033[1;33m[\033[1;31m!\033[1;33m] \033[1;31mคำเตื่อน \033[1;33m[\033[1;31m!\033[1;33m]\033[0m"
    echo -e "\n\033[1;32m1° \033[1;37m- \033[1;33mใช่เบอร์โทรศัพท์ของคุณ เข้าถึงบอทต่อไปนี้\033[1;37m:\033[0m"
    echo -e "\n\033[1;32m2° \033[1;37m- \033[1;33mBOT \033[1;37m@BotFather \033[1;33mสร้างบอทของคุณ \033[1;31mเลื่อก: \033[1;37m/newbot\033[0m"
    echo -e "\n\033[1;32m3° \033[1;37m- \033[1;33mBOT \033[1;37m@SSHPLUS_BOT \033[1;33mและรับ ID ของคุณ\033[1;31mเลื่อก: \033[1;37m/id\033[0m"
    echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[1;32m"
    echo ""
    read -p "คุณต้องการที่จะดำเนินการต่อ ? [y/n]: " -e -i s resposta
    [[ "$resposta" = 'y' ]] && {
        fun_botOnOff
    } || {
        echo -e "\n\033[1;31mกลับ...\033[0m"
        sleep 2
        menu
    }
}
[[ -f "/etc/SSHPlus/ShellBot.sh" ]] && fun_botOnOff || fun_instbot
#fim
