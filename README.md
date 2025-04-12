# ghost-mode-kali

# Ghost Mode for Kali Linux

**by karlos**

## Descrição

O **Ghost Mode** é um projeto desenvolvido para aumentar o anonimato em uma máquina Kali Linux, combinando:
- **MAC Spoofing:** Troca aleatória do endereço MAC.
- **Randomização de DNS:** Utilização de servidores DNS públicos aleatórios.
- **Tor + Proxychains:** Roteamento de tráfego através da rede Tor.
- **VPN (Opcional):** Possibilidade de utilizar uma conexão VPN com OpenVPN.
- **Interface Interativa:** Menu para ativação e restauração das configurações.
- **Backup/Restore:** Backup automático das configurações originais para fácil restauração.
- **Logs:** Registro detalhado das ações em `logs/ghost-mode.log`.
- **Modo Stealth:** Execução silenciosa com opção `-s`.

## Pré-requisitos

- Kali Linux (preferencialmente atualizado)
- Acesso root ou permissão de `sudo`
- Conexão com a Internet

Pacotes que serão instalados automaticamente:
- tor
- proxychains4
- openvpn
- macchanger
- resolvconf
- libnotify-bin
- netcat

## Estrutura do Projeto

