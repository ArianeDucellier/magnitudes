
library(tidyverse)

server <- function(input, output) {
  
  magnitudes <- read_csv("magnitudes.csv")

  theData = reactive({
    magnitudes %>%
      select(input$variable1, input$variable2) %>%
      rename(x=input$variable1, y=input$variable2)
  })

  labelX = reactive({
    case_when(
      input$variable1 == "md_L1" ~ "Duration magnitude (Laboratory 1)",
      input$variable1 == "md_L2" ~ "Duration magnitude (Laboratory 2)",
      input$variable1 == "md_L3" ~ "Duration magnitude (Laboratory 3)",
      input$variable1 == "mw" ~ "Moment magnitude",
      input$variable1 == "mb" ~ "Body wave magnitude",
      input$variable1 == "ms" ~ "Surface wave magnitude",
      input$variable1 == "ml" ~ "Local magnitude"
    )
  })

  labelY = reactive({
    case_when(
      input$variable2 == "md_L1" ~ "Duration magnitude (Laboratory 1)",
      input$variable2 == "md_L2" ~ "Duration magnitude (Laboratory 2)",
      input$variable2 == "md_L3" ~ "Duration magnitude (Laboratory 3)",
      input$variable2 == "mw" ~ "Moment magnitude",
      input$variable2 == "mb" ~ "Body wave magnitude",
      input$variable2 == "ms" ~ "Surface wave magnitude",
      input$variable2 == "ml" ~ "Local magnitude"
    )
  })

  output$plot <- renderPlot({

    freqData <- theData() %>%
      group_by(x, y) %>%
      summarize(n=n()) %>%
      drop_na()

    model <- lm(y ~ x, data=freqData, weights=n)
    coeff <- summary(model)$coefficients

    ggplot(freqData, aes(x=x, y=y)) +
      scale_size(range=c(2, 20), guide="none") +
      geom_point(aes(color=n, size=n)) +
      geom_abline(intercept=coeff[1],
                  slope=coeff[2],
                  size=1,
                  color="black") +
      geom_abline(intercept=0,
                  slope=1,
                  size=1,
                  linetype="dashed",
                  color="grey25") +
      scale_color_gradient(low="grey25", high="white") +
      coord_cartesian(xlim=c(min(freqData$x), max(freqData$x)),
                      ylim=c(min(freqData$y), max(freqData$y))) +
      xlab(labelX()) +
      ylab(labelY()) +
      theme(axis.text.x=element_text(size=15),
            axis.title.x=element_text(size=15),
            axis.text.y=element_text(size=15),
            axis.title.y=element_text(size=15))
  })

}
