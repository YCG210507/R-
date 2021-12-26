####相关系数热图、矩阵图等绘制代码-2021.11.20
##为注释代码，如R包安装，参数说明等不需要的代码均使用#为注释，运行时不产生结果。

rm(list=ls())#清空工作变量

####一corrplot包
###流程
##1读取数据2计算相关系数3数据可视化4输出结果 
## 1.读取并了解数据
data(mtcars) ##读取数据，以默认r自带“mtcars”数据为展示
names(mtcars)##查看名称
head(mtcars)##查看数据
str(mtcars)##str函数即structure，紧凑的显示对象内部结构，即对象里有什么。
##例如：当我们head数据的时候，若某列内容太多，则不会显示出来，而用str函数，便可在窗口中逐行显示数据中列的内容。


####！！！最重要的一步-替换成自己数据
#data <-  read.csv("第二篇相关.csv",header = T)#加载数据，以csv格式加载。txt或者excel文件也可加载 
####data#查看数据
#head(data)
####友情提示！建议将data名称替换为本代码的res，以便后续不变更相关代码参数，减少工作量。


## 2.相关系数计算并查看系数值
#对成对数据进行相关性系数的计算和检验（多重≠多元），主要使用R语言中的cor.test()函数，其中有3种方法可供使用，分别是Spearman检验、Kendall检验和Pearson检验。
#（其他方法还包括Hmisc包中的rcorr， 以及psych包中的corr.test；SPSS也是不错的选择）
#而三种相关性检验技术中，Pearson相关性的精确度最高，但对原始数据的要求最高。Spearman等级相关和Kendall一致性相关的使用范围更广，但精确度较差。
#其中pearson相关适用于正态分布、连续变量或是等间距测度的数据；Spearman相关适用于不明分布、连续变量；Kendall相关适用于两个分类变量均为有序分类的情况；

####其调用格式cor(x,use=,method=)
##cor函数参数
# x表示矩阵或数据框
# use 指定缺失数据的处理方式。可选的方式为all.obs（假设不存在缺失数据——遇到缺失数据时将报错）、everything（遇到缺失数据时，相关系数的计算结果将被设为missing）、complete.obs（成对删除，pairwise deletion）
# method 指定相关系数的类型。可选类型为pearson、spearman或kendall

cor(mtcars, method = "spearman")
cor(mtcars, method = "pearson")
cor(mtcars, method = "kendall")
res <- cor(mtcars)#默认use="everything"和method="pearson"，将mtcars之间的相关系数赋值为res
head(res)#查看相关系数


###替换数据
#res <- cor(data)
#head(res)


## 3.安装并加载corrplot包
#install.packages("corrplot")#已经安装过，建议运行时删除最前面“#”重新安装
library(corrplot)#加载包

#a.简单相关性系数可视化
corrplot(res)#默认，简写
corrplot(corr=res)#具体参数
##相关参数介绍
#help("corrplot")
#help(corrplot)#查看R包帮助文档
# https://blog.csdn.net/lalaxumelala/article/details/86084040

# b.不同method的相关性系数图表
## method控制单元格形状和内容。换用不同method，分别显示数字和颜色（method can be "circle", "square", "ellipse", "number", "shade", "color", "pie"）
##method参数
# circle圆形(默认)，square方形， ellipse, 椭圆形，number数值，shade阴影，color颜色，pie饼图。
corrplot(res, method = "circle")
corrplot(res, method = "square")
corrplot(res, method = "ellipse")
corrplot(res, method = "number") #显示相关系数：
corrplot(res, method = "shade") 
corrplot(res, method = "color")  #正相关以蓝色显示，负相关以红色显示。颜色强度和圆圈的大小与相关系数成正比。
corrplot(res, method = "pie") 

# c.不同type的相关性系数图表
##type控制单元格展示的方式以及混合展示。
##type参数 
# full完全(默认)，lower下三角，upper上三角。
corrplot(res, type = "full")
corrplot(res, type = "lower")
corrplot(res, type = "upper")

# d.不同order的相关性系数图表
#相关矩阵可以根据相关系数重新排序。这对于识别矩阵中的隐藏结构和模式非常重要。以下示例中使用了用于分层聚类顺序的"hclust"。
##order设定不同展示顺序，order：指定相关系数排序的方法，默认order="orginal"以原始顺序展示
##order参数
# original原始顺序，AOE特征向量角序，FPC第一主成分顺序，hclust层次聚类顺序，alphabet字母顺序。
corrplot(res, order = "AOE")
corrplot(res, order = "hclust")
corrplot(res, order = "FPC")
corrplot(res, order = "alphabet")

#hclust.method：order参数为hclust时可指定hclust中方法，7种可选：complete最长距离法, ward离差平方和法, single最短距离法, average类平均法, mcquitty相似法, median中间距离法和centroid重心法。
# https://blog.csdn.net/zhouxinxin0202/article/details/79817358
#指定order按hclust聚类方式排序，addrect是添加分组矩形，可自定义分组类
# addrect参数添加矩形方框，数值代表框数
corrplot(res,order = "hclust",addrect = 3)
corrplot(res,order = "hclust",addrect = 2)
corrplot(res,order = "hclust",addrect = 4)

