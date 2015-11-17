# spread
# mode 

# porportion of d/b 



library(Hmisc)
library(lattice)
library(languageR)
library(lme4)

directory <- '/Volumes/SSD Part2/_userDataSSD2/Experiments/kmDissKM/ibexFarm/8_bdlaaraa_v3/results'

setwd(directory)


resultfile <- 'trialdata.txt'
columnlist <- c('workerID', 'timestamp', 'IPhash', 'trial', 'itemnum', 'trialtype', 'Vstep', 'C', 'stim', 'resp', 'respC1', 'respC2', 'RT', 'disorder', 'lang', 'headphones')
results <- read.delim(resultfile, header = FALSE, col.names = columnlist)

head(results)


length(unique(results$workerID))




# 

computerproblem <- c('AJY6J33X1KJNP', 'A24QSO0ZGQNMRF%0A')
results <- results[!(results $workerID %in% computerproblem), ]
results $workerID <- factor(results $workerID)





excluded <- results[(results$disorder != 'disorderno' | results$headphones != 'headphoneyes'), ]



# excluded <- results[(results$disorder != 'disorderno' | results$lang != 'eng' | results$headphones != 'headphoneyes'), ]


# results <- results[(results$disorder == 'disorderno' & results$lang == 'eng' & results$headphones == 'headphoneyes'), ]
results <- results[(results$disorder == 'disorderno' & results$headphones == 'headphoneyes'), ]

results $workerID <- factor(results $workerID)




subjs <- unique(results$workerID)
length(subjs)



results$dummy <- 1



results$RT <- results$RT - 0.03521492113328848 * 1000


results $resp
class(results $resp)





results $respNumC1 <- ifelse(results $respC1 == 'B', 0, 
                           ifelse(results $respC1 == 'D', 1, 5))
results $respNumC2 <- ifelse(results $respC2 == 'L', 0, 
                           ifelse(results $respC2 == 'R', 1, 5))





head(results)




duration <- NULL
for (s in subjs) {
	subj.results <- results[results$workerID == s, ]
	xtab <- xtabs( ~ stim, data = subj.results)
	print(s)
	howlong <- sum(subj.results$RT)/1000/30
	print(howlong)
	duration <- c(duration, howlong)
	# print( length(subj.results$resp) )
}
duration
summary(duration)







tfamily <- 'DTLArgoT'
tiles <- c(8, 10)




results$RT
summary(results$RT)





par(family = tfamily)
plot(results$RT, pch=16, cex=0.6)
plot(results$RT, typ='l')
hist(results$RT)
hist(results$RT, breaks='Scott')
hist(results$RT, breaks='FD')



####################
## practice
####################




plot(results$RT[results$trialtype == 'p'], pch=16, cex=0.6)
plot(results$RT[results$trialtype == 'p'], typ='l')


xtab <- xtabs( ~ resp, data = results[results$trialtype == 'p', ])
barplot(xtab)

summary(results$RT[results$trialtype == 'p'])


par(mfrow= tiles, mar=c(1.9, 2, 1, 0.5), cex=0.5, family = tfamily)
for (s in subjs) {
	s.result <- results[ results$workerID == s & results$trialtype == 'p', ]
	# plot(s.result$RT, main=s,typ='l', lwd='1.5', col='blue')
	plot(s.result$RT, main=s, ylim=c(0, max(results $RT)), typ='l', lwd='1.5', col='blue')
}


results <- results[results $trialtype == 't', ]


####################






# ## remove extreme slow (6289.3262076)
# results <- results[results $RT < 6288, ]
# results[results $RT > 6287, ]



par(family = tfamily)
plot(results$RT, pch=16, cex=0.5, col='darkblue')
plot(results$RT, typ='l', col='darkblue')


plot(sort(results$RT), pch=16, cex=0.6, col='darkblue')




par(family = tfamily)
xtab <- xtabs( ~ resp, data = results)
barplot(xtab)



summary(results$RT)



range(results$RT)
range(results$RT)*1.1


## RTs
par(mfrow= tiles, mar=c(1.9, 2, 2, 0.5), cex=0.4, family = tfamily)
for (s in subjs) {
	s.result <- results[ results$workerID == s, ]
	print(dim(s.result)[1])
	plot(s.result$RT, main=s, ylim=c(-200, 7700), typ='l', col='darkblue')
}



