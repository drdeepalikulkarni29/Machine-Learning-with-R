san<-read.csv("file:///E:/D Drive/R Console_class/santander-value-prediction-challenge/train.csv")
val<- read.csv("E:/D Drive/R Console_class/santander-value-prediction-challenge/test.csv",stringsAsFactors = F)


san <- san[,c(2,1,3:ncol(san))]
colSums(is.na(san))
table(is.na(san))

library(caret)



library(h2o)
h2o.init()
train.hex <- as.h2o(san)
valid.hex <- as.h2o(val)

model.h2o.rf <- h2o.automl(y=1, x=2:4992, 
                           training_frame = train.hex, 
                           stopping_metric = "RMSLE")

pred.RF <- h2o.predict(model.h2o.rf,newdata = valid.hex)
pred.RF<- as.data.frame(pred.RF)

#h2o.shutdown()

pred.RF$predict<- ifelse(pred.RF$predict<0,0,pred.RF$predict)
sub<- data.frame(ID = val$ID,target=pred.RF$predict,stringsAsFactors=F)

write.csv(sub,"E:/D Drive/R Console_class/santander-value-prediction-challenge/DeepaliK_sub2.csv",row.names = F)