#当order = "hclust"时，可使用hclust.method选择层次聚类的方法
corrplot(res, order = "hclust", addrect = 3, rect.col = "red")
corrplot(res, order = "hclust", addrect = 4, rect.col = "blue")

# hclust.method = "ward.D2"设定聚类方法。"ward.D"和"ward.D2"均表示采用ward离差平方和法
corrplot(res, order = "hclust", hclust.method = "ward.D2", addrect = 4)
corrplot(res,order = "hclust",addrect  = 3,hclust.method="ward.D2")

# e.不同col的相关性系数图表
#更改相关系数图的颜色
##RcolorBrewer调色板：
#install.packages("RColorBrewer")
library(RColorBrewer)
corrplot(res, type="upper", order="hclust", 
         col=brewer.pal(n=8, name="RdBu"))
corrplot(res, type="upper", order="hclust",
         col=brewer.pal(n=8, name="RdYlBu"))
corrplot(res, type="upper", order="hclust",
         col=brewer.pal(n=8, name="PuOr"))
corrplot(res, type="upper", order="hclust",
         col=brewer.pal(n=11, name="PuOr"))

#颜色设置，还可以使用colorRampPalette颜色梯度函数，色彩更丰富
col1 <- colorRampPalette(c("#7F0000", "red", "#FF7F00", "yellow", "white",
                           "cyan", "#007FFF", "blue", "#00007F"))
col2 <- colorRampPalette(c("#67001F", "#B2182B", "#D6604D", "#F4A582",
                           "#FDDBC7", "#FFFFFF", "#D1E5F0", "#92C5DE",
                           "#4393C3", "#2166AC", "#053061"))
col3 <- colorRampPalette(c("red", "white", "blue")) 
col4 <- colorRampPalette(c("#7F0000", "red", "#FF7F00", "yellow", "#7FFF7F",
                           "cyan", "#007FFF", "blue", "#00007F"))
whiteblack <- c("white", "black")
# col = col1(20)设定颜色为col1中的20种颜色，越多颜色渐变感强，视觉效果越好
corrplot(res, order = "AOE", col = col1(5))#数字可以自行更改

corrplot(res, order = "AOE", col = col1(5), addCoef.col = "grey")
corrplot(res, order = "AOE", col = col1(10), addCoef.col = "grey")
corrplot(res, order = "AOE", col = col1(20), addCoef.col = "grey")
corrplot(res, order = "AOE", col = col1(100), addCoef.col = "grey")
corrplot(res, order = "AOE", col = col1(200), addCoef.col = "grey")
corrplot(res, order = "AOE", col = col2(200), addCoef.col = "grey")

## 设定col = wb 颜色为黑白
corrplot(res, col = whiteblack, order = "AOE", outline = TRUE, cl.pos = "n")

# 更改order = "FPC"
corrplot(res, order = "FPC", col = col2(200))
corrplot(res, order = "FPC", col = col2(10), addCoef.col = "grey")
corrplot(res, order = "FPC", col = col2(20), addCoef.col = "grey")

# 更改order = "hclust"
corrplot(res, order = "hclust", col = col3(10))
corrplot(res, order = "hclust", col = col3(100))
corrplot(res, order = "hclust", col = col4(100))

## bg设置背景色，cl.pos = "n"不展示颜色图例
corrplot(res, order = "AOE", bg = "grey",  cl.pos = "n")

## bg = "gold2"设置背景色
corrplot(res, col = whiteblack, bg = "gold2",  order = "AOE", cl.pos = "n")

# Change background color to lightblue 将背景颜色更改为浅蓝色
corrplot(res, type = "upper", order = "hclust",
         col = c("black", "white"), bg = "lightblue")

#改变单元格颜色以及背景颜色bg
col3 <- colorRampPalette(c("red", "white", "blue"))
corrplot(res, order = "hclust", addrect = 3, col = col3(100), bg = "lightblue")

#可以使用自定义颜色或者brewer.pal函数的画板
corrplot(res, order = "hclust", addrect = 2, col = col2(50))
corrplot(res, order = "hclust", addrect = 2, col = whiteblack, bg = "gold2")
#还可以使用标准调色板包（grDevices）
corrplot(res, order = "hclust", addrect = 2, col = heat.colors(100))
corrplot(res, order = "hclust", addrect = 2, col = terrain.colors(100))
corrplot(res, order = "hclust", addrect = 2, col = cm.colors(100))
corrplot(res, order = "hclust", addrect = 2, col = gray.colors(100))
corrplot(res, col = gray.colors(100))#删除聚类框

# col = "black"设定颜色为黑色, cl.pos = "n"设定颜色图例不展示
corrplot(res, method = "number", col = "black", cl.pos = "n")

# addCoef.col = "grey"添加相关系数并设定颜色为grey
corrplot(res, order = "AOE", addCoef.col = "grey")

#tl.col 修改对角线的颜色,lower.col 修改下三角的颜色，number.cex修改下三角字体大小
corrplot.mixed(res, lower = "number", upper = "pie", 
               tl.col = "black",lower.col = "black", number.cex = 1)  

corrplot.mixed(res, lower = "number", upper = "pie", 
               tl.col = "black",lower.col = "black", number.cex = 0.7)  
corrplot.mixed(res, lower = "number", upper = "pie", 
               tl.col = "black",lower.col = "black", number.cex = 1.5) 
