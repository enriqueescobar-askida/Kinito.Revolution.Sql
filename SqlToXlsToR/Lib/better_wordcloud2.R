# Load libraries and data
library(tm)
library(ggplot2)

### Step 1: Load in text data, clean, and analyze overlapping terms
speeches <- Corpus(DirSource("D:/Disk_X/axon/SqlServerProfiler/Data/"))

# Get word counts
obama_wc <- length(unlist(strsplit(speeches[[1]], " ")))
palin_wc <- length(unlist(strsplit(speeches[[2]], " ")))

# Create a Term-Document matrix
stop_list <- c("applause")
speech_specs <- list(stopwords = c(stopwords(),stop_list),
                    removeNumbers = TRUE,
                    removePunctuation = TRUE)
speeches_matrix <- TermDocumentMatrix(speeches,
                                      control = speech_specs)

# Create data frame from matrix
speeches_df <- as.data.frame(inspect(speeches_matrix))
speeches_df <- subset(speeches_df, obama_txt>0 & palin_txt>0)
speeches_df <- transform(speeches_df, freq.dif = obama_txt-palin_txt)

### Step 2: Create values for even y-axis spacing for each vertical
#           grouping of word freqeuncies

# Create separate data frames for each frequency type
obama_df <- subset(speeches_df, freq.dif>0)   # Said more often by Obama
palin_df <- subset(speeches_df, freq.dif<0)   # Said more often by Palin
equal_df <- subset(speeches_df, freq.dif == 0)  # Said equally

# This function takes some number as spaces and returns a vertor
# of continuous values for even spacing centered around zero
optimalSpacing <- function(spaces) {
  if(spaces>1) {
    spacing <- 1/spaces
    if(spaces%%2 > 0) {
      lim <- spacing*floor(spaces/2)
      return(seq(-lim,lim,spacing))
    }
    else {
      lim <- spacing*(spaces-1)
      return(seq(-lim,lim,spacing*2))
    }
  }
  else {
    return(0)
  }
}

# Get spacing for each frequency type
obama_spacing <- sapply(table(obama_df$freq.dif), function(x) optimalSpacing(x))
palin_spacing <- sapply(table(palin_df$freq.dif), function(x) optimalSpacing(x))
equal_spacing <- sapply(table(equal_df$freq.dif), function(x) optimalSpacing(x))

# Add spacing to data frames
obama_optim <- rep(0,nrow(obama_df))
for(n in names(obama_spacing)) {
  obama_optim[which(obama_df$freq.dif == as.numeric(n))] <- obama_spacing[[n]]
}
obama_df <- transform(obama_df, Spacing = obama_optim)

palin_optim <- rep(0,nrow(palin_df))
for(n in names(palin_spacing)) {
  palin_optim[which(palin_df$freq.dif == as.numeric(n))] <- palin_spacing[[n]]
}
palin_df <- transform(palin_df, Spacing = palin_optim)

equal_df$Spacing <- as.vector(equal_spacing)

### Step 3: Create visualization
tucson_wordcloud <-
  ggplot(obama_df,
         aes(x = freq.dif, y = Spacing)) +
  geom_text(aes(size = obama_txt,
            label = row.names(obama_df),
            colour = freq.dif)) +
  geom_text(data = palin_df,
            aes(x = freq.dif, y = Spacing, label = row.names(palin_df), size = palin_txt, color = freq.dif)) +
  geom_text(data = equal_df,
            aes(x = freq.dif, y = Spacing, label = row.names(equal_df), size = obama_txt, color = freq.dif)) +
  scale_size(range = c(3,11),
             name = "Word Frequency") +
  scale_colour_gradient(low = "darkred",
                        high = "darkblue",
                        guide = "none") +
  scale_x_continuous(breaks = c(min(palin_df$freq.dif),
                                0,
                                max(obama_df$freq.dif)),
                     labels = c("Said More by Palin", "Said Equally", "Said More by Obama")) +
  scale_y_continuous(breaks = c(0),
                     labels = c("")) +
  xlab("") +
  ylab("") +
  theme_bw() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        title = element_text("Word Cloud 2.0, Tucson Shooting Speeches (Obama vs. Palin)"));

ggsave(plot = tucson_wordcloud,
       filename = "../Data/tucson_cloud.png",
       width = 13,
       height = 7)

