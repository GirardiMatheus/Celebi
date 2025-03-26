<div align="center">
  <h1>
    <img src="https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/251.png" width="70" height="70" alt="Celebi" style="vertical-align: middle;">
    Celebi
  </h1>
  <p>Backup e Restauração Automatizados para PostgreSQL</p>
  
  <p>
    <img src="https://img.shields.io/badge/Shell_Script-100%25-brightgreen" alt="Shell">
    <img src="https://img.shields.io/badge/PostgreSQL-4169E1" alt="PostgreSQL">
    <img src="https://img.shields.io/badge/license-MIT-blue" alt="License">
  </p>
</div>

## Visão Geral

O Celebi é uma solução mágica para backup e restauração de bancos PostgreSQL, oferecendo:

- Backups compactados com timestamp
- Restauração pontual com um comando
- Transferência segura para servidores remotos
- Limpeza automática de backups antigos

## Funcionalidades Principais

**Backup Automatizado**  
- Exportação com `pg_dump` e compressão em `.tar.gz`  
- Nível de compressão configurável (1-9)  
- Nomenclatura inteligente com timestamp  

**Restauração Fácil**  
- Comando único para voltar no tempo  
- Compatível com backups locais ou remotos  
- Validação de integridade do backup  

**Gerenciamento Inteligente**  
- Retenção personalizável (dias)  
- Envio automático via SCP/SSH  
- Logs detalhados de todas as operações  

## ⚙️ Pré-requisitos

- PostgreSQL 10+
- Ferramentas básicas: `gzip`, `tar`, `scp`
- Permissões de leitura/escrita no diretório de backups
- Chave SSH configurada (para transferência remota)

## 🚀 Instalação Rápida

1. Clone o repositório:

```bash
git clone https://github.com/seu-usuario/pg_time_travel.git && cd pg_time_travel
```
2. Configure o ambiente:

```bash
cp .env.example .env
# Edite as variáveis do PostgreSQL e paths
nano .env
```

3. Torne os scripts executáveis:

```bash
chmod +x backup.sh restore.sh
```

## Como Usar

**Backup manual:**

```bash
./backup.sh
```

**Restauração:**

```bash
./restore.sh backups/backup_meubanco_20240326_143022.sql.gz
```

**Agendamento no cron (diário às 2AM):**

```
0 2 * * * /caminho/pg_time_travel/backup.sh
```

## Estrutura do Projeto

```bash
Celebi/
├── backup.sh              # Script de backup
├── .gitignore              # Padrão para projetos
├── restore.sh              # Script de restauração
├── .env.example        # Template de configuração
├── backups/               # Pasta de backups (criada automaticamente)
└── README.md      # Documentação
```

## Melhores Práticas

1. Configuração de retenção:

```bash
# No arquivo .env
RETENTION_DAYS=7       # Mantém backups por 7 dias
COMPRESS_LEVEL=6       # Balanceia velocidade/tamanho
```

2. Rotação segura de backups:

```bash
# Adicione ao /etc/logrotate.d/celebi
/pg_time_travel/backups/*.gz {
    monthly
    rotate 12
    compress
    missingok
    notifempty
}
```

## Contribuição

1. Faça um fork do projeto
2. Crie sua branch (git checkout -b feature/nova-magia)
3. Commit suas mudanças (git commit -am 'Add teletransporte de backups')
4. Push para a branch (git push origin feature/nova-magia)
5. Abra um Pull Request