#
corrplot(res, method = "ellipse", col = colorRampPalette(c("red", "blue"))(10), title = "更改颜色")
corrplot(res, method = "number", col = RColorBrewer::brewer.pal(n=11, name = "RdYlGn"),title = "")

corrplot(res,method="color",order="hclust",title = "hclust聚类", diag = TRUE,hclust.method="average",addCoef.col = "blue")


# f.更改文本标签和图例的颜色和旋转
#参数cl.*用于颜色图例，tl.*如果用于文本图例。对于文本标签，tl.col（文本标签颜色）和tl.srt（文本标签字符串旋转）用于更改文本颜色和旋转。
corrplot(res, type="upper", order="hclust", tl.col="black", tl.srt=45)

#控制对角标签旋转45度
# tl.srt参数设定文本标签摆放角度
corrplot(res, order = "AOE", tl.srt = 45)#45°
corrplot(res, order = "AOE", tl.srt = 60)
corrplot(res, order = "AOE", tl.srt = 90)
corrplot(res, order = "AOE", tl.srt = 0)
corrplot(res, order = "AOE")#默认90°竖直排放

#图例标签控制
# tl.pos = "n"不展示文本标签，diag = FALSE不展示对角线的相关系数
# cl.pos设定颜色图例的位置
corrplot(res, order = "AOE", cl.pos = "r")#图例在右边
corrplot(res, order = "AOE", cl.pos = "b")#图例在下边
corrplot(res, order = "AOE", cl.pos = "n")#无图例

#设置图例文本属性
corrplot(res, cl.cex = 1.5) # 设置图例中数字标签的缩放倍数
corrplot(res, cl.cex = 0.5)
corrplot(res, cl.cex = 1)
corrplot(res, cl.ratio = 2.0) # 数字，设置图例的宽度
corrplot(res, cl.ratio = 0.1)
corrplot(res, cl.align.text = "l") # 字符，设置图例中的数字标签的对齐方式

# cl.pos设定颜色图例的位置,tl.pos设定文本标签位置
corrplot(res, method="number",order = "AOE", cl.pos = "r", tl.pos = "n")
corrplot(res, method="number",order = "AOE", cl.pos = "r", tl.pos = "d")


#组合
corrplot(res, method = "ellipse", order = "AOE",  
         addCoefasPercent = TRUE, cl.pos = "r", 
         title = "图例在右边", diag = TRUE, mar = c(1,1,1,1))
corrplot(res, method = "ellipse", order = "AOE",  
         addCoefasPercent = TRUE, cl.pos = "b", 
         title = "图例在底部", diag = TRUE, mar = c(1,1,1,1))
corrplot(res, method = "ellipse", order = "AOE",  
         addCoefasPercent = TRUE, cl.pos = "n", 
         title = "无图例", diag = TRUE, mar = c(1,1,1,1))

#修改图例范围
#!!!警告此处存在报错"cl.lim"不是图形的问题，没有找到相关解决问题 https://github.com/taiyun/corrplot/issues/122
#默认范围为-1到1
#cl.lim = c(0,1)设定图例颜色范围
corrplot(res,order = "AOE", cl.lim = c(0,1))


# 修改图例范围 abs(res)：abs取绝对值,cl.lim设定图例颜色范围
corrplot(abs(res),order = "AOE",cl.lim=c(0,1))
corrplot(abs(res), order = "AOE", col = col1(200), cl.lim = c(0,1))

## remove color legend and text legend 删除颜色图例和文字图例
corrplot(res, order = "AOE", cl.pos = "n", tl.pos = "n")  
## bottom  color legend, diagonal text legend, rotate text label 底部颜色图例、对角文字图例、旋转文字标签
corrplot(res, order = "AOE", cl.pos = "b", tl.pos = "d", tl.srt = 60)
## a wider color legend with numbers right aligned 更宽的颜色图例，数字右对齐
corrplot(res, order = "AOE", cl.ratio = 0.2, cl.align = "r")
## text labels rotated 45 degrees 文本标签旋转45度
corrplot(res, type = "lower", order = "hclust", tl.col = "black", tl.srt = 45)

# g.更改相关系数参数
# diag 是否展示对角线的相关系数
corrplot(res, order = "AOE", type = "upper", diag = FALSE)#不展示对角线的相关系数
corrplot(res, order = "AOE", type = "upper", diag = TRUE)#展示对角线的相关系数

#可以让相关系数的字体变小点，number.cex参数默认为1，可以改为自己认为合适的
corrplot(res, method = "circle", type = "upper", tl.pos = "d")
corrplot(res,add = TRUE, type = "lower", method = "number", diag = FALSE, tl.pos = "n", cl.pos = "n",number.cex=0.5) 
corrplot(res,add = TRUE, type = "lower", method = "number", diag = FALSE, tl.pos = "n", cl.pos = "n",number.cex=0.8)
corrplot(res,add = TRUE, type = "lower", method = "number", diag = FALSE, tl.pos = "n", cl.pos = "n",number.cex=1) 

#组合
corrplot(res, order = "AOE", tl.pos = "d", cl.pos = "n")
corrplot(res, type = "lower", order = "hclust", tl.col = "black", tl.srt = 45)
corrplot(res,order = "AOE", type = "lower", method = "ellipse", 
         diag = FALSE, tl.pos = "n", cl.pos = "n")