head(s.result)



# C1
par(mfrow= tiles, mar=c(1.9, 2, 2, 0.5), cex=0.5, family = tfamily)
for (s in subjs) {
	s.result <- results[ results$workerID == s, ]
	xtab <- xtabs( ~ respC1, data = s.result)
	barplot(xtab, ylim=c(0, 100), main=s)
	print(xtab)
}



# C2
par(mfrow= tiles, mar=c(1.9, 2, 2, 0.5), cex=0.5, family = tfamily)
for (s in subjs) {
	s.result <- results[ results$workerID == s, ]
	xtab <- xtabs( ~ respC2, data = s.result)
	barplot(xtab, ylim=c(0, 100), main=s)
	print(xtab)
}







percentNoResp <- NULL
par(mfrow= tiles, mar=c(1.9, 2, 2, 0.5), cex=0.5, family = tfamily)
for (s in subjs) {
	s.result <- results[ results$workerID == s, ]
	xtab <- xtabs( ~ resp, data = s.result)
	barplot(xtab, ylim=c(0, 100), main=s)
	# print(xtab)
	noResp <- xtab['NULL'] / sum(xtab) * 100
	percentNoResp <- c(percentNoResp, noResp)
	print(s)
	print(noResp)
}



## percent no response
par(mar=c(5, 11, 21, 1), family = tfamily, cex=0.45)
barplot(percentNoResp, names.arg=subjs, ylim=c(0, 55), las=2, space=0.2, legend.text=FALSE, horiz = TRUE, las=1)
# abline(mean(percentNoResp), 0, col='red')
# abline(median(percentNoResp), 0, col='blue')



## all responses
par(mar=c(8, 6, 2, 1), family = tfamily, cex=0.4)
xtab <- xtabs( ~ resp + workerID, data = results)
barplot(xtab, las=2, space=0.2, legend.text=TRUE)



#############################################
## remove folks who didnt respond
#############################################



alotoftimeouts <- c('A194KANUT0CSBV')


resultsGood <- results[!(results $workerID %in% alotoftimeouts), ]
resultsGood $workerID <- factor(resultsGood $workerID)
subjsGood   <- unique(resultsGood $workerID)







#############################################
## exclude no response
#############################################



resultsNoResponse <- resultsGood[resultsGood$resp == 'NULL', ]
dim(resultsNoResponse)



resultsRespGood <- resultsGood[resultsGood$resp != 'NULL', ]
resultsRespGood $resp <- factor(resultsRespGood $resp)
dim(resultsRespGood)



summary(resultsRespGood $RT)


par(family = tfamily)
plot(resultsRespGood $RT, pch=16, cex=0.1)
abline(225, 0, col='blue')
center <- mean(resultsRespGood $RT) * 0.5 + median(resultsRespGood $RT) * 0.5
abline(center, 0, col='red', lwd=2)
abline(3700, 0, col='black')
points(resultsRespGood $RT, pch=16, cex=0.5)

plot(resultsRespGood $RT, typ='l')


hist(resultsRespGood $RT)
hist(resultsRespGood $RT, breaks='Scott')
# hist(resultsRespGood $RT, breaks='FD')


borders <- c(2, 2, 1.2, 1)
text.size <- 0.4
par(mfrow=tiles, mar=borders, cex=text.size, family=tfamily)
for (s in subjsGood) {
	s.result <- resultsRespGood[ resultsRespGood $workerID == s, ]
	plot(s.result$RT, main=s, ylim=c(0, 4000), pch=16, cex=0.2)
	points(s.result$RT, pch=16, cex=0.8)
	center <- mean(s.result$RT) * 0.5 + median(s.result$RT) * 0.5
	abline(225, 0, col='blue')
	abline(center, 0, col='red', lwd=2)
	print(s)
	print(center)
}







toofast <- c('A2DZ3OFTXRZVNY', 'A3HZ31VAGTVQMQ', 'ACIHCWKHNFC7U')


