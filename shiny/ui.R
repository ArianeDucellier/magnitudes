shinyUI(
    pageWithSidebar(
        headerPanel("Comparison of earthquake magnitude scales"),
        sidebarPanel(
          selectInput("mag1", "First scale of magnitude",
                      c("Duration (Laboratory 1)" = "md_L1",
                        "Duration (Laboratory 2)" = "md_L2",
                        "Duration (Laboratory 3)" = "md_L3",
                        "Moment" = "mw",
                        "Body wave" = "mb",
                        "Surface wave" = "ms",
                        "Local" = "ml")),
          selectInput("mag2", "Second scale of magnitude",
                      c("Duration (Laboratory 1)" = "md_L1",
                        "Duration (Laboratory 2)" = "md_L2",
                        "Duration (Laboratory 3)" = "md_L3",
                        "Moment" = "mw",
                        "Body wave" = "mb",
                        "Surface wave" = "ms",
                        "Local" = "ml")),
          submitButton('Submit'),
          h4("R2 from the linear regression"),
          textOutput("text1"),
          h4("R2 from the bootstrap"),
          textOutput("text2")
        ),
        mainPanel(
#            plotOutput('myPlot')
        )
    )
)
