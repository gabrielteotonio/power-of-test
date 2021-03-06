m <- 1000            #number of replicas
mu_verd <- 1/2       #true value of the population parameter 
mu_test <- c(7/2, 3, 5/2, 2, 3/2, 1, 1/2, 1/3, 1/4, 1/5, 1/6, 1/7)  #test values
M <- length(mu_test)              #number of Monte Carlo replicas
power <- numeric(M)               #vector to storage the empirical power of the test
nobs <- c(20, 40, 50, 100)        #sampling size
power_nobs <- matrix(0,length(nobs),M)  #matrix to storage the empirical power of the test for each size n
c <- 1
for(j in nobs) {
  for (i in 1:M) {
    mu <- mu_test[i]
    p_value <- replicate(m, expr = {
      x <- rlnorm(j,  (log(mu)) - 1/2, 1)
      test_t <- t.test(x, alternative = "greater", mu = mu_verd)
      test_t$p.value})
    power[i] <- mean(p_value <= 0.05)
  }
  power_nobs[c,] <- power
  c = c+1
}

#Plots to see the performance varying n
par(mfrow=c(2,2))
plot(mu_test, power_nobs[1,], type = "l", xlab = bquote(theta), ylab = "Power", main = "n = 20")
abline(v = mu_verd, lty = 1)
abline(h = .05, lty = 1)
plot(mu_test, power_nobs[2,], type = "l", xlab = bquote(theta), ylab = "Power", main = "n = 40")
abline(v = mu_verd, lty = 1)
abline(h = .05, lty = 1)
plot(mu_test, power_nobs[3,], type = "l", xlab = bquote(theta), ylab = "Power", main = "n = 50")
abline(v = mu_verd, lty = 1)
abline(h = .05, lty = 1)
plot(mu_test, power_nobs[4,], type = "l", xlab = bquote(theta), ylab = "Power", main = "n = 100")
abline(v = mu_verd, lty = 1)
abline(h = .05, lty = 1)
