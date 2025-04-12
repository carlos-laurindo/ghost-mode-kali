#!/bin/bash
# ghost-mode.sh - Ghost Mode para Kali Linux
# by karlos

# -------------------------
# Variáveis de cores e log
green="\e[32m"
red="\e[31m"
end="\e[0m"
LOGFILE="./logs/ghost-mode.log"

# Função para logar eventos
log() {
    echo -e "$(date +"%Y-%m-%d %H:%M:%S") $1" | tee -a "$LOGFILE"
}

# Cria diretórios necessários se não existirem
mkdir -p logs config/backup

# Backup automático das configurações originais (se não existirem)
backup_config() {
    [ ! -f config/backup/resolv.conf.original ] && sudo cp /etc/resolv.conf config/backup/resolv.conf.original
    [ ! -f config/backup/torrc.original ] && sudo cp /etc/tor/torrc config/backup/torrc.original
    [ ! -f config/backup/proxychains4.conf.original ] && sudo cp /etc/proxychains4.conf config/backup/proxychains4.conf.original
    log "[*] Backups realizados com sucesso."
}

# Restaurar configurações originais
restore_config() {
    sudo cp config/backup/resolv.conf.original /etc/resolv.conf
    sudo cp config/backup/torrc.original /etc/tor/torrc
    sudo cp config/backup/proxychains4.conf.original /etc/proxychains4.conf
    log "[*] Configurações restauradas."
}

# Função para exibir o banner
banner() {
    clear
    echo -e "${green}"
    echo "███████╗ ██████╗  ██████╗ ███████╗████████╗"
    echo "██╔════╝██╔═══██╗██╔════╝ ██╔════╝╚══██╔══╝"
    echo "█████╗  ██║   ██║██║  ███╗█████╗     ██║   "
    echo "██╔══╝  ██║   ██║██║   ██║██╔══╝     ██║   "
    echo "██║     ╚██████╔╝╚██████╔╝███████╗   ██║   "
    echo "╚═╝      ╚═════╝  ╚═════╝ ╚══════╝   ╚═╝   "
    echo -e "${end}"
    echo -e "${green}Ghost Mode - Anonimato Total para Kali Linux${end}"
    echo -e "by karlos\n"
}

# Função para auto-instalar os pacotes necessários
install_packages() {
    log "[*] Atualizando repositórios e instalando pacotes necessários..."
    sudo apt update && sudo apt install -y tor proxychains4 openvpn macchanger resolvconf libnotify-bin netcat
    log "[*] Instalação concluída."
}

# Função para randomizar o MAC Address
randomize_mac() {
    iface="$1"
    log "[*] Alterando MAC Address da interface $iface..."
    sudo ifconfig "$iface" down
    sudo macchanger -r "$iface"
    sudo ifconfig "$iface" up
    log "[*] Novo MAC: $(macchanger -s "$iface" | grep "Current")"
}

# Função para randomizar o DNS (definindo DNS públicos aleatórios)
randomize_dns() {
    log "[*] Configurando DNS aleatórios..."
    # Exemplo com três servidores DNS públicos
    sudo sh -c 'echo -e "nameserver 1.1.1.1\nnameserver 8.8.8.8\nnameserver 9.9.9.9" > /etc/resolv.conf'
    log "[*] DNS configurados."
}

# Função para configurar e reiniciar o Tor
setup_tor() {
    log "[*] Reiniciando o serviço Tor..."
    sudo systemctl restart tor
    # Sinal para trocar o circuito e obter um novo IP
    echo -e "AUTHENTICATE \"\"\nSIGNAL NEWNYM\nQUIT" | nc 127.0.0.1 9051
    log "[*] Tor configurado e novo circuito solicitado."
}

# Função para exibir o menu interativo
menu() {
    echo -e "\nSelecione uma opção:"
    echo "1) Ativar Ghost Mode"
    echo "2) Restaurar Configurações Originais"
    echo "3) Instalar/Reinstalar Pacotes Necessários"
    echo "4) Sair"
    echo -n "Opção: "
    read opcao
    case $opcao in
        1)
            activate_ghost_mode
            ;;
        2)
            restore_config
            ;;
        3)
            install_packages
            ;;
        4)
            log "[*] Saindo..."
            exit 0
            ;;
        *)
            echo -e "${red}Opção inválida!${end}"
            menu
            ;;
    esac
}

# Função principal para ativar o Ghost Mode
activate_ghost_mode() {
    banner
    backup_config
    # Solicita a interface (padrão wlan0 ou eth0)
    echo -n "Informe a interface de rede (ex: wlan0 ou eth0): "
    read iface
    [ -z "$iface" ] && iface="wlan0"
    
    log "[*] Iniciando Ghost Mode na interface: $iface"
    
    randomize_mac "$iface"
    randomize_dns
    setup_tor
    
    # Notificação visual
    notify-send "Ghost Mode" "Modo de anonimato ativado em $iface!"
    log "[*] Ghost Mode ativado com sucesso!"
    
    echo -e "\nPara executar comandos utilizando o Ghost Mode, use o prefixo:"
    echo -e "${green}proxychains comando${end}\n"
    echo "Exemplo: proxychains curl ifconfig.me"
}

# Modo Stealth (se o parâmetro -s for informado, reduz a saída)
stealth_mode=false
if [ "$1" == "-s" ]; then
    stealth_mode=true
    exec 1>/dev/null 2>/dev/null
fi

# Execução inicial
banner
menu
