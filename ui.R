
# More info:
#   https://github.com/jcheng5/googleCharts
# Install:
#   devtools::install_github("jcheng5/googleCharts")
library(googleCharts)

# Use global max/min for axes so the view window stays
# constant as the user moves between years
xlim <- list(
  min = min(data$year),
  max = max(data$year)
)
ylim <- list(
  min = min(data$Gap),
  max = max(data$Gap) 
)

shinyUI(fluidPage(
  # This line loads the Google Charts JS library
  googleChartsInit(),
  
  # Use the Google webfont "Source Sans Pro"
  tags$link(
    href=paste0("http://fonts.googleapis.com/css?",
                "family=Source+Sans+Pro:300,600,300italic"),
    rel="stylesheet", type="text/css"),
  tags$style(type="text/css",
             "body {font-family: 'Source Sans Pro'}"
  ),
  
  h2("White-Black Achievement Gaps by State"),
  h3("National Assessment of Educational Progress, 1992-2011"),
  
  googleBubbleChart("chart",
                    width="100%", height = "475px",
                    # Set the default options for this chart; they can be
                    # overridden in server.R on a per-update basis. See
                    # https://developers.google.com/chart/interactive/docs/gallery/bubblechart
                    # for option documentation.
                    options = list(
                      fontName = "Source Sans Pro",
                      fontSize = 13,
                      # Set axis labels and ranges
                      hAxis = list(
                        title = "Year",
                        viewWindow = xlim
                      ),
                      vAxis = list(
                        title = "Achievement Gap",
                        viewWindow = ylim
                      ),
                      # The default padding is a little too spaced out
                      chartArea = list(
                        top = 50, left = 75,
                        height = "75%", width = "75%"
                      ),
                      # Allow pan/zoom
                      explorer = list(),
                      # Set bubble visual props
                      bubble = list(
                        opacity = 0.4, stroke = "none",
                        # Hide bubble label
                        textStyle = list(
                          color = "none"
                        )
                      ),
                      # Set fonts
                      titleTextStyle = list(
                        fontSize = 16
                      ),
                      tooltip = list(
                        textStyle = list(
                          fontSize = 12
                        )
                      )
                    )
  ),
  fluidRow(
           radioButtons("grade", "Grade",
                choices = list("4th Grade" = 4, "8th Grade" = 8)), 
           h4("Average Annual Within-State Change in the Gap = "), 
           verbatimTextOutput("prediction"),  
           p("Notes: Gaps refect the standard deviation difference in test scores
            between white students and black students. The average annual within state
            change in the gap is computed from a model that predicts the gap as 
            a function of test year, test subject, and state fixed effects. The 
            year coefficient is displayed above. Users can see results for 4th and 8th 
            graders by clicking on the grade buttons. Data are from the National
            Assessment of Educational Progress, conducted by the National Center
            for Educational Statistics. For more information, see:",
            a("http://nces.ed.gov/nationsreportcard/", href="http://nces.ed.gov/nationsreportcard/"),  
            "The size of the bubbles
            corresponds to the size of the black population in each state. 
            Information on black enrollments was obtained from the Common Core of 
            Data. For more information, see:", 
            a("http://nces.ed.gov/ccd/", href = "http://nces.ed.gov/ccd/"))
           
  )
))



