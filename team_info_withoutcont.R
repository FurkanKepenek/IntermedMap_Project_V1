library(shiny)
library(DiagrammeR)

ui <- fluidPage(
  titlePanel("team"),
  mainPanel(
    grVizOutput("orgChart")
  )
)

server <- function(input, output) {
  output$orgChart <- renderGrViz({
    grViz("digraph {
      node [shape = 'rectangle'];
      Advisor [label = 'Advisor: Alaattin Şen'];
      BioinformaticsTeam [label = 'Bioinformatics Team'];
      ContentTeam [label = 'Content Team'];
      İremKahveci [label = 'İrem Kahveci'];
      HFKepenek [label = 'Hamdi Furkan Kepenek'];
      MEKorkmaz [label = 'Mustafa Emre Korkmaz'];
      
      Advisor -> {BioinformaticsTeam ContentTeam};
      BioinformaticsTeam -> {İremKahveci HFKepenek MEKorkmaz};
    }")
  })
}

shinyApp(ui = ui, server = server)
