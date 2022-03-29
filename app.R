library(shiny)
library(tidyverse)
library(babynames)

ui <- fluidPage(textInput(inputId = "name", 
                          label = "Name:", 
                          value = "", 
                          placeholder = "Enter Name Here"), 
                sliderInput(inputId = "years", 
                            label = "Years:", 
                            min = 1880, 
                            max = 2017, 
                            value = c(1880, 2017), 
                            sep = "" ), 
                selectInput(inputId = "sex", 
                            label = "Sex:", 
                            choices = c("Female" = "F","Male" = "M")), 
                plotOutput(outputId = "timeplot"))#widgets
server <- function(input, output) {
  output$timeplot <- renderPlot(
    babynames %>% 
      filter(sex == input$sex, 
             name == input$name) %>% 
      ggplot(aes(x = year, y = n)) +
      geom_line() +
      scale_x_continuous(limits = input$years)
  )
} #r code, generate graph, translate input into an output (graph)
shinyApp(ui = ui, server = server) 

#sep removes commas 