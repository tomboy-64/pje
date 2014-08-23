import	itertools
import	logging
import	multiprocessing
import	sys
import	time

def chain(x, Array):
	nxt, i = 0, 0
	this = x
	while True:
		print(x, Array)
		if Array[1] + 1 > time.time():
			print(time.time() - Array[1] , x, Array[0]);
			Array[1] = int(time.time() + 1)
		while this > 0:
			i = this % 10
			nxt += i*i
			this = this // 10
		if nxt == 1:
			return 0
		elif nxt == 89:
			Array[0] += 1
			return 1
		this = nxt
		nxt = 0

logger = multiprocessing.log_to_stderr()
logger.setLevel(logging.INFO)
myRunArray = multiprocessing.Array('i', [0, int(time.time())], lock=True)
pool = multiprocessing.Pool(processes=4)        # start 4 worker processes
pool.map(chain, (range(1, 10000000), myRunArray ))
