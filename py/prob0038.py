from multiprocessing import Process, Queue
import time
import sys

def worker(extractor, feeder):
	while True:
		if feeder.empty():
			return
		checkThis = feeder.get()
		store = list()
		assembled = ""
		length = 0
		for i in range(1,13):
			tmp = i * checkThis
			length += len(str(tmp))
			store += [ tmp ]
			if length >= 9:
				break
		if(length > 9):
			continue
		for i in store:
			assembled += str(i)

		if(is_pandig(assembled)):
			extractor.put([int(assembled), checkThis, len(store)])

def is_pandig(x):
	test = [ True, False, False, False, False, False, False, False, False, False, False ]
	if len(x) != 9:
		return False
	for i in x:
		if(test[int(i)]):
			return False
		else:
			test[int(i)] = True
	return True

if __name__ == '__main__':
	feeder = Queue()
	extractor = Queue()
	
	p = Process(target=worker, args=(extractor,feeder))
	q = Process(target=worker, args=(extractor,feeder))
	r = Process(target=worker, args=(extractor,feeder))
	s = Process(target=worker, args=(extractor,feeder))
	for i in range(1,10000):
		feeder.put(i)
	p.start()
	q.start()
	r.start()
	s.start()
	
	while( p.is_alive() or q.is_alive() or r.is_alive() or s.is_alive() ):
		if(not extractor.empty()):
			a, b, c = extractor.get(True, 3)
			print(" Solution:", a, b, c)
		else:
			sys.stdout.write(".")
			sys.stdout.flush()
			time.sleep(1)
