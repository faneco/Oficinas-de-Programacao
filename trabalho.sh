#!/bin/bash

echo"==============================="
MAQUINA=$(uname -a | cut -d ' ' -f2)
echo Relatorio da Maquina: $MAQUINA
DATA=$(date '%H:%M:%S -- %D/%M/%Y')
echo Data/Hora $DATA
echo"==============================="

ARQUIVO="NMAP.txt"

nmap -sP 192.168.9.82/24 > NMAP.txt

cat $ARQUIVO | grep "Nmap scan" | cut -d" " -f5 > IP.txt

cat $ARQUIVO | grep "mac" > MAC.txt

echo"---------------------------"
echo"---------Trabalho----------"
echo"---------------------------"

LINES=$(wc -l IP.txt | cut -d " " -f1)

for i in $(seq "1" "$LINES")
do
	IP=$(head -n${i} IP.txt | tail -n 1)
	MAC=$(head -n${i} MAC.txt | tail -n 1)
	ARQ=$(nmap -O $IP)

	echo "$IP" > Relatorio.txt
	echo "$MAC" >  Relatorio.txt
	echo "$ARQ" >  Relatorio.txt
done

ssmtp douglas_lima94@hotmail.com < Relatorio.txt