resultsRespGood <- resultsRespGood[!(resultsRespGood $workerID %in% toofast), ]
resultsRespGood $workerID <- factor(resultsRespGood $workerID)
subjsGood   <- unique(resultsRespGood $workerID)





#############################################
## exclude faster than 200ms & practice items
#############################################



responses <- resultsRespGood[resultsRespGood$RT > 300, ]
responses$RTlog <- log(responses$RT)






summary(responses $RT)
summary(responses $RTlog)


par(family = tfamily)
plot(responses $RTlog, pch=16, cex=0.4)
abline(log(225), 0, col='blue')
center <- mean(responses $RTlog) * 0.5 + median(responses $RTlog) * 0.5
abline(center, 0, col='red', lwd=2)


plot(responses $RTlog, typ='l')



hist(responses $RT)
hist(responses $RT, breaks='Scott')
# hist(responses $RT, breaks='FD')


hist(responses $RTlog)
hist(responses $RTlog, breaks='Scott')
# hist(responses $RTlog, breaks='FD')

# hist(responses $RTlog, breaks=seq(from=5, to=8, by=1/6), xlim=c(5,8))





par(mfrow=tiles, mar=borders, cex=text.size, family=tfamily)
for (s in subjsGood) {
	s.result <- responses[ responses $workerID == s, ]
	plot(s.result$RTlog, main=s, ylim=c(5, 8.5), pch=16, cex=0.5)
	# plot(s.result$RTlog, main=s, xlim=c(0, 212), ylim=c(4, 7.9), typ='l')
	abline(log(225), 0, col='blue')
	center <- mean(s.result$RTlog) * 0.5 + median(s.result$RTlog) * 0.5
	abline(center, 0, col='red', lwd=2)
	print(dim(s.result))
}






# borders <- c(, 2.4, 2, 2.3)


par(mfrow= tiles, mar= borders, cex= text.size, family = tfamily)
for (s in subjsGood) {
	s.result <- responses[ responses $workerID == s, ]
	xtab <- xtabs( ~ resp, data = s.result)
	barplot(xtab, ylim=c(0, 100), main=s)
	print(xtab)
}





#############################################
## ID function
#############################################




head(responses)




xlabel <- '1 [b] – [d] 17'
ylabel <- 'prop. ‘d’ resp.'
xlabelc <- '1 [b] – [d] 17'
ylabelc <- 'prop. ‘d’ resp.'


borders <- c(4.1,4.3,1.5,0.4)

responses $dummy <- 1

length(responses $respNumC1)
length(responses $respNumC2)
length(responses $dummy)


par(mfrow=c(1,1), mar= borders, cex.lab=1.2, cex.axis=1.1, family = tfamily)
interaction.plot(responses$Vstep, responses $dummy, responses $respNumC1, xlab=xlabel, ylab=ylabel, legend=FALSE, ylim=c(0, 1), main='pooled', lwd=2.3)
vm   <- tapply(responses $respNumC1, responses $Vstep, mean)
vsd  <- tapply(responses $respNumC1, responses $Vstep, sd)
vsem <- vsd / sqrt( length(subjsGood) ) ##* 1.96
errbar( c(1:length(vm)), vm, vm + vsem, vm - vsem, add=TRUE, pch="")


borders <- c(4, 4, 1.2, 0.3)
text.size <- 0.35
par(mfrow= tiles, mar= borders, cex= text.size, family = tfamily)
for (s in subjsGood) {
	s.result <- responses[ responses $workerID == s, ]
	ccol <- 'darkblue'
	interaction.plot(s.result $Vstep, s.result $dummy, s.result $respNumC1, xlab=xlabel, ylab=ylabel, legend=FALSE, ylim=c(0, 1), main=s, lwd=2, col= ccol)
}







#############################################
## % correct
#############################################


head(responses)

sort(unique(responses$Vstep ))


endpoints <- responses[responses$Vstep == 1 | responses$Vstep == 17, ]
endpoints$Vstep <- factor(endpoints$Vstep)

endpoints$respC1 <- factor(endpoints$respC1)
endpoints$respC2 <- factor(endpoints$respC2)



xtab <- xtabs( ~ respC1 + Vstep, data = endpoints)
xtab


