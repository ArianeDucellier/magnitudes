library(tidyverse)

magnitudes <- read_csv("../magnitudes.csv")

computeR2 <- function(data) {
  freqData <- data %>%
              group_by(scale1, scale2) %>%
              summarize(n=n()) %>%
              drop_na()
  model <- lm(scale2 ~ scale1, data=freqData, weights=n)
  R2 <- summary(model)$r.squared
  return(R2)
}

R2bootstrap <- function(data, N) {
  R2 <-rep(0, N)
  freqData <- data %>%
              group_by(scale1, scale2) %>%
              summarize(n=n()) %>%
              drop_na() %>%
              as.data.frame()
  for (i in 1:N){
    indices_train <- sample.int(nrow(freqData), replace = TRUE)
    indices_test <- c(1:nrow(freqData))[!c(1:nrow(freqData)) %in% i_train]
    train <- slice(freqData, indices_train)
    test <- slice(freqData, indices_test)
    model <- lm(scale2 ~ scale1, data=train, weights=n)
    yhat <- predict(model, test)
    R2[i] <- 1 - sum((test$scale2 - yhat)^2) / 
                 sum((test$scale2 - mean(test$scale))^2)
  }
  return(mean(R2))
}

drawPlot <- function(name1, name2, data) {
  freqData <- data %>%
              group_by(scale1, scale2) %>%
              summarize(n=n()) %>%
              drop_na()
#  model <- lm(scale2 ~ scale1, data=freqData, weights=n)
#  coeff <- summary(model)$coefficients
  g <- ggplot(freqData, aes(x=scale1, y=scale2))
  g <- g + scale_size(range=c(2, 20), guide="none")
  g <- g + geom_point(aes(color=n, size=n))
  g <- g + scale_color_gradient(low="grey25", high="white")                    
#  g <- g + geom_abline(intercept=coef(model)[1],
#                       slope=coef(fit)[2],
#                       size=1,
#                       color="red")
#  g <- g + geom_abline(intercept=0,
#                       slope=1,
#                       size=1,
#                       linetype="dashed",
#                       color="grey25")
  g <- g + coord_cartesian(xlim=c(min(freqData$scale1), max(freqData$scale1)),
                           ylim=c(min(freqData$scale2), max(freqData$scale2)))
  g <- g + labs(title="Comparison between two magnitude scales",
                x=name1,
                y=name2)
  g
}

function(input, output) {

  data <- reactive({
          magnitudes %>%
          select(input$mag1, input$mag2) %>%
          rename(scale1=input$mag1, scale2=input$mag2)
  })
 
  output$text1 <- renderPrint({
      get(input$mag1)})
#                  computeR2(data())})

  output$text2 <- renderPrint({
      get(input$mag2)})
#                  R2bootstrap(data(), 50)})

#  output$myPlot <- renderPlot({
#                   drawPlot(input$mag1, input$mag2, data())})
}
