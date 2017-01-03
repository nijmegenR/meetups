library("tabulizer")
library("tidyr")
library("dplyr")

## Read pdf from http://www.nijmegen.nl/gns/index/adressen/Lijst_openbare_ruimten.pdf
out <- extract_tables("Lijst_openbare_ruimten.pdf", guess = FALSE, method = "data.frame")

## Result is a list of data frames (one for each page). Data frame #54 is untypical and must be converted
out[54][[1]] <- rename(out[54][[1]], X.5 = X.4)
out[54][[1]] <- separate(out[54][[1]],
                         Adressenoverzicht,
                         into = c("Adressenoverzicht", "X.4"),
                         sep = "(?=Nijmegen)")
## All data frames are combined into one
wijkenDF <- out[1][[1]]

for (i in c(2:length(out))) {
  
  tryCatch({
  cat(i," ")
  wijkenDF <- rbind(wijkenDF, out[i][[1]])
  }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
}

## One column contains a string with multiple variables and should be split into multiple columns
wijkenDF <- separate(wijkenDF, Adressenoverzicht, into = c("Postcode", "Wijk"), sep = "-")
wijkenDF <- separate(wijkenDF, Postcode,
                     into = c("Postcode", "Wijknr"),
                     sep = "(?<=[A-Z]) ?(?=[0-9])")

## Write data to csv file
write.csv(wijkenDF, "wijken.csv")