corrplot(res,order = "AOE", type = "lower", method = "ellipse", 
         diag = TRUE, tl.pos = "n", cl.pos = "n")

# h.阴影设置，只有当method="shade"时，该参数才有用。
#参数设置
#addshade添加阴影范围，分为正阴影，负阴影，全阴影。
#shade.lwd设置阴影线宽。shade.col设置阴影线颜色。
corrplot(res, method = "shade", order = "AOE")

corrplot(res, method = "shade", order = "AOE", 
                   addshade = "negative", shade.lwd = 1, shade.col = "blue",   
                   title = "蓝色负阴影", mar = c(1,1,1,1))
corrplot(res, method = "shade", order = "AOE", 
                   addshade = "positive", shade.lwd = 1, shade.col = "blue", 
                   title = "蓝色正阴影", mar = c(1,1,1,1))
corrplot(res, method = "shade", order = "AOE", 
                   shade.lwd = 1, shade.col = "blue", 
                   title = "默认全阴影", mar = c(1,1,1,1))
corrplot(res, method = "shade", order = "AOE", 
         shade.lwd = 1, shade.col = "black", 
         title = "默认全阴影", mar = c(1,1,1,1))


# i.显著性标记sig.level及p.mat
library(corrplot)
res1 <- cor.mtest(mtcars, conf.level = 0.95)
head(res1)


#注意替换数据
#res1 <- cor.mtest(data, conf.level = 0.95)
#head(res1)


#res1$p显著程度
corrplot(res, method = "circle", p.mat = res1$p, sig.level = 0.01)

corrplot(res, method = "circle", 
                   p.mat = res1$p, sig.level = 0.01, insig = "pch", pch.col = "blue", pch.cex = 3,
                   title = "蓝色显著性标记", mar = c(1,1,1,1))

corrplot(res, p.mat = res1$p, insig = "label_sig",
         sig.level = c(.001, .01, .05), pch.cex = .9, pch.col = "white")
#j.处理缺失（NA）值
#默认情况下，corrplot将NA值呈现为"?"字符。使用na.label 参数，可以使用不同的值（最多支持两个字符）。
M2 <- res
diag(M2) = NA
corrplot(M2)

##
#o.将相关图与显着性检验相结合
res1 <- cor.mtest(mtcars, conf.level = .95)
res2 <- cor.mtest(mtcars, conf.level = .99)


##注意替换数据
#res1 <- cor.mtest(data, conf.level = 0.95)
#head(res1)

## specialized the insignificant value according to the significant level 根据显著性水平专门化不显著值
corrplot(res, p.mat = res1$p, sig.level = .01)
## leave blank on no significant coefficient 不显着系数留空
corrplot(res, p.mat = res1$p, insig = "blank")
## add p-values on no significant coefficient 在不显着的系数上添加 p 值
corrplot(res, p.mat = res1$p, insig = "p-value")
## add all p-values 添加所有p值
corrplot(res, p.mat = res1$p, insig = "p-value", sig.level = -1)
## add cross on no significant coefficient  在不显着的系数上添加交叉

corrplot(res, p.mat = res1$p, order = "hclust", insig = "pch", addrect = 3)
#设置insig = "label_sig" 可将P值以 * 号方式展示出来, 通过设置sig.level = c(.001, .01, .05) 可以将不同范围内的p值用 * 来表示 ,如p值小于0.001的系数设置为三个 * 。
corrplot(res, p.mat = res1$p, insig = "label_sig",
         sig.level = c(.001, .01, .05), pch.cex = .9, pch.col = "white")

#p.可视化置信区间
corrplot(res, low = res1$lowCI, upp = res1$uppCI, order = "hclust",
         rect.col = "navy", plotC = "rect", cl.pos = "n")

corrplot(res, p.mat = res1$p, low = res1$lowCI, upp = res1$uppCI,
         order = "hclust", pch.col = "red", sig.level = 0.01,
         addrect = 3, rect.col = "navy", plotC = "rect", cl.pos = "n")


res1 <- cor.mtest(mtcars, conf.level = .95)
###替换
#res1 <- cor.mtest(data, conf.level = .95)
corrplot(res, p.mat = res1$p, insig = "label_sig",
         sig.level = c(.001, .01, .05), pch.cex = .9, pch.col = "white")

corrplot(res, p.mat = res1$p, method = "color",
         insig = "label_sig", pch.col = "white")

corrplot(res, p.mat = res1$p, method = "color", type = "upper",
         sig.level = c(.001, .01, .05), pch.cex = .9,
         insig = "label_sig", pch.col = "white", order = "AOE")
corrplot(res, p.mat = res1$p, method = "color", type = "upper",
         sig.level = c(.001, .01, .05), pch.cex = .9,
         insig = "label_sig", pch.col = "white", order = "AOE")

corrplot(res, p.mat = res1$p, insig = "label_sig", pch.col = "white",
         pch = "p<.05", pch.cex = .5, order = "AOE")

corrplot(M2, na.label = "o")
corrplot(M2, na.label = "NA")


####图形数值混合矩阵，可以添加lower.col参数改变字体颜色，和number.cex参数调整字体大小。
##多图组合展示

#混合可视化样式
# corrplot.mixed（)可以混合可视化样式
corrplot.mixed(res) #默认样式上三角为circle 下三角为 number
corrplot.mixed(res, lower = "ellipse", upper = "pie")
corrplot.mixed(res, lower = "number", upper = "pie")

