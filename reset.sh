for d in `ls -d */`
 do 
    for f in `ls $d/`
        do 
            if [[ $f != *.cnf ]]; then
              echo "removing $d/$f"
              rm $d/$f
            fi
        done
done