subjCorrect <- NULL
subjWrong   <- NULL
par(mfrow= tiles, mar= borders, cex= text.size, family = tfamily)
for (s in subjsGood) {
	s.result <- endpoints[ endpoints $workerID == s, ]
	xtab <- xtabs( ~ respC1 + Vstep, data = s.result)
	totalb <- sum(xtab[ , 1])
	correctb <- xtab['B', 1] 
	totald <- sum(xtab[ , 2])
	correctd <- xtab['D', 2] 
	total          <- totalb + totald
	totalcorrect   <- correctb + correctd
	percentcorrect <- totalcorrect / total * 100
	percentcorrectb <- correctb / totalb * 100
	percentcorrectd <- correctd / totald * 100
	print(s)
	# print( percentcorrect )
	print( xtab )
	barplot( percentcorrect, ylim=c(0, 100), main=s)
	if (percentcorrectb > 70 & percentcorrectd > 70 ) {
		subjCorrect <- c(subjCorrect, s)
	} else {subjWrong <- c(subjWrong, s)}
}
length(subjCorrect)
length(subjWrong)




tiles <- c(7, 8)
borders <- c(4, 4, 1.2, 0.3)

text.size <- 0.35


## correct
par(mfrow= tiles, mar= borders, cex= text.size, family = tfamily)
for (s in subjCorrect) {
	s.result <- responses[ responses $workerID == s, ]
	ccol <- 'darkblue'
	interaction.plot(s.result $Vstep, s.result $dummy, s.result $respNumC1, xlab=xlabel, ylab=ylabel, legend=FALSE, ylim=c(0, 1), main=s, lwd=2, col= ccol)
}




## wrong
par(mfrow=c(5,4), mar= borders, cex= text.size, family = tfamily)
for (s in subjWrong) {
	s.result <- responses[ responses $workerID == s, ]
	ccol <- 'darkblue'
	interaction.plot(s.result $Vstep, s.result $dummy, s.result $respNumC1, xlab=xlabel, ylab=ylabel, legend=FALSE, ylim=c(0, 1), main=s, lwd=2, col= ccol)
}




# # 
# subjCorrectC <- NULL
# subjWrongC   <- NULL
# par(mfrow= tiles, mar= borders, cex= text.size, family = tfamily)
# for (s in subjsGood) {
	# s.result <- endpointsC[ endpointsC $workerID == s, ]
	# xtab <- xtabs( ~ respC + stepC, data = s.result)
	# totalb <- sum(xtab[ , 1])
	# correctb <- xtab['b', 1] 
	# totald <- sum(xtab[ , 2])
	# correctd <- xtab['d', 2] 
	# total          <- totalb + totald
	# totalcorrect   <- correctb + correctd
	# percentcorrect <- totalcorrect / total * 100
	# percentcorrectb <- correctb / totalb * 100
	# percentcorrectd <- correctd / totald * 100
	# print(s)
	# # print( percentcorrect )
	# print( xtab )
	# barplot( percentcorrect, ylim=c(0, 100), main=s)
	# if (percentcorrect > 60 ) {
		# subjCorrectC <- c(subjCorrectC, s)
	# } else {subjWrongC <- c(subjWrongC, s)}
# }
# length(subjCorrectC)
# length(subjWrongC)


# exclude <- c('A3RXKVAX8YR0PG', 'AMAJR2EM7UULU', 'A2CKW83ERUX07J%0A', 'A2H8GNSEVUJXYL', 'A1LQCO66YHYIWL', 'A7BZXH7N2PYJS%0A', 'AN9MVFWRCF2OP', 'A20R4YVUCYANP1', 'A34LSB0XMAP3GX', 'A11MBZUB0YC9V1', 'A194KANUT0CSBV', 'A2CEXG9VDKI9NP', 'ANUTOIB1QEHPL', 'A2KEI37CT963DP', 'A3MQS8KPUMZB9W', 'A2179VLITZ8QHP', 'A1X86WIBTLVIN8', 'A2GCD1N9LS12L3%0A', 'AUAN582MLI96N', 'A1WHIQV9IEOYM3%0A', 'A1HPWAYILGOWIY', 'A2FDT6IL8I108B', 'AOJF7CPZVK5U3%0A', 'A1QVNF19XSRSD7', 'ARJDVHP0ACZWM', 'A1ICZRR7BO5HLU', 'A1YQJGPW6E59Z8', 'A1QUNP6IYOQMZ5', 'A1YQPOF381ZJRW', 'A77K8W55MJEKX', 'A2YIRI5M1IGAFK%0A', 'A3P23EBC4IL0JF', 'AW0K78T4I2T72', 'A2JDK74P9AZ1RW', 'A1CCV4KRUU1O07', 'A4TE7LF9CEVGA', 'A1ZXA9517DY7BY', 'A27GH5ITK5BMF0', 'A1IFIK8J49WBER', 'A1E19M28UDXKYY', 'A1FOPAIHKTM45P', 'A2D50KS58QB1BN', 'A110QZ2NX4BHT0')


