values = ["-0.0", "0.0", "NaN", "-NaN", "Inf", "-Inf"]
operations = ["==", "!=", ">", ">=", "<", "<=", "hash==", "isequal"]
lang = "Julia"

# Print the table header
println("| ", join([lang, "v1", "v2", operations...], " | "), " |")
println("| ", join(fill("---", 10), " | "), " |")

# Iterate over each pair of values
for v1 in values
    for v2 in values
        # Initialize the result array with the language and the pair of values
        result = [lang, v1, v2]

        # Apply each operation
        for op in operations
            if op == "hash=="
                # Compare the hash codes and append the result to the array
                push!(result, string(hash(v1) == hash(v2)))
            elseif op == "isequal"
                # Compare the values using the isequal function and append the result to the array
                push!(result, string(isequal(v1, v2)))
            else
                # Evaluate the operation and append the result to the array
                push!(result, string(eval(Meta.parse("$(v1) $(op) $(v2)"))))
            end
        end

        # Print the result array
        println("| ", join(result, " | "), " |")
    end
end