#具体混合样式可以自行调整
## circle + ellipse
# type参数设定展示类型，默认type="full"展示全部
corrplot(res, order = "AOE", type = "upper")
# tl.pos = "d"设定文本标签展示在对角线
corrplot(res, order = "AOE", type = "upper", tl.pos = "d")
# add = TRUE在已有的图形上添加其他图形
corrplot(res, add = TRUE, type = "lower", method = "ellipse", order = "AOE",
         diag = FALSE, tl.pos = "n", cl.pos = "n")
# tl.pos = "n"不展示文本标签, cl.pos = "n"不展示颜色图例，diag = FALSE不展示对角线的相关系数
# diag = FALSE不展示对角线的相关系数
corrplot(res, order = "AOE", type = "upper", diag = FALSE)

corrplot(res, order = "AOE", type = "lower", cl.pos = "b")
corrplot(res, order = "AOE", type = "lower", cl.pos = "b", diag = FALSE)

#### color-legend 颜色图例
# cl.ratio参数设定颜色图例的宽度, cl.align设定图例文本的对齐方式
corrplot(res, order = "AOE", cl.ratio = 0.1, cl.align = "l")
corrplot(res, order = "AOE", cl.ratio = 0.5, cl.align = "l")
corrplot(res, order = "AOE", cl.ratio = 0.2, cl.align = "l") #居左
corrplot(res, order = "AOE", cl.ratio = 0.2, cl.align = "c") #居中
corrplot(res, order = "AOE", cl.ratio = 0.2, cl.align = "r") #居右

corrplot(res, order = "AOE", type = "lower", method = "ellipse", 
         diag = FALSE, tl.pos = "n", cl.pos = "n")
## circle + square
corrplot(res, order = "AOE",type = "upper", tl.pos = "d")
corrplot(res, add = TRUE, type = "lower", method = "square", order = "AOE",
         diag = FALSE, tl.pos = "n", cl.pos = "n")
## circle + colorful number
corrplot(res, order = "AOE", type = "upper", tl.pos = "d")
corrplot(res, add = TRUE, type = "lower", method = "number", order = "AOE",
         diag = FALSE, tl.pos = "n", cl.pos = "n")
## circle + black number
corrplot(res, order = "AOE", type = "upper", tl.pos = "tp")
corrplot(res, add = TRUE, type = "lower", method = "number", order = "AOE",
         col = "black", diag = FALSE, tl.pos = "n", cl.pos = "n")
## order is hclust and draw rectangles
corrplot(res, order = "hclust")

corrplot(res,method = "color",order = "hclust",tl.col="black",addrect=4,addCoef.col = "grey")

corrplot(res,method="pie",tl.col="black",tl.srt=45, title = "method=pie的饼图", cex.main = 1, mar = c(2,2,3,2))  #饼图
corrplot(res,method="ellipse",shade.col=NA,tl.col="black",tl.srt=45,  title = "method=ellipse的饼图", cex.main = 1, mar = c(2,2,3,2)) #椭圆
corrplot(res, method="number",shade.col=NA,tl.col="black",tl.srt=45,  title = "method=number的饼图", cex.main = 1, mar = c(2,2,3,2))#数字
# 参数解释
# method：展示方法
# shade.col：背景颜色
# tl.col：坐标颜色；tl.srt：坐标内容旋转角度
# title：设置标题
# cex.main：标题相对于默认大小的调整倍数
# mar：图形元素的边距，默认“下左上右”顺序


###将相关性图与显著性检验相结合
#计算相关性的 p 值
# mat : is a matrix of data
# ... : further arguments to pass to the native R cor.test function
cor.mtest <- function(mat, ...) {
  mat <- as.matrix(mat)
  n <- ncol(mat)
  p.mat<- matrix(NA, n, n)
  diag(p.mat) <- 0
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      tmp <- cor.test(mat[, i], mat[, j], ...)
      p.mat[i, j] <- p.mat[j, i] <- tmp$p.value
    }
  }
  colnames(p.mat) <- rownames(p.mat) <- colnames(mat)
  p.mat
}
# matrix of the p-value of the correlation 相关性 p 值的矩阵
p.mat <- cor.mtest(mtcars)
head(p.mat)


##替换
#p.mat <- cor.mtest(data)
#head(p.mat)


#将显著性水平添加到相关图
# Specialized the insignificant value according to the significant level 根据显着性水平专门化不显着值
corrplot(res, type="upper", order="hclust", 
         p.mat = p.mat, sig.level = 0.01)

# Leave blank on no significant coefficient 无显著系数留空
corrplot(res, type="upper", order="hclust", 
         p.mat = p.mat, sig.level = 0.01, insig = "blank")


#处理非相关矩阵
##存在问题
corrplot(abs(res),order = "AOE", col = col3(200), cl.lim = c(0, 1))
corrplot(res,order = "AOE", col = col3(200), cl.lim = c(0, 1))


## visualize a  matrix in [-100, 100] 将矩阵可视化为
ran <- round(matrix(runif(225, -100,100), 15))
ran <- round(matrix(runif(225, -100,100), 30))
corrplot(ran, is.corr = FALSE, method = "square")

