
values <- c("-0.0", "0.0", "NaN", "-NaN", "Inf", "-Inf")
operations <- c('==', '!=', '>', '>=', '<', '<=', 'hashCode==')
lang <- 'R'

# Print the table header
cat(paste(c('lang', 'v1', 'v2', operations), collapse = ', '), "\n")

# Iterate over each pair of values
for (v1 in values) {
  for (v2 in values) {
    # Initialize the result string with the language and the pair of values
    result <- paste(c(lang, v1, v2), collapse = ', ')

    # Apply each operation
    for (op in operations) {
      if (op != 'hashCode==') {
        # Evaluate the operation and append the result to the string
        rst <- eval(parse(text = paste0(v1, " ", op, " ", v2)))
        result <- paste(c(result, rst), collapse = ', ')
      } else {
        # Compare the hash codes and append the result to the string
        rst <- digest::digest(v1) == digest::digest(v2)
        result <- paste(c(result, rst), collapse = ', ')
      }
    }

    # Print the result string
    cat(result, "\n")
  }
}



# Print the table header
cat('|', paste(c('lang', 'v1', 'v2', operations), collapse = ' | '), "| \n")

cat('|', paste(rep('---', 10), collapse = ' | '), "| \n")

# Iterate over each pair of values
for (v1 in values) {
  for (v2 in values) {
    # Initialize the result string with the language and the pair of values
    result <- paste(c(lang, v1, v2), collapse = ' | ')

    # Apply each operation
    for (op in operations) {
      if (op != 'hashCode==') {
        # Evaluate the operation and append the result to the string
        rst <- eval(parse(text = paste0(v1, " ", op, " ", v2)))
        result <- paste(c(result, rst), collapse = ' | ')
      } else {
        # Compare the hash codes and append the result to the string
        rst <- digest::digest(v1) == digest::digest(v2)
        result <- paste(c(result, rst), collapse = ' | ')
      }
    }

    # Print the result string
    cat("|", result, "| \n")
  }
}