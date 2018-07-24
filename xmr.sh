#!/bin/bash

address=4HmoXnbeopf9V2TnSNrhjCdB9WT95a4nseV86vZKtqPoSxP5gnWjdLaAGnsNy3dXvwaq78t4MSA5GGWs9DQCN6vy7BEWGzFF55QHRgpxXu
for i in balance hashrate user balance_hashrate reportedhashrate workers payments paymentsday 
do
	curl -sSL https://api.nanopool.org/v1/xmr/$i/$address &
done;
