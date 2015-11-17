print
import os




"""['t_bd_1', "Trial", {html: '<audio autoplay="autoplay"><source src="https://udrive.oit.umass.edu/kmullin/_exp/CV_bdaa_01_w_p.wav" type="audio/wav"><source src="https://udrive.oit.umass.edu/kmullin/_exp/CV_bdaa_01_w_p.mp3" type="audio/mpeg"></audio>', hideProgressBar: true}],"""

"""['t_bd_
1
', "Trial", {html: '<audio autoplay="autoplay">
<source src="https://udrive.oit.umass.edu/kmullin/_exp/iu_
01
.wav" type="audio/wav">
<source src="https://udrive.oit.umass.edu/kmullin/_exp/iu_
01
.mp3" type="audio/mpeg"></audio>', hideProgressBar: true}],"""

dontwork = """Your browser does not support the audio element."""


filename = 'stimList.txt'
ff = open(filename, 'w', 0)

numList1 = ('l', 'r')
numList2 = (1, 4, 6, 7, 8, 10, 14, 17)

##for i in range(1, 18):
for i in numList1:
    for j in numList2:
        sourcewav = """<source src="https://udrive.oit.umass.edu/kmullin/_exp/bd%saa_%02d.wav" type="audio/wav">""" % (i, j)
        sourcemp = """<source src="https://udrive.oit.umass.edu/kmullin/_exp/bd%saa_%02d.mp3" type="audio/mpeg">""" % (i, j)
        string = """['t_bd_%s_%d', "Trial", {html: '<audio autoplay="autoplay"> %s %s %s</audio>', hideProgressBar: true}]""" % (i, j, sourcewav, sourcemp, dontwork)
        ff.write(string)
        ff.write(',\n')
        ff.flush()
        os.fsync(ff.fileno())

ff.write('\n')


numList1 = ('l', 'r')
numList2 = (1, 17)

for i in numList1:
    if i == 'l':
        c2 = 'L'
    else:
        c2 = 'R'
    for j in numList2:
        if j == 1:
            c1 = 'B'
        else:
            c1 = 'D'
        sourcewav = """<source src="https://udrive.oit.umass.edu/kmullin/_exp/bd%saa_%02d.wav" type="audio/wav">""" % (i, j)
        sourcemp = """<source src="https://udrive.oit.umass.edu/kmullin/_exp/bd%saa_%02d.mp3" type="audio/mpeg">""" % (i, j)
        string = """['pto_bd_%s_%d', "Trial", {html: '<audio autoplay="autoplay"> %s %s %s </audio>', q: "&nbsp;&nbsp;&nbsp;&nbsp;click on the sound", hasCorrect: false, timeout: 4000, hideProgressBar: true}, "Separator", 130, "Message", {html: "<div style='text-align: center;'> answer: </div><div style='text-align: center; font-size: 150%s; margin-top: 12pt;'> %s %s </div>", transfer: 1500}]""" % (i, j, sourcewav, sourcemp, dontwork, '%', c1, c2)
        ff.write(string)
        ff.write(',\n')
        ff.flush()
        os.fsync(ff.fileno())

ff.write('\n')

for i in numList1:
    if i == 'l':
        c2 = 'L'
    else:
        c2 = 'R'
    for j in numList2:
        if j == 1:
            c1 = 'B'
        else:
            c1 = 'D'
        sourcewav = """<source src="https://udrive.oit.umass.edu/kmullin/_exp/bd%saa_%02d.wav" type="audio/wav">""" % (i, j)
        sourcemp = """<source src="https://udrive.oit.umass.edu/kmullin/_exp/bd%saa_%02d.mp3" type="audio/mpeg">""" % (i, j)
        string = """['pnt_bd_%s_%d', "Trial", {html: '<audio autoplay="autoplay"> %s %s %s </audio>', q: "&nbsp;&nbsp;&nbsp;&nbsp;click on the sound", hasCorrect: false, timeout: null, hideProgressBar: true}, "Separator", 150, "Message", {html: "<div style='text-align: center;'> answer: </div><div style='text-align: center; font-size: 150%s; margin-top: 12pt;'> %s %s </div>", transfer: 1900}]""" % (i, j, sourcewav, sourcemp, dontwork, '%', c1, c2)
        ff.write(string)
        ff.write(',\n')
        ff.flush()
        os.fsync(ff.fileno())

ff.write('\n')




ff.close()

print '\ndone!\n'