# responsesCorrect <- responses[!(responses$workerID %in% exclude), ]

# subjCorrectC <- unique(responsesCorrect$workerID)


# ## C correct
# par(mfrow=c(6,6), mar= borders, cex= text.size, family = tfamily)
# for (s in subjCorrectC) {
	# s.result <- responses[ responses $workerID == s, ]
	# ccol <- 'darkblue'
	# interaction.plot(s.result $stepC, s.result $dummy, s.result $respNumC, xlab=xlabelc, ylab=ylabelc, legend=FALSE, ylim=c(0, 1), main=s, lwd=2, col= ccol)
# }


# ## C wrong
# par(mfrow=c(6,7), mar= borders, cex= text.size, family = tfamily)
# for (s in subjWrongC) {
	# s.result <- responses[ responses $workerID == s, ]
	# ccol <- 'darkblue'
	# interaction.plot(s.result $stepC, s.result $dummy, s.result $respNumC, xlab=xlabelc, ylab=ylabelc, legend=FALSE, ylim=c(0, 1), main=s, lwd=2, col= ccol)
# }














responsesCorrect <- responses[(responses$workerID %in% subjCorrect), ]


borders <- c(4.1,4.3,1.5,0.4)
par(mfrow=c(1,1), mar= borders, cex.lab=1.2, cex.axis=1.1, family = tfamily)
interaction.plot(responsesCorrect $Vstep, responsesCorrect $dummy, responsesCorrect $respNumC1, xlab=xlabel, ylab=ylabel, legend=FALSE, ylim=c(0, 1), main='pooled', lwd=2.3)
vm   <- tapply(responsesCorrect $respNumC1, responsesCorrect $Vstep, mean)
vsd  <- tapply(responsesCorrect $respNumC1, responsesCorrect $Vstep, sd)
vsem <- vsd / sqrt( length(subjCorrect) ) ##* 1.96
errbar( c(1:length(vm)), vm, vm + vsem, vm - vsem, add=TRUE, pch="")








borders <- c(4.1,4.3,1.5,0.4)
par(mfrow=c(1,1), mar= borders, cex.lab=1.2, cex.axis=1.1, family = tfamily)
interaction.plot(responsesCorrect $Vstep, responsesCorrect $respC2, responsesCorrect $respNumC1, xlab=xlabel, ylab=ylabel, legend=TRUE, ylim=c(0, 1), main='pooled', lwd=2.3)


borders <- c(4.1,4.3,1.5,0.4)
par(mfrow=c(1,1), mar= borders, cex.lab=1.2, cex.axis=1.1, family = tfamily)
interaction.plot(responsesCorrect $respC2, responsesCorrect $Vstep, responsesCorrect $respNumC1, xlab=xlabel, ylab=ylabel, legend=TRUE, ylim=c(0, 1), main='pooled', lwd=2.3)








borders <- c(4.1,4.3,1.5,0.4)
par(mfrow=c(1,1), mar= borders, cex.lab=1.2, cex.axis=1.1, family = tfamily)
interaction.plot(responsesCorrect $Vstep, responsesCorrect $respC2, responsesCorrect $respNumC1, xlab=xlabel, ylab=ylabel, legend=TRUE, ylim=c(0, 1), main='pooled', lwd=2.3)





