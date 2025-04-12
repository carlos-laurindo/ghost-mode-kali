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

ghost-mode-kali/ 
├── ghost-mode.sh # Script principal 
├── ghost-mode.ovpn # Configuração OpenVPN (exemplo) 
├── torrc # Configuração personalizada do Tor 
├── proxychains4.conf # Configuração personalizada do Proxychains 
  └── README.md # Esta documentação

## Instalação e Uso


1. **Clone ou baixe o repositório:**

   ```bash
   git clone https://github.com/karlos/ghost-mode-kali.git
   cd ghost-mode-kali
Torne o script executável:
chmod +x ghost-mode.sh

Execute o script:
sudo ./ghost-mode.sh

O script exibirá um menu interativo com as seguintes opções:

Ativar Ghost Mode: Executa as funções de anonimato (MAC Spoof, random DNS, reinicia Tor, etc).

Restaurar Configurações Originais: Restaura as configurações de rede salvas em backup.

Instalar/Reinstalar Pacotes Necessários: Garante que todos os pacotes exigidos estejam instalados.

Sair: Encerra o script.

Modo Stealth (Opcional):

Para executar o script sem exibir a saída, utilize o parâmetro -s:

sudo ./ghost-mode.sh -s

Utilizando o Proxychains:

Após ativar o Ghost Mode, utilize o prefixo proxychains para executar comandos através da rede Tor. Por exemplo:


proxychains curl ifconfig.me
Backup e Restauração

O script faz backup automático dos arquivos de configuração originais (/etc/resolv.conf, /etc/tor/torrc, /etc/proxychains4.conf) na pasta config/backup.
Para restaurar as configurações, escolha a opção Restaurar Configurações Originais no menu.

Logs
Todas as ações são registradas em logs/ghost-mode.log. Consulte esse arquivo para detalhes de execução e troubleshooting.
Contribuições
Sinta-se à vontade para contribuir com melhorias, correções ou novas funcionalidades. Basta abrir uma issue ou enviar um pull request.
Aviso
Este projeto foi desenvolvido para fins educacionais e para ajudar na proteção de sua privacidade. Use-o com responsabilidade e ciente das leis locais.



