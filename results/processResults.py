print
import ast, os
from collections import Counter

filenameResult = 'results.txt'
filenameRaw    = 'raw_results.txt'

ff = open(filenameResult, 'rU')
results = [line.strip() for line in ff]
##results = [line.strip() for line in ff if not(line.startswith('#'))]
ff.close()

resultsMod = results[:]
for (i, val) in enumerate(results):
    if val.startswith('# Results on '):
        resultsMod[i] = "date," + val.lstrip('# Results on ').rstrip('.')
    if val.startswith('# USER AGENT: '):
        resultsMod[i] = "machine," + val.lstrip('# USER AGENT: ').replace(',', ';')
results = [x.split(',') for x in resultsMod if not(x.startswith('#'))]

for x in results[:11]:
    print x

print 'asdf'

for (i, val) in enumerate(results[:]):
    if val[0] == 'date':
        newval = [results[i+2][0], results[i+2][1], val[0], val[1]]
        results[i] = newval
    elif val[0] == 'machine':
        newval = [results[i+2][0], results[i+1][1], val[0], val[1]]
        results[i] = newval
    else:
        newval = val[:4] + val[5:6] + val[7:]
        results[i] = newval

##for x in results:
##    print x


buttonorder = dict( [(x[1]+x[0], x[-4][:-4]) for x in results if x[2]=='Form' and x[4]=='intro' and x[5]=='consentanswer'] )
lang = dict([(x[1]+x[0], x[-1]) for x in results if x[2]=='Form' and x[4]=='questionnaire' and x[5]=='write_something'])
langB = dict([(x[1]+x[0], x[-1]) for x in results if x[2]=='Form' and x[4]=='questionnaire' and x[5]=='NatLang'])
disorder = dict([(x[1]+x[0], x[-1]) for x in results if x[2]=='Form' and x[4]=='questionnaire' and x[5]=='disorder'])
date = dict([(x[1]+x[0], x[-1]) for x in results if x[2]=='date'])
machine = dict([(x[1]+x[0], x[-1]) for x in results if x[2]=='machine'])
headyesno = dict([(x[1]+x[0], x[-1]) for x in results if x[2]=='Form' and x[4]=='headphones' and x[5]=='headphoneyesno'])
headph = dict([(x[1]+x[0], x[-1]) for x in results if x[2]=='Form' and x[4]=='headphones' and x[5]=='headphonebrand'])
headphB = dict([(x[1]+x[0], x[-1]) for x in results if x[2]=='Form' and x[4]=='headphones' and x[5]=='headphonemodel'])
ids   = dict([(x[1]+x[0], (x[1], x[6])) for x in results if x[2]=='Form' and x[4]=='exit2' and x[5]=='worker_id'])
identifers = dict([(x[1]+x[0], x[6]) for x in results if x[2]=='Form' and x[4]=='exit2' and x[5]=='identifier'])
rands = dict([(x[1]+x[0], x[6]) for x in results if x[2]=='Form' and x[4]=='exit2' and x[5]=='randomfield'])
comments = dict([(x[1]+x[0], x[6]) for x in results if x[2]=='Form' and x[4]=='debrief' and x[5]=='comments'])

idstest = [(x[1]+x[0], (x[1], x[6])) for x in results if x[2]=='Form' and x[4]=='exit2' and x[5]=='worker_id']
print len(ids)
print len(idstest)

for x in ids:
    ## IPhash, workerID, indentifier, random, date, headphone?, brand, model, browser, native, lang, button, disorder, comments
    ids[x] = (ids[x][0], ids[x][1], identifers[x], rands[x], date[x], headyesno[x], headph[x], headphB[x], machine[x], langB[x], lang[x], buttonorder[x], disorder[x], comments[x])



allip = [ids[x][0] for x in ids]
dups = [k for (k, v) in Counter(allip).iteritems() if v > 1]
print dups

allworkerid = [ids[x][1] for x in ids]
dups = [k for (k, v) in Counter(allworkerid).iteritems() if v > 1]
print dups

allidentifier = [ids[x][2] for x in ids]
dups = [k for (k, v) in Counter(allidentifier).iteritems() if v > 1]
print dups


ff = open('userdata.csv', 'w', 0)
for key in ids:
    writeline = ','.join(ids[key])
    ff.write(writeline)
    ff.write('\n')
    ff.flush()
    os.fsync(ff.fileno())
ff.close()


for (i, val) in enumerate(results[:]):
    if val[2] == 'Trial':
        trialtype = val[4][0]
        key = val[1] + val[0]
        stimnum = val[4].split('_')[-1]
        stimnumC = val[4].split('_')[-2]
        val.insert(4, trialtype)
        val.insert(5, stimnum)
        val.insert(6, stimnumC)
        ##print val
        ## workerID + (timestamp + hash                                                      RT         disorder         lang            headphone
        newvalx = [ids[key][1].strip()] + val[:8] + val[9:10] + [val[9][0]] + [val[9][-1]] + val[-1:] + [ids[key][-2]] + [ids[key][9]] + [ids[key][5]]
        ##print newvalx
        results[i] = newvalx

##for x in results:
##    print x


results = [x for x in results if x[3] == 'Trial']


ff = open('trialdata.txt', 'w', 0)
for line in results:
    writeline = '\t'.join(line)
    ff.write(writeline)
    ff.write('\n')
    ff.flush()
    os.fsync(ff.fileno())
ff.close()
    




print
