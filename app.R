library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(tidyverse)
library(waiter)

source('theme.R')

# Define UI ----
ui <- dashboardPage(
  title = 'Dashboard Title',
  preloader = list(html = tagList(spin_solar(), "Loading..."), color = "#242c34"),
  
  header = dashboardHeader(
    title = 'Header Title'
  ),
  
  sidebar = dashboardSidebar(
    
    sidebarMenu(
      id = 'tabs',
      
      menuItem("Introduction", tabName = "Introduction")  
    )
    
  ),
  
  body = dashboardBody(
    
    # use fresh theme (defined in theme.R)
    use_theme(mytheme),
    
    tags$script(HTML("$('body').addClass('fixed');")),
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
    
    autoWaiter(html = spin_loader(), color = 'transparent'),
    
    tabItems(
      tabItem(tabName = 'Introduction',
              fixedRow(
                column(width = 6,
                       h2('Tab Item Title', align = 'center')
                )
              ),
              fixedRow(
                column(width = 6,
                       selectizeInput(inputId = 'plot1',
                                      'Template plot',
                                      choices = 'template'),
                       imageOutput('plot1')
                )
              )
      )
    )
  ),
  controlbar = dashboardControlbar(collapsed = FALSE, skinSelector())
)

server <- function(input, output) { 
  
  output$plot1 <- renderImage({
    list(
      src = file.path("media/", paste0(input$plot1, ".png")),
      contentType = "image/png",
      width = 400,
      height = 400
    )
  }, deleteFile = FALSE)
  
}

shinyApp(ui, server)

