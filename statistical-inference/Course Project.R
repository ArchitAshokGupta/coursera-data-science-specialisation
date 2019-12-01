# Part 1
set.seed(2016)

lambda <- 0.2
n <- 40
sims <- 1000

sim_exp <- replicate(sims, rexp(n,lambda))
means_sims <- apply(sim_exp, 2, mean)
hist(means_sims, breaks=40, xlim=c(2,9), main="Means of Simulated Exponential Functions", xlab="Mean Value", col="lightblue")

hist(means_sims, breaks=40, xlim=c(2,9), main="Sample Mean vs. Theoretical Mean", xlab="Mean Value", col="lightblue")
abline(v=mean(means_sims), lwd="2", col="darkred")

mean(means_sims)

print(paste("Theoretical Standard Deviation: ", round((1/lambda)/sqrt(n), 4)))
print(paste("Sample Standard Deviation: ", round(sd(means_sims), 4))) 
print(paste("Theoretical Variance: ", round(((1/lambda)/sqrt(n))^2, 4)))
print(paste("Sample Variance: ", round(sd(means_sims)^2, 4)))

hist(means_sims, prob=TRUE, breaks=40, xlim=c(2,9), main="Means of Simulated Exponential Functions", xlab="Mean Value", col="lightblue")
lines(density(means_sims), lwd=2, col="darkred")
x <- seq(min(means_sims), max(means_sims), length=2*n)
y <- dnorm(x, mean=1/lambda, sd=sqrt(((1/lambda)/sqrt(n))^2))
lines(x, y, pch=22, lwd=2, lty=2, col="black")

qqnorm(means_sims)
qqline(means_sims, col="red")

# Part 2
library(ggplot2)

data("ToothGrowth")
summary(ToothGrowth)
head(ToothGrowth)

unique(ToothGrowth$len)
unique(ToothGrowth$supp)
unique(ToothGrowth$dose)

ToothGrowth$dose<-as.factor(ToothGrowth$dose)

ggplot(aes(x=dose,y=len), data=ToothGrowth) + 
  geom_boxplot(aes(fill=dose)) + 
  facet_grid(~supp) + 
  theme(plot.title=element_text(lineheight=.8, face="bold")) +
  xlab("Dose Amount") + 
  ylab("Tooth Length") + 
  ggtitle("Tooth Length vs. Dosage \n by Supplement") 

ggplot(aes(x=supp,y=len), data=ToothGrowth) + 
  geom_boxplot(aes(fill=supp)) + 
  facet_grid(~dose) +
  theme(plot.title=element_text(lineheight=.8, face="bold")) +
  xlab("Supplement Delivery") + 
  ylab("Tooth Length") + 
  ggtitle("Tooth Length vs. Supplement \n by Dosage")

avg <- aggregate(len~., data=ToothGrowth, mean) # len mean for every dose and supp
ggplot(aes(x=dose,y=len), data=ToothGrowth) + 
  geom_point(aes(group=supp, colour=supp, size=2, alpha=0.6)) +
  geom_line(data=avg, aes(group=supp,colour=supp)) + 
  xlab("Dose Amount") + 
  ylab("Tooth Length") +
  ggtitle("Tooth Length by Dosage & Supplement")

t.test(len~supp, data=ToothGrowth)

ToothGrowth_sub <- subset(ToothGrowth, ToothGrowth$dose %in% c(1.0,0.5))
t.test(len~dose, data=ToothGrowth_sub)
ToothGrowth_sub <- subset(ToothGrowth, ToothGrowth$dose %in% c(0.5,2.0))
t.test(len~dose, data=ToothGrowth_sub)
ToothGrowth_sub <- subset(ToothGrowth, ToothGrowth$dose %in% c(1.0,2.0))
t.test(len~dose, data=ToothGrowth_sub)
  