## a beautiful color legend  更丰富的色彩
corrplot(ran, is.corr = FALSE, method = "ellipse", cl.lim = c(-100, 100))

#如果矩阵是矩形，则可以使用win.asp参数调整纵横比， 以使矩阵呈现为正方形。
ran <- matrix(rnorm(70), ncol = 7)
corrplot(ran, is.corr = FALSE, win.asp = .7, method = "circle")


#在标签中使用“ PLOTMATH”表达式
#从version开始0.78，可以 在变量名称中使用 plotmath表达式。要**plotmath渲染，前缀的人物之一的标签":"，"="或"$"。
M2 <- res[1:5,1:5]#创建一个矩阵向量
colnames(M2) <- c("alpha", "beta", ":alpha+beta", ":a[0]", "=a[beta]")
rownames(M2) <- c("alpha", "beta", NA, "$a[0]", "$ a[beta]")
corrplot(M2)

####重要
#混合相关性系数可视化 （上下三角矩阵）
corrplot(res, type = "upper", order = "hclust", tl.col = "black", tl.srt = 45, 
         title = "type = upper的数字+饼图", mar = c(2,2,3,2))  #上三角
corrplot.mixed(res, title = "图形和数值混合矩阵", mar = c(2,2,3,2)) #图形和数值混合矩阵
corrplot.mixed(res, lower.col = "black", number.cex = .7, 
               title = "文字看不清，可以设置文字为黑色lower.col和大小number.cex", mar = c(2,2,3,2))
corrplot(res, order = "hclust", addrect = 2, 
         title = "按hclust聚类方式排序", mar = c(2,2,3,2))  
#按hclust聚类方式排序，addrect是添加分组矩形，可自定义分组类
#类似于平时热图的kmean分组方式。


#自定义相关图
# matrix of the p-value of the correlation 相关性 p 值的矩阵
p.mat <- cor.mtest(res)$p
head(p.mat)

# Specialized the insignificant value according to the significant level 根据显著性水平专门化不显著值
corrplot(res, type = "upper", order = "hclust", 
         p.mat = p.mat, sig.level = 0.01)

#
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(res, method = "color", col = col(200),
         type = "upper", order = "hclust", number.cex = 0.7,
         addCoef.col = "black", # Add coefficient of correlation 加上相关系数
         tl.col = "black", tl.srt = 90, # Text label color and rotation 文本标签颜色和旋转
         # Combine with significance 结合意义
         p.mat = p.mat, sig.level = 0.01, insig = "blank", 
         # hide correlation coefficient on the principal diagonal 隐藏主对角线上的相关系数
         diag = FALSE)
#自定义相关图
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(res, method="color", col=col1(20),  
         type="upper", order="hclust", 
         addCoef.col = "black", # 添加相关系数
         tl.col="black", tl.srt=45, #文本标签颜色和旋转
         # p值
         p.mat = p.mat, sig.level = 0.01, insig = "blank", 
         # 隐藏主对角线上的相关系数
         diag=FALSE 
)

#探索大型功能矩阵
# generating large feature matrix (cols=features, rows=samples) 生成大特征矩阵（列=特征，行=样本）
num_features <- 60 # how many features 有多少特征
num_samples <- 300 # how many samples 多少个样本
DATASET <- matrix(runif(num_features * num_samples),
                  nrow = num_samples, ncol = num_features)

# setting some dummy names for the features e.g. f23 为功能设置一些虚拟名称，例如f23
colnames(DATASET) <- paste0("f", 1:ncol(DATASET))

# let's make 30% of all features to be correlated with feature "f1" 让我们将所有特征的 30% 与特征“f1”相关联
num_feat_corr <- num_features * 0.3
idx_correlated_features <- as.integer(seq(from = 1,
                                          to = num_features,
                                          length.out = num_feat_corr))[-1]
for (i in idx_correlated_features) {
  DATASET[,i] <- DATASET[,1] + runif(num_samples) # adding some noise
}

corrplot(cor(DATASET), diag = FALSE, order = "FPC",
         tl.pos = "td", tl.cex = 0.5, method = "color", type = "upper")




corrplot(res, mar = c(2.2, 2.6,2.8,1.9)) # 设置图形四边间距
corrplot(res, addgrid.col = "black") # 设置网格线
corrplot(res, outline = "black") # 设置圆形、椭圆形等外边框
corrplot(res, tl.pos = "n", 
         title  = "corrplot包") # 添加图形标题


#全部参数汇总

