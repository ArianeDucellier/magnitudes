
fluidPage(
  
  titlePanel("Earthquake magnitude scales"),
  
  sidebarLayout(
    
    sidebarPanel(

      p("To study a dataset of earthquakes, it is useful to have all the 
        magnitudes of the earthquakes expressed in the same scale. However, it 
        is not always possible because the different laboratories that record 
        the earthquake have not always used the same magnitude scale. 
        Therefore, it would be useful to have a formula to convert a magnitude 
        from one scale to another."),

      p("The aim of this application is to carry out a linear regression 
      between the magnitude expressed with one scale and the magnitude 
      expressed with another scale, and to evaluate how reliable the regression 
      is. You first have to select two types of magnitude scales. When you 
      click the submit button, the application computes the linear regression 
      model, and gives you the value of the R2 (coefficient of determination) 
      from the linear regression and the value of the R2 computed with a 
      bootstrap method."),

      p("On the graph, the full black line is the regression model, and the 
        circles are the data. The diameters of the circles are proportional to 
        the number of times that rows with the same values are found in the 
        dataset."),

      selectInput("variable1", "Magnitude 1:",
                  c("Duration (Laboratory 1)" = "md_L1",
                    "Duration (Laboratory 2)" = "md_L2",
                    "Duration (Laboratory 3)" = "md_L3",
                    "Moment" = "mw",
                    "Body wave" = "mb",
                    "Surface wave" = "ms",
                    "Local" = "ml"),
                  "ml"),

      selectInput("variable2", "Magnitude 2:",
                  c("Duration (Laboratory 1)" = "md_L1",
                    "Duration (Laboratory 2)" = "md_L2",
                    "Duration (Laboratory 3)" = "md_L3",
                    "Moment" = "mw",
                    "Body wave" = "mb",
                    "Surface wave" = "ms",
                    "Local" = "ml"),
                  "mw")
    ),
    
    mainPanel(

      plotOutput("plot"),

    )
  )
)
