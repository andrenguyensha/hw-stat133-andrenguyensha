#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyr)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Investment Calculator"),
  
  fluidRow(
    column(4,
           sliderInput("initial",
                       label = h5("Initial Amount"),
                       min = 0, 
                       max = 100000,
                       step = 500,
                       value = 1000)
    ),
    
    column(4,
           sliderInput("return",
                       label = h5("Return Rate (in %)"),
                       min = 0, 
                       max = 20,
                       step = 0.1,
                       value = 5)
    ),
    
    column(4,
           sliderInput("years",
                       label = h5("Years"),
                       min = 0, 
                       max = 50,
                       step = 1,
                       value = 20)
    ),
    
    column(4,
           sliderInput("annual",
                       label = h5("Annual Contribution"),
                       min = 0, 
                       max = 50000,
                       step = 500,
                       value = 2000)
    ),
    
    column(4,
           sliderInput("growth",
                       label = h5("Growth Rate (in %)"),
                       min = 0, 
                       max = 20,
                       step = 0.1,
                       value = 2)
    ), 
    
    column(4,
           selectInput("facet",
                       "Facet?",
                       c("No",
                         c("Yes")))
    )),

  hr(),

  h1("Timelines"),

  plotOutput("timelines"),

  h2("Balances"),

  verbatimTextOutput("balances")

)



# Define server logic required to draw a histogram

server <- function(input, output) {
  
  #' @title Future Value Function
  #' @description Computes future value of an investment
  #' @param amount numeric, initial invested amount
  #' @param rate numeric, annual rate of return
  #' @param years number of years
  #' @return expected amount of dollars at the end of the period of time. 
  
  future_value <- function(amount, rate, years) {
    fv<- amount*(1+rate)^years
    return(fv)
  }
  
  
  #' @title Future Value of Annuity
  #' @description Computes future value of annuity, using contribution, annual rate of return, and time
  #' @param contrib numeric, contributed amount
  #' @param rate numeric, annual rate of return
  #' @param years number of years
  #' @return expected balance at the end of the period of time. 
  
  annuity <- function(contrib, rate, years) {
    fva<- contrib*((1+rate)^years-1)/rate
    return(fva)
  }
  
  #' @title Future Value of Growing Annuity
  #' @description Computes future value of growing annuity, using contribution, annual rate of return, growth rate, and time
  #' @param contrib numeric, initial contribution
  #' @param rate numeric, annual rate of return
  #' @param growth numeric, growth rate 
  #' @param years number of years
  #' @return expected balance at the end of the period of time. 
  
  growing_annuity <- function(contrib, rate, growth, years) {
    fvga <- contrib*((1+rate)^years - (1+growth)^years)/(rate - growth)
    return(fvga)
  }
  
  #reactive function: takes input values and expression has results saved
  modalities <- reactive({
    data.frame(year = 0:input$years,
               no_contrib = future_value(input$initial, input$return / 100, 0:input$years),
               fixed_contrib = future_value(input$initial, input$return / 100, 0:input$years) +
                 annuity(input$annual, input$return / 100, 0:input$years),
               growing_contrib = future_value(input$initial, input$return / 100, 0:input$years) +
                 growing_annuity(input$annual, input$return / 100, input$growth / 100, 0:input$years))
  })
  
  output$timelines <- renderPlot({
    modalitiesgather <- gather(modalities(), "modality", "investment", no_contrib:growing_contrib)
    modalitiesgather[["modality"]] <- factor(modalitiesgather[["modality"]],
                                                levels = c("no_contrib", "fixed_contrib", "growing_contrib"))
    if (input$facet == "Yes") {
      ggplot(data = modalitiesgather, aes(x = year, y = investment,
        color = modality, fill = modality)) + geom_line(size = 1) +
        geom_point(size = 2) + geom_area(alpha = 0.5) +
        labs(title = bquote("Three modes of investing"),
             x = bquote("year"), y = bquote("value")) +
        facet_wrap( ~ modality) +
        scale_fill_discrete(breaks = c("no_contrib", "fixed_contrib", "growing_contrib"))
    } else {
      ggplot(data = modalitiesgather, aes(x = year, y = investment, color = modality)) + geom_line(size = 1) +
        geom_point(size = 2) + labs(title = bquote("Three modes of investing"),
             x = bquote("year"), y = bquote("value"))
    }
  })
  
  output$balances <- renderPrint({
    modalities()
  })
}

# Run the application 
shinyApp(ui = ui, server = server)