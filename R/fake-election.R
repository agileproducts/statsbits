# playing with fake election data which looks like
# Year,Party,Male (millions of votes),Female (millions of votes)
# 2005,Blue Party,4.5,3.5
# 2005,Red Party,4.5,5.5
# 2005,Yellow Party,2.5,1.5
# 2009,Blue Party,5,5
# 2009,Red Party,5,4
# 2009,Yellow Party,3,4
# etc

#read the data into a frame from a csv where the working directory is /R
elections.results <- read.csv("../data/fake-election-data.csv", 
                            header=TRUE, 
                            sep=",",
                            col.names=c("Year","Party","Male","Female"))

#see how this data is structured
str(elections.results)

#add a sum total column to the data frame
elections.results$Total <- (elections.results$Male + elections.results$Female)

#get total votes cast in each election using base R
elections.totalvotes <- aggregate(Total ~ Year, data = elections.results, sum)
elections.totalvotes

#get total votes by sex in each election
elections.gendervotes <- aggregate(cbind(Male,Female) ~ Year, data = elections.results, sum)
elections.gendervotes

#base R barplot
barplot(elections.totalvotes$Total,
        names.arg = elections.totalvotes$Year,
        main="Total votes cast in elections",
        ylab="millions of votes",
        col = c("#CCCCCC"))

#base R grouped barplot
#in order to group or stack bars data needs to be converted to a matrix like this:
#    2005 2009 2013 2017
#[1] (male numbers)
#[2] (female numbers)
#https://stackoverflow.com/questions/20349929/stacked-bar-plot-in-r
gendercounts <- as.matrix(elections.gendervotes[2:3]) #convert to matrix
barplot(t(gendercounts), #transpose
        names.arg = elections.gendervotes$Year,
        beside = TRUE,
        main="Total votes cast in elections by Sex",
        ylab="millions of votes",
        legend.text=TRUE,
        args.legend = list(x = 'topright', bty = 'n', inset=c(0.5,1.2)))




