install.packages("GD")     
library(GD)                
#读取文件
inputdata <- read.csv("C:/Users/User/Desktop/det/testdata.csv", header = TRUE, sep = ",")  
head(inputdata)
#GD包里有提供五种监督离散化方法，这行代码对空间数据进行离散化处理
discmethod <- c("equal","natural","quantile","geometric","sd")   
#空间数据离散化分成3~7类，当然可以自己根据实际情况修改
discitv <- c(4:7)
#odc1 <- optidisc(Y~X1,data = inputdata,discmethod,discitv)#（Y~X1）指定X1变量
odc1 <- optidisc(Y~.,data = inputdata,discmethod,discitv)#(Y~.)表示所有变量
odc1
plot(odc1)

##-----因子探测-----##

#1、一个分类变量
g1 <- gd(Y~X1,data = inputdata)# 自变量X1对因变量Y的影响
g1
plot(g1)
#2、多个分类变量
g2 <- gd(Y~. ,data = inputdata[,1:3])#[,1:3]表示数据前3列，根据自身情况选取分类变量所在列数
g2
plot(g2)
#3、包括连续变量在内的多变量
discmethod <- c("equal","natural","quantile","geometric","sd")
discitv <- c(4:7)
data.ndvi <- inputdata
data.continuous <- data.ndvi[,c(1,2:7)]#提取连续性变量；1表示第1列的因变量Y，2:7表示自变量第2列到第7列
odc1 <- optidisc(Y~ ., data = data.continuous,discmethod, discitv)
data.continuous <- do.call(cbind, lapply(1:2, function(x)
data.frame(cut(data.continuous[, -1][, x], unique(odc1[[x]]$itv), include.lowest = TRUE))))
data.ndvi[, 2:7] <- data.continuous
g3 <- gd(Y ~ ., data = data.ndvi)
g3
plot(g3)

##-----风险探测-----##

#1、一个分类变量
rm1 <- riskmean(Y ~ X1+X2, data = data.ndvi)# 自变量X1对因变量Y的影响
rm1
plot(rm1)
#2、多个分类变量
rm2 <- riskmean(Y~. ,data = data.ndvi)
rm2
plot(rm2)
#3、包括连续变量在内的多变量
gr1 <- gdrisk(Y~X1+X2,data = data.ndvi)#显示矩阵
gr1
plot(gr1)

gr2 <- gdrisk(Y~., data = data.ndvi)
gr2
plot(gr2)

##-----交互探测-----##

# categorical explanatory variables
gi1 <- gdinteract(Y ~ X1+X2, data = data.ndvi)
gi1
plot(gi1)
# multiple variables inclusing continuous variables
gi2 <- gdinteract(Y~. , data = data.ndvi)
gi2
plot(gi2)

##-----生态探测-----##

# categorical explanatory variables
ge1 <- gdeco(Y ~ X1 + X2, data = data.ndvi)
ge1
# multiple variables inclusing continuous variables
gd3 <- gdeco(Y~., data = data.ndvi)
gd3
plot(gd3)

##-----空间尺度影响分析-----##

ndvilist <- list(ndvi_20, ndvi_30, ndvi_40, ndvi_50)
su <- c(20,30,40,50) ## sizes of spatial units
## "gdm" function
gdlist <- lapply(ndvilist, function(x){
  gdm(NDVIchange ~ Climatezone + Mining + Tempchange + GDP, 
      continuous_variable = c("Tempchange", "GDP"),
      data = x, discmethod = "quantile", discitv = 6)
})
sesu(gdlist, su) ## size effects of spatial units
discmethod <- c("equal","natural","quantile")
discitv <- c(4:6)


##-----一次完成四个探测-----##

#"gdm"function
# 假如X1\X2 是分类变量（如气候区、土地利用、）
# 假如X3\X4 是连续变量（如气温、降水、蒸发、GDP）
ndvigdm <- gdm(Y~X1 + X2 + X3 + X4 + X5 + X6,
               continuous_variable = c("X1","X2","X3","X4","X5","X6"), ##选取连续变量
               data = inputdata,
               discmethod = discmethod,discitv = discitv)
ndvigdm
plot(ndvigdm)




