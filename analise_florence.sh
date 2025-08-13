#!/bin/bash

echo "===== ANÁLISE DE REDE ====="
echo "Relatório gerado em: $(date)"
echo ""

REPORT="florence_report.txt"
echo "===== RELATÓRIO DE ANÁLISE DE REDE =====" > $REPORT
echo "Data: $(date)" >> $REPORT
echo "Hostname: $(hostname)" >> $REPORT
echo "" >> $REPORT

echo "=== [1] PORTAS TCP/UDP EM ESCUTA (netstat -tulnp) ===" >> $REPORT
netstat -tulnp >> $REPORT
echo "" >> $REPORT

echo "=== [2] CONEXÕES ATIVAS (netstat -anp) ===" >> $REPORT
netstat -anp >> $REPORT
echo "" >> $REPORT

echo "=== [3] TABELA DE ROTEAMENTO (netstat -r) ===" >> $REPORT
netstat -r >> $REPORT
echo "" >> $REPORT

echo "=== [4] INTERFACES DE REDE (ip a) ===" >> $REPORT
ip a >> $REPORT
echo "" >> $REPORT

echo "=== [5] TESTE DE CONECTIVIDADE (ping -c 4 8.8.8.8) ===" >> $REPORT
ping -c 4 8.8.8.8 >> $REPORT
echo "" >> $REPORT

echo "=== [6] RESUMO DE TRÁFEGO (ss -s) ===" >> $REPORT
ss -s >> $REPORT
echo "" >> $REPORT

echo "Relatório salvo em: $REPORT"
echo "===== ANÁLISE DE REDE CONCLUÍDA ====="


REPORT="florence_forensic_report_$(date +%Y%m%d_%H%M%S).txt"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "===== RELATÓRIO FORENSE AVANÇADO - FLORENCE =====" > $REPORT
echo "Data da Análise: $TIMESTAMP" >> $REPORT
echo "Hostname: $(hostname)" >> $REPORT
echo "Sistema Operacional: $(uname -a)" >> $REPORT
echo "" >> $REPORT

echo "=== [1] MEMÓRIA, CACHES E ESTATÍSTICAS DO KERNEL ===" >> $REPORT

echo "---- Memória RAM e Swap (free -h) ----" >> $REPORT
free -h >> $REPORT
echo "" >> $REPORT

echo "---- Caches do Kernel (vmstat -s) ----" >> $REPORT
vmstat -s >> $REPORT
echo "" >> $REPORT

echo "---- Memória Compartilhada (ipcs) ----" >> $REPORT
ipcs >> $REPORT
echo "" >> $REPORT

echo "=== [2] REDES, ROTEAMENTO E TOPOLOGIA ===" >> $REPORT


echo "---- Tabela de Roteamento (ip route) ----" >> $REPORT
ip route >> $REPORT
echo "" >> $REPORT

echo "---- Cache ARP (ip neigh) ----" >> $REPORT
ip neigh >> $REPORT
echo "" >> $REPORT

echo "---- Conexões de Rede (ss -tulnp) ----" >> $REPORT
ss -tulnp >> $REPORT
echo "" >> $REPORT

echo "---- Topologia de Rede (lldpctl) ----" >> $REPORT
which lldpctl >/dev/null 2>&1 && lldpctl >> $REPORT || echo "LLDP não instalado" >> $REPORT
echo "" >> $REPORT

echo "=== [3] PROCESSOS E ESTATÍSTICAS DO KERNEL ===" >> $REPORT


echo "---- Processos Ativos (ps aux) ----" >> $REPORT
ps aux >> $REPORT
echo "" >> $REPORT


echo "---- Estatísticas do Kernel (dmesg) ----" >> $REPORT
dmesg | tail -n 50 >> $REPORT
echo "" >> $REPORT

echo "=== [4] SISTEMAS DE ARQUIVOS E DISPOSITIVOS ===" >> $REPORT

echo "---- Sistemas de Arquivos (df -h) ----" >> $REPORT
df -h >> $REPORT
echo "" >> $REPORT

echo "---- Conteúdo de /tmp (ls -la /tmp) ----" >> $REPORT
ls -la /tmp >> $REPORT
echo "" >> $REPORT


echo "---- Dispositivos de Armazenamento (lsblk) ----" >> $REPORT
lsblk >> $REPORT
echo "" >> $REPORT

echo "=== [5] MÍDIAS E BACKUPS ===" >> $REPORT

echo "---- Dispositivos USB (lsusb) ----" >> $REPORT
lsusb >> $REPORT
echo "" >> $REPORT

echo "---- Mídias Removíveis (mount | grep media) ----" >> $REPORT
mount | grep media >> $REPORT
echo "" >> $REPORT

echo "---- Backups Recentes (find /backup -type f -mtime -7) ----" >> $REPORT
find /backup -type f -mtime -7 2>/dev/null >> $REPORT || echo "Nenhum backup encontrado" >> $REPORT
echo "" >> $REPORT

echo "=== [6] LOGS E MONITORAMENTO ===" >> $REPORT

echo "---- Logs do Sistema (journalctl -n 50) ----" >> $REPORT
journalctl -n 50 >> $REPORT
echo "" >> $REPORT

echo "---- Logs de Autenticação (tail -n 50 /var/log/auth.log) ----" >> $REPORT
tail -n 50 /var/log/auth.log 2>/dev/null >> $REPORT || echo "Arquivo auth.log não encontrado" >> $REPORT
echo "" >> $REPORT

echo "Relatório completo salvo em: $REPORT"
echo "===== ANÁLISE FORENSE CONCLUÍDA =====" >> $REPORT