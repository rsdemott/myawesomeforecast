

gflu = read.csv("http://www.google.org/flutrends/about/data/flu/us/data.txt",
                skip = 11)

y = ts(gflu$Massachusetts)  #ts is a structure in r with time series info

# ARIMA - auto-regressive integrated moving average - look at time lags in the past to forecast the next step

arima_model = arima(y, order = c(3,0,1)) # order is number of lag numbers to look at 

forecast = predict(arima_model, n.ahead = 10)   # n.ahead is number of steps ahead to forecast




jpeg("forecast_plot.jpg")
plot(y, type="l", ylab="Flu Index", lwd=2, xlim=c(540,640), ylim=c(0,4000))
lines(forecast$pred, col="dodgerblue2", lwd=2)
dev.off()


predictions = data.frame(time = time(forecast$pred),
                         prediction = forecast$pred,
                         stde = forecast$se)
write.csv(predictions, "predictions.csv", row.names=F)






