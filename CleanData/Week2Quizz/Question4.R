lines <- readLines("http://biostat.jhsph.edu/~jleek/contact.html")

result <- c(nchar(lines[10]), nchar(lines[20]), nchar(lines[30]), nchar(lines[100]))