corrplot(
  res, # 要可视化的相关矩阵
  method=c("circle", "square", "ellipse", "number", "shade", "color", "pie"), # 相关矩阵可视化的方法
  type = c("full", "lower", "upper"), # 显示矩阵的类型
  add = FALSE, # 是否把新创建的图添加到现有的绘图中
  col = NULL, # 字形的颜色。它在 col.lim 区间内均匀分布，如果为NULL,col 将是colorRampPalette(col2)(200)
  col.lim = NULL,
  bg = "white", # 图背景颜色
  title = "", # 设置图片标题
  is.corr = TRUE, #输入矩阵是否为相关矩阵，设为FALSE时可用来可视化非相关矩阵
  diag = TRUE, # 是否在主对角线上显示相关系数
  outline = FALSE, # 绘制圆形、方形和椭圆形的轮廓,如果为TRUE，则默认值为“black”。
  addgrid.col = NULL, # 网格的颜色,如果为NULL，则根据方法选择默认值
  addCoef.col = NULL, # 添加在图表上的相关系数的颜色。如果为NULL(默认)，则不添加系数
  addCoefasPercent = FALSE, # 是否将系数转换为百分比样式以节省空间
  order = c("original", "AOE", "FPC", "hclust", "alphabet"), # 相关矩阵的排序方法(original:原始顺序(默认)；AOE:特征向量的角顺序；FPC:第一主成分排序；hclust:层次聚类排序；alphabet:按字母顺序排序)
  hclust.method = c("complete", "ward", "ward.D", "ward.D2", "single", "average",
                    "mcquitty", "median", "centroid"), # order为hclust时使用的聚类方法
  addrect = NULL, # 整数,按层次聚类在图上绘制的矩形个数,仅当order为hclust时有效。如果为NULL(默认),则不添加矩形。
  rect.col = "black", # 矩形边框的颜色，仅当addrect等于或大于1时才有效。
  rect.lwd = 2, # 数字，矩形边框的边框线宽，仅当addrect等于或大于1时有效。
  tl.pos = NULL, # 文本标签字符的位置(可设置项目为"lt","ld","td","d"or"n","lt")
  tl.cex = 1, # 数字，用于文本标签（变量名称）的大小
  tl.col = "red", # 文本标签的颜色
  tl.offset = 0.4, # 移动文本标签
  tl.srt = 90, # 数字,文本标签字符串的旋转度数
  cl.pos = NULL, # 颜色图例的位置(右边=r；底部=b；不画图例=n)
  cl.length = NULL, # 对颜色图例呈现的数字文本进行分段设置
  cl.cex = 0.8, # 数字，颜色图例中数字标签的大小
  cl.ratio = 0.15, # 数字，调整颜色图例的宽度，建议为 0.1~0.2。
  cl.align.text = "c", # “l”、“c”（默认）或“r”，对于颜色图例中的数字标签，“l”表示左，“c”表示中心，“r”表示右。
  cl.offset = 0.5, # 数字，移动颜色图例中的数字标签
  number.cex = 1, # 将相关系数写入图中时调用cex参数调整大小
  number.font = 2, # 将相关系数写入图中时调用font参数调整字体
  number.digits = NULL, # 表示要添加到图中的小数位数。非负整数或NULL，默认 NULL。
  # 阴影样式的字符,'negative'、'positive'或'all'，仅在方法为'shade'时有效。如果是'all',所有相关系数的字形将被阴影化；如果为“positive”，则仅对正部分进行着色；如果为“negative”，则只会对负进行着色。注：阴影线的角度不同，正45度，负135度。  
  addshade = c("negative", "positive", "all"), 
  shade.lwd = 1, # 数字，阴影的线宽。
  shade.col = "white", # 阴影线的颜色。 
  p.mat = NULL, # p值矩阵，如果为NULL，参数sig.level、insig、pch、pch.col、pch.cex无效。
  sig.level = 0.05, # 显著水平，如果p-mat中的p值大于sig.level，则认为相应的相关系数不显著。
  insig = c("pch", "p-value", "blank", "n", "label_sig"), # 专门的不显著相关系数、'pch'（默认）、'p-value'、'blank'、'n' 或 'label_sig'。如果为“blank”，则在图中擦除相应的区域；
  pch = 4, # 在无关系数的字形上添加字符（仅当insig为'pch'时有效）。
  pch.col = "black", # pch的颜色
  pch.cex = 3, # pch的cex(大小？)(仅在insig 为'pch'时有效)
  plotCI = c("n", "square","circle", "rect"), # 绘制置信区间的方法。如果为“n”，则不绘制置信区间。如果为'rect'，则分别绘制上边表示上限和下边表示下限的矩形。
  lowCI.mat = NULL, # 置信区间lower矩阵
  uppCI.mat = NULL, # 置信区间upper矩阵
  na.label = "?", # 用于渲染NA单元格的标签。默认为“？”。如果为“square”，则单元格将呈现为具有na.label.col颜色的正方形。
  na.label.col = "black", # 用于渲染 NA 单元格的颜色。默认为“黑色”。
  win.asp = 1, # 整个图的纵横比。1以外的值目前仅与方法“circle”和“square”兼容。
)


