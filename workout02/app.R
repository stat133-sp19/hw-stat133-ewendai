#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Functions from Warmup 06

#' @title Future Value Function
#' @description computes the future value of an investment
#' @param amount initial invested amount
#' @param rate annual rate of return
#' @param years number of years
#' @return future value of an investment

future_value = function(amount, rate, years) {
  return(amount * (1 + rate)^years)
}

#' @title Future Value of Annuity
#' @description computes the future value of annuity
#' @param contrib contributed amount
#' @param rate annual rate of return
#' @param years number of years
#' @return future value of annuity

annuity = function(contrib, rate, years) {
  return(contrib * ((1 + rate)^years - 1)/rate)
}

#' @title Future Value of Growing Annuity
#' @description computes the future value of growing annuity
#' @param contrib contributed amount
#' @param rate annual rate of return
#' @param growth annual growth rate
#' @param years number of years
#' @return future value of growing annuity

growing_annuity = function(contrib, rate, growth, years) {
  return(contrib * ((1 + rate)^years - (1 + growth)^years)/(rate - growth))
}

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Saving-Investing Modalities"),
   
   # Slider Inputs
   fluidRow(
     column(4, 
            sliderInput('amount', 'Initial Amount',
                        min = 0, max = 100000, value = 1000, step = 500),
            sliderInput('annualcontrib', 'Annual Contribution',
                        min = 0, max = 50000, value = 2000, step = 500)
            ),
     column(4, 
            sliderInput('returnrate', 'Return Rate (%)',
                        min = 0, max = 20, value = 5, step = 0.1),
            sliderInput('growthrate', 'Growth Rate (%)',
                        min = 0, max = 20, value = 2, step = 0.1)
            ),
     column(4, 
            sliderInput('years', 'Years',
                        min = 0, max = 50, value = 20, step = 1),
            selectInput('facet', 'Facet?',
                        c('Yes', 'No'))
     )
   ),
   
   fluidRow(column(12, h4('Timelines'))),
   
   fluidRow(column(12, plotOutput('timeline'))),
   
   fluidRow(column(12, h4('Balances'))),
   
   fluidRow(column(12, verbatimTextOutput('balances')))
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$timeline <- renderPlot({
      amount = input$amount
      contrib = input$annualcontrib
      r = input$returnrate / 100
      g = input$growthrate / 100
      yr = input$years
      f = input$facet
      
      no_contrib = c()
      fixed_contrib = c()
      growing_contrib = c()
      for (i in 0:yr) {
        no_contrib = c(no_contrib, future_value(amount, r, i))
        fixed_contrib = c(fixed_contrib, future_value(amount, r, i) + annuity(contrib, r, i))
        growing_contrib = c(growing_contrib, future_value(amount, r, i) + growing_annuity(contrib, r, g, i))
      }
      
      if (f == 'Yes') {
        cntrb = matrix(c(c(rep(0:yr, 3)), 
                       c(no_contrib, fixed_contrib, growing_contrib),
                       c(rep('no_contrib', yr + 1), rep('fixed_contrib', yr + 1), rep('growing_contrib', yr + 1))),
                       ncol = 3)
        colnames(cntrb) = c('year', 'balance', 'mode')
        
        cntrb = as.data.frame(cntrb)
        cntrb$year = as.character(cntrb$year)
        cntrb$year = as.integer(cntrb$year)
        cntrb$balance = as.character(cntrb$balance)
        cntrb$balance = as.numeric(cntrb$balance)
        cntrb = cntrb[order(cntrb$year), ]
        
        plt = ggplot(data = cntrb, aes(x = year, y = balance, group = mode, color = mode)) +
          geom_point() + geom_line() + geom_area(aes(x = year, y = balance, fill = mode, alpha = 0.5), show.legend = F) +
          facet_wrap(~mode) + ggtitle("Timeline Graph of Investment Growth by Year") + theme_bw()
        plt
      } else {
        cntrb = matrix(c(0:yr, no_contrib, fixed_contrib, growing_contrib), ncol = 4)
        colnames(cntrb) = c('year', 'no_contrib', 'fixed_contrib', 'growing_contrib')
        cntrb.table = as.table(cntrb)
        cntrb.table
        
        df = as.data.frame(cntrb)
        
        plot(x = df$year, y = df$no_contrib, col = 'red', type = 'l', main = 'Timeline Graph of Investment Growth by Year', xlab = 'Year', ylab = 'Amount', ylim = c(0, max(growing_contrib)))
        #lines(x = df$year, y = df$no_contrib, col = 'red')
        lines(x = df$year, y = df$fixed_contrib, col = 'blue')
        lines(x = df$year, y = df$growing_contrib, col = 'green')
        legend('right', legend = c('no_contrib', 'fixed_contrib', 'growing_contrib'), fill = c('red', 'blue', 'green'))
      }
   })
   
   output$balances <- renderPrint({
     amount = input$amount
     contrib = input$annualcontrib
     r = input$returnrate / 100
     g = input$growthrate / 100
     yr = input$years
     f = input$facet
     
     no_contrib = c()
     fixed_contrib = c()
     growing_contrib = c()
     for (i in 0:yr) {
       no_contrib = c(no_contrib, future_value(amount, r, i))
       fixed_contrib = c(fixed_contrib, future_value(amount, r, i) + annuity(contrib, r, i))
       growing_contrib = c(growing_contrib, future_value(amount, r, i) + growing_annuity(contrib, r, g, i))
     }
     
     cntrb = matrix(c(0:yr, no_contrib, fixed_contrib, growing_contrib), ncol = 4)
     colnames(cntrb) = c('year', 'no_contrib', 'fixed_contrib', 'growing_contrib')
     cntrb = as.data.frame(cntrb)
     cntrb$year = as.character(cntrb$year)
     cntrb$year = as.integer(cntrb$year)
     
     cntrb
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

