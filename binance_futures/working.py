import time
from binance.um_futures import UMFutures
um_futures_client = UMFutures()
max_pr = '0'
max_tm = '0'
cur_pr= '0'
prev_pr = '0'
val_d = {}
val_d[max_pr] = max_tm
time_ctf = 3.6e6
while(True):
    #print(sorted(val_d.items()))
    prev_pr = cur_pr
    cur_tm = um_futures_client.time()['serverTime']
    cur_pr = um_futures_client.ticker_price("XRPUSDT")['price']
    if (int(cur_tm)-int(max_tm) > time_ctf):
        val_d.pop(max_pr, None)
        for entry in sorted(val_d.items(), reverse=True):
            if (int(cur_tm)-int(entry[1]) > time_ctf):
                val_d.pop(entry[0], None)
            else:
                max_pr = entry[0]
                max_tm = entry[1]
                break
    val_d[cur_pr]= cur_tm
    if cur_pr >= max_pr:
        max_pr = cur_pr
        max_tm = cur_tm
    elif (float(cur_pr) <= 0.99*float(max_pr)) and (cur_pr != prev_pr):
        print("Максимальная цена за последний час: ", max_pr, "; цена на данный момент: ", cur_pr, "; падение на ", round((float(max_pr)-float(cur_pr))/float(max_pr), 5)*100, "%")
    time.sleep(100/1000)