borders <- c(4.1,4.3,1.5,0.4)
par(mfrow=c(1,1), mar= borders, cex.lab=1.2, cex.axis=1.1, family = tfamily)
interaction.plot(responsesCorrect $Vstep, responsesCorrect $respC1, responsesCorrect $respNumC2, xlab=xlabel, ylab='% r', legend=TRUE, ylim=c(0, 1), main='pooled', lwd=2.3)


borders <- c(4.1,4.3,1.5,0.4)
par(mfrow=c(1,1), mar= borders, cex.lab=1.2, cex.axis=1.1, family = tfamily)
interaction.plot(responsesCorrect $Vstep, responsesCorrect $dummy, responsesCorrect $respNumC2, xlab=xlabel, ylab='% r', legend=TRUE, ylim=c(0, 1), main='pooled', lwd=2.3)




head(responsesCorrect)

responsesCorrect$respC1 <- factor(responsesCorrect$respC1)

subsetC <- responsesCorrect[responsesCorrect$C == 'r', ]
borders <- c(4.1,4.3,1.5,0.4)
par(mfrow=c(1,2), mar= borders, cex.lab=1.2, cex.axis=1.1, family = tfamily)
interaction.plot(subsetC $Vstep, subsetC $dummy, subsetC $respNumC2, xlab=xlabel, ylab='% r', legend=TRUE, ylim=c(0, 1), main='pooled', lwd=2.3)

subsetC <- responsesCorrect[responsesCorrect$C == 'r', ]
par(mfrow=c(1,2), mar= borders, cex.lab=1.2, cex.axis=1.1, family = tfamily)
interaction.plot(subsetC $Vstep, subsetC $respC1, subsetC $respNumC2, xlab=xlabel, ylab='% r', legend=TRUE, ylim=c(0, 1), main='pooled', lwd=2.3)

subsetC <- responsesCorrect[responsesCorrect$C == 'r', ]
interaction.plot(subsetC $respC1, subsetC $respC2, subsetC $respNumC2, xlab=xlabel, ylab='% r', legend=TRUE, ylim=c(0, 1), main='pooled', lwd=2.3)



subsetC <- responsesCorrect[responsesCorrect$C == 'l', ]
par(mfrow=c(1,1), mar= borders, cex.lab=1.2, cex.axis=1.1, family = tfamily)
interaction.plot(subsetC $Vstep, subsetC $dummy, subsetC $respNumC2, xlab=xlabel, ylab='% r', legend=TRUE, ylim=c(0, 1), main='pooled', lwd=2.3)

## dot = b, dash =d 
subsetC <- responsesCorrect[responsesCorrect$C == 'l', ]
borders <- c(4.1,4.3,1.5,0.4)
interaction.plot(subsetC $Vstep, subsetC$respC1, subsetC $respNumC2, xlab=xlabel, ylab='% r', legend=TRUE, ylim=c(0, 1), main='pooled', lwd=2.3)


subsetC <- responsesCorrect[responsesCorrect$C == 'l', ]
interaction.plot(subsetC $respC1, subsetC $respC2, subsetC $respNumC2, xlab=xlabel, ylab='% r', legend=TRUE, ylim=c(0, 1), main='pooled', lwd=2.3)










for (s in unique(responsesCorrect$workerID)) {
	s.result <- responses[ responses $workerID == s, ]
	interaction.plot(s.result $Vstep, s.result $respC2, s.result $respNumC1, xlab=xlabel, ylab=ylabel, legend=TRUE, ylim=c(0, 1), main='pooled', lwd=2.3)
}








head(responsesCorrect)









#########################









unique(responsesCorrect$stepV)
mean(unique(responsesCorrect$stepV))


responsesCorrect$respNumCc <- ifelse(responsesCorrect$respNumC == 1, 1, -1)

responsesCorrect$stepVc <- responsesCorrect$stepV - mean(unique(responsesCorrect$stepV))
mean(responsesCorrect$stepVc )

responsesCorrect$stepCc <- responsesCorrect$stepC - mean(unique(responsesCorrect$stepC))
mean(responsesCorrect$stepCc )





vResp.stepC <- lmer(respNumV ~ stepVc + respNumCc + (1 + stepVc + respNumCc | workerID), family = "binomial", data = responsesCorrect )
	
summary(vResp)







