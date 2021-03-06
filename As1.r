To begin, load in the Boston data set. The Boston data set is
part of the MASS library in R.
```{r}
library(MASS)
```
Now the data set is contained in the object Boston.
```{r}
Boston
```
Read about the data set.
```{r}
?Boston
```
(a)How many rows are in this data set? How many columns? 
  What do the rows and columns represent?
compute rows and columns
```{r}
dim(Boston)
```
```{r}
str(Boston)
```
These rows represent observations of the Census area in the Boston area. 
Column shows the measurements of the census variables.

(b) Make some pairwise scatterplots of the predictors (columns) in
this data set. Describe your findings.
```{r}
attach(Boston)
pairs(Boston)
```
Higher dis - weighted mean of distances to five Boston employment centres.
Lower indus - proportion of non-retail business acres per town.


(c) Are any of the predictors associated with per capita crime rate?
  If so, explain the relationship.
Find the correlations between crime rates and other variables.
```{r}
Boston.corr = cor(Boston)
Boston.corr.crim = Boston.corr[-1,1]
print(
  Boston.corr.crim[order(abs(Boston.corr.crim), decreasing = T)]
)
```

Find top 4 correlated variables
```{r}
par(mfrow=c(2,2))
aux = names(Boston.corr.crim[order(abs(Boston.corr.crim), decreasing = T)][1:4])
for(i in aux){
  plot(get(i), crim, xlab=i)
}
```

(d) Do any of the suburbs of Boston appear to have particularly
high crime rates? Tax rates? Pupil-teacher ratios? Comment on
the range of each predictor.

Crime rates
```{r}
summary(crim)
```
Max value is 88.98
```{r}
length(crim[crim>30])
```

Tax rates
```{r}
hist(tax)
```
Some suburbs have high levels of taxation.
```{r}
length(tax[tax>500])
```
Pupil-Teacher ratio
```{r}
hist(ptratio)
```
[14,20] are average overall, [20,21] have higher number
length(ptratio[ptratio<14])

(e) How many of the suburbs in this data set bound the Charles
river?
```{r}  
table(chas)
```
1(Yes) means suburb bounds the Charles Rivers, 
there are 35 suburbs that bound river

(f) What is the median pupil-teacher ratio among the towns in this
data set?
```{r}   
median(ptratio)
```
(g) Which suburb of Boston has the lowest median value of owner-occupied
homes? What are the values of the other predictors
for that suburb, and how do those values compare to the overall
ranges for those predictors? Comment on your findings.

```{r} 
subs.lw = which(medv<median(medv))
print(subs.lw)
```
 Other variables
```{r} 
Boston.corr.subs.lw = cor(Boston[subs.lw, ])
corr.compare = data.frame('lower'=Boston.corr.subs.lw[, "medv"], 'all'=Boston.corr[, "medv"])
corr.compare$diff = corr.compare$lower - corr.compare$all
```
Check the vary of differences
```{r} 
hist(corr.compare$diff, xlab="Correlation Differences")
```
```{r} 
hist(abs(corr.compare$diff), xlab="Correlation Differences")
```
Correlation differences
```{r} 
main.diffs = head(corr.compare[order(abs(corr.compare$diff), decreasing = T), ], 5)

print(main.diffs)
```

```{r} 
print(rownames(main.diffs))
```
The number of rooms has a smaller effect in the cheapest house than in the more expensive house, 
and this phenomenon also occurs in ptratio. In relation to all suburbs, 
houses farther from job centres were cheaper.

(h) In this data set, how many of the suburbs average more than
seven rooms per dwelling? More than eight rooms per dwelling?
  Comment on the suburbs that average more than eight rooms
per dwelling.

```{r}
hist(rm, main="Distribution of Rooms by Dwelling", xlab="Rooms")
```
More than 7 rooms per dwelling
```{r}
length(rm[rm>7])
```
More than 8 rooms per dwelling
```{r}
length(rm[rm>8])
```
Compare prices
```{r}
frm =as.factor(as.character(lapply(rm, function(x) ifelse(x>8, "]8, +Inf[", ifelse(x>7,"]7,8]","[0,7]")))))
plot(frm, medv, varwidth=T, xlab="Number of Rooms", 
     ylab="Median Values by $1000s",
     title="Median Value of Owner-Occupied Homes")
```
Houses with more than 8 rooms are more expensive, but here's an outlier at a low price.
```{r}
Boston[rm>8 & medv<30, ]
```