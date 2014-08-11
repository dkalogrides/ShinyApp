

library(dplyr)

model <- function(grade) { 
  if(grade=="4") newdata <- data[ which(data$grade==4), ] 
  if(grade=="8") newdata <- data[ which(data$grade==8), ] 
  fixed.dum <-lm(Gap ~ cyr + math + factor(state) -1, data=newdata)
  summary(fixed.dum)
  coef.cyr <- coef(summary(fixed.dum))["cyr","Estimate"]
  coef.cyr  
}

shinyServer(function(input, output, session) {
  yearData <- reactive({
    # Filter to the desired year, and put the columns
    # in the order that Google's Bubble Chart expects
    # them (name, x, y, color, size)
    df <- data %.%
      filter(grade == input$grade) %.%
      select(state, Year, Gap, Subject, Black_Enrollment)     
  })
  
  output$chart <- reactive({
    # Return the data and options
    list(
      data = googleDataTable(yearData()),
      options = list(
        title = sprintf(
          "Achievement Gaps by Year, Grade %s",
          input$grade)
      )
    )
  })
  output$prediction <- renderText({model(input$grade)})
})

