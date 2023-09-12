deneme_map <- deneme[, c(4, 6, 5)]

collapsibleTree(deneme_map, hierarchy = c("Class", "Pathway_Name", "Subclass"), collapsed = TRUE)