##全部绘图参数详解
# https://mp.weixin.qq.com/s?src=11&timestamp=1637827701&ver=3457&signature=iUEweyQ76eXDXjrvljnTyqf7TL2b9xJlhHVdga1l5JmXX27n5CHLcgU9FfFEA2KAUMESSzpkStXVkHEOrLbJ6LmWgOEjWE9t2Y0lu-G*mucwzGiHoqGu91jaht6Ck08-&new=1
#corr：用于绘图的矩阵，必须是正方形矩阵，如果是普通的矩阵，需要设置is.corr=FALSE
#method:可视化的方法，默认是圆circle，还有正方形square、椭圆ellipse、数字number、阴影shade、颜色color和饼pie可选。文章开篇处的示例即为饼形，类似月亮周期的大小变化。
#type：展示类型，默认全显full，还有下三角lower，或上三角upper可选。
#col：指定图形展示的颜色，默认以均匀的颜色展示
#bg：指定图的背景色
#title：为图形添加标题
#is.corr：是否为相关系数绘图，默认为TRUE，同样也可以实现非相关系数的可视化，只需使该参数设为FALSE即可
#diag：是否展示对角线上的结果，默认为TRUE
#outline：是否绘制圆形、方形或椭圆形的轮廓，默认为FALSE
#mar：具体设置图形的四边间距
#addgrid.col：当选择的方法为颜色或阴影时，默认的网格线颜色为白色，否则为灰色
#addCoef.col：为相关系数添加颜色，默认不添加相关系数，只有方法为 number时，该参数才起作用
#addCoefasPercent：为节省绘图空间，是否将相关系数转换为百分比格式，默认为FALSE
#order：指定相关系数排序的方法，可以是原始顺序(original)、特征向量顺序(AOE)、第一主成分顺序(FPC)、层次聚类顺序(hclust)和字母顺序，一般”AOE”排序结果都比”FPC”要好
#hclust.method：当order为hclust时，该参数可以是层次聚类中ward法、最大距离法等7种之一
#addrect：当order为hclust时，可以为添加相关系数图添加矩形框，默认不添加框，如果想添加框时，只需为该参数指定一个整数即可
#rect.col：指定矩形框的颜色
#rect.lwd：指定矩形框的线宽
#tl.pos：指定文本标签(变量名称)的位置，当type=full时，默认标签位置在左边和顶部(lt)，当type=lower时，默认标签在左边和对角线(ld)，当type=upper时，默认标签在顶部和对角线，d表示对角线，n表示不添加文本标签
#tl.cex：指定文本标签的大小##表型名称
#tl.col：名称标签字体颜色
#cl.pos：图例（颜色）位置，当type=upper或full时，图例在右边，当type=lower时，图例在底部，不需要图例时，只需指定该参数为n
#addshade：只有当method=shade时，该参数才有用，参数值可以是negtive/positive和all，分别表示对负相关系数、正相关系数和所有相关系数添加阴影。注意：正相关系数的阴影是45度，负相关系数的阴影是135度
#cl.cex：可改变图列刻度数字大小
#shade.lwd：指定阴影的线宽
#number.cex：可以改变相关系数的数字的大小
#shade.col：指定阴影线的颜
#corr：用于绘图的矩阵，必须是正方形矩阵，如果是普通的矩阵，需要设置is.corr=FALSE
#method: 可视化的方法，默认是圆circle，还有正方形square、椭圆ellipse、数字number、阴影shade、颜色color和饼pie可选。饼形，类似月亮周期的大小变化。
#type：展示类型，默认全显full，还有下三角lower，或上三角upper可选。
#col：指定图形展示的颜色，默认以均匀的颜色展示
#bg：指定图的背景色
#title：为图形添加标题
#is.corr：是否为相关系数绘图，默认为TRUE，同样也可以实现非相关系数的可视化，只需使该参数设为FALSE即可
#diag：是否展示对角线上的结果，默认为TRUE
#outline：是否绘制圆形、方形或椭圆形的轮廓，默认为FALSE
#mar：具体设置图形的四边间距
#addgrid.col：当选择的方法为颜色或阴影时，默认的网格线颜色为白色，否则为灰色
#addCoef.col：为相关系数添加颜色，默认不添加相关系数，只有方法为number时，该参数才起作用
#addCoefasPercent：为节省绘图空间，是否将相关系数转换为百分比格式，默认为FALSEorder：指定相关系数排序的方法，可以是原始顺序(original)、特征向量顺序(AOE)、第一主成分顺序(FPC)、层次聚类顺序(hclust)和字母顺序，一般”AOE”排序结果都比”FPC”要好
#hclust.method：当order为hclust时，该参数可以是层次聚类中ward法、最大距离法等7种之一addrect：当order为hclust时，可以为添加相关系数图添加矩形框，默认不添加框，如果想添加框时，只需为该参数指定一个整数即可rect.col：指定矩形框的颜色rect.lwd：指定矩形框的线宽
#tl.pos：指定文本标签(变量名称)的位置，当type=full时，默认标签位置在左边和顶部(lt)，当type=lower时，默认标签在左边和对角线(ld)，当type=upper时，默认标签在顶部和对角线，d表示对角线，n表示不添加文本标签
#tl.cex：指定文本标签的大小##表型名称
#tl.col：名称标签字体颜色
#cl.pos：图例（颜色）位置，当type=upper或full时，图例在右边，当type=lower时，图例在底部，不需要图例时，只需指定该参数为naddshade：只有当method=shade时，该参数才有用，参数值可以是negtive/positive和all，分别表示对负相关系数、正相关系数和所有相关系数添加阴影。注意：正相关系数的阴影是45度，负相关系数的阴影是135度
#cl.cex：可改变图列刻度数字大小
#shade.lwd：指定阴影的线宽
#number.cex：可以改变相关系数的数字的大小
#shade.col：指定阴影线的颜色


#实例https://blog.csdn.net/qq_42374697/article/details/110448309

#输出pdf 此处建议export导出
p0<- corrplot(res, type = "upper", order = "hclust", 
         p.mat = p.mat, sig.level = 0.01)
#修改字体
library(ggplot2)
theme_get()$text
#查看当前的ggplot2默认字体
windowsFonts()
#查看Windows系统下的字体
p0+theme(text=element_text(size=16,  family="serif"))
#修改成Time New Roman

