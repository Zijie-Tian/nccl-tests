suffix=".txt"

for dir in ../results/* ; do
    # echo "Processing ${dir}..."
    for file in ${dir}/*.txt ; do
        if [ -f ${file} ] ; then
            name=${file%"$suffix"}

            echo "Processing ${name}..."
            python3 process_data.py -f ${file} -o ${name}.csv
        fi
    done
done