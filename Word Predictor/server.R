#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(stringr)

library(stringi)

library(gsubfn)

library(tm)

fourgrams <- subset_fourgrams
trigrams <- subset_trigrams
bigrams <- subset_bigrams

shinyServer(function(input, output) {
    
    clean_text <- reactive ({ cleanup(input$text)})
    
    the_output <- reactive ({
        fourgram_candidates(clean_text()) 
    })
    
    output$value <- renderText({ the_output() })
    
    cleanup <- function (the_text) {
        
        cleaned <- stri_trim_both(
            stripWhitespace(
                stri_trans_tolower(
                    str_replace_all(
                        the_text, 
                        "[^[A-Za-z ]]", ""
                    )
                )
            )
        )
        # cat("Cleaned input: ", cleaned, "\n")
        cleaned
    }
    
    fourgram_candidates <- function (input_string){
        input <- word(input_string, -3, -1)
        # cat("fourgram input:", input, "\n")
        # cat("nrow(fourgrams): ", nrow(fourgrams), "\n")
        the_row <- fourgrams[fourgrams$starts == input, ]
        # cat("nrow(the_row): ", nrow(the_row), "\n")
        if (nrow(the_row) > 0 & !is.na(input))  {
            the_row <- the_row[which.max(the_row$count), ]
            as.character(the_row$ends)
        }
        else  {
            trigram_candidates(input_string)
        }
    }      
    
    trigram_candidates <- function (input_string){
        input <- word(input_string, -2, -1)
        # cat("trigram input:", input, "\n")
        the_row <- trigrams[trigrams$starts == input, ]
        if (nrow(the_row) > 0 & !is.na(input))  {
            the_row <- the_row[which.max(the_row$count), ]
            as.character(the_row$ends)
        }
        else  {
            bigram_candidates(input_string)
        }
    }
    
    bigram_candidates <- function (input_string){
        input <- word(input_string, -1)
        # cat("bigram input:", input, "\n")
        the_row <- bigrams[bigrams$starts == input, ]
        if (nrow(the_row) > 0 & !is.na(input))  {
            the_row <- the_row[which.max(the_row$count), ]
            as.character(the_row$ends)
        }
        else  {
            "the"
        }
    }
    
})