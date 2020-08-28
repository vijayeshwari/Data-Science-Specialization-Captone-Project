#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shinythemes)
options(shiny.deprecation.messages=FALSE)
shinyUI(
    navbarPage("Next Word Prediction",
               theme = shinytheme("spacelab"),
               tabPanel("Home",
    fluidPage( 
        
        #titlePanel("Predict-A-Tron 3000"),
        #tags$div("Predict-A-Tron 3000", class='jumbotron'),
        
        tags$div(
            style='background-image: url("stone_dude.jpg"); background-size: 100%; background-repeat: no-repeat; position: absolute; top:0; bottom:0; left:0; right:0;'
        ),
        fluidRow(column(1, ""), 
                 column(11, h1("Next Word Predictor..!!", style="color: black"))),
        fluidRow(column(1, ""), 
                 column(11, textInput("text", 
                                      label = p("Enter some text and click the button to predict your next word!", 
                                                style="color: black;"),
                                      value = ""))),
        fluidRow(column(1, ""), column(11, submitButton(text = "Predict Next Word!", icon = NULL))),
        fluidRow(column(1, ""), 
                 column(3, 
                        h3(textOutput("value"), 
                           style="background-color:white; padding: 20px 20px 20px 20px;color: #666;font-weight: 500; border: solid 2px;")) , 
                 column(8, "")))),
        #fluidRow(column(1, ""), column(4, verbatimTextOutput("value")), column(7, ""))
        # fluidRow(column(1, ""), column(8, img(src = "stone_dude.jpg")))
        tabPanel("About",
                 h3("About this application"),
                 br(),
                 div("Next Word Predict is a Shiny app that uses a text
                            prediction algorithm to predict the  next word(s)
                            based on text entered by a user.",
                     br(),
                     br(),
                     "The predicted next word will be shown when the app
                            detects that you have finished typing one or more
                            words. When entering text, please allow a few
                            seconds for the output to appear.",
                     br(),
                     br(),
                     "Use the slider tool to select up to three next
                            word predictions. The top prediction will be
                            shown first followed by the second and third likely
                            next words.",
                     
                 ))
    )
)


