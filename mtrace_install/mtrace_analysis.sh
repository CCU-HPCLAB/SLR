#!/usr/bin/bash
p1='3p'
work_path=$(pwd)'/'
p2=$1
compare=$(sed -n $p1 $work_path$p2|awk '{print $2}' )

lengh=$(sed -n $p1 $work_path$p2|awk '{print $1}' )
maxlg=40
charlg="${#lengh}"
if [ `echo "${charlg}  < ${maxlg}" | bc` -eq 1 ]
then


	WC=$(wc -l $work_path$p2 | awk '{print $1}')
	echo ${WC}
	j=1

	for (( k=2; k<=$WC; k )) ; do 
		p1=$k'p'
			add=$(sed -n $p1 $work_path$p2|awk '{print $4}' )
			if [[ "${add}" == "+" ]]
			then      
			       caller=$(sed -n $p1 $work_path$p2|awk '{print $5}' )
		     		arrary[j]=${caller}
		     		mallocsz[j]=${k}
		     		sz[j]=$(sed -n $p1 $work_path$p2|awk '{print $6}' )
		     		j=`expr $j + 1`
	     		fi
		k=`expr $k + 1`
	done

	i=0
	c=1
	for (( k=2; k<=$WC; k )) ; do 
		p1=$k'p'
		negative=$(sed -n $p1 $work_path$p2|awk '{print $4}' )

		if [[ "${negative}" == "-" ]]
		then      
		temp=$(sed -n $p1 $work_path$p2|awk '{print $5}' )
		free[c]=$temp
		temp=0
			for (( l=1; l<=$j; l )) ; do 
				temp=$(sed -n $p1 $work_path$p2|awk '{print $5}' )
				if [[ "${arrary[l]}" == "${temp}" ]]
				then 
					match[i]=${temp}
					i=`expr $i + 1`
					break
				fi
				l=`expr $l + 1`
			done
		c=`expr $c + 1`
	     	fi
		k=`expr $k + 1`
	done

	for (( l=1; l<$c; l )) ; do 
		for (( k=l; k<$c; k )) ; do 
			if [[ "${free[l]}" == "${free[k+1]}" ]]
			then
				echo "double free" : ${free[l]} 
			fi	
		k=`expr $k + 1`
		done
	l=`expr $l + 1`
	done




	h=0
	f=1
	for (( k=1; k<$j; k )) ; do 
		for (( l=0; l<$i; l )) ; do 

			if [[ "${arrary[k]}" == "${match[l]}" ]]
	   		then
	   			
	   			h=`expr $h + 1`			
	   		fi

	   		l=`expr $l + 1`
		done
		if [[ "${h}" == '0' ]]
	   	then	
	   		sz1=${mallocsz[k]}'p'
	   		sz=$(sed -n $sz1 $work_path$p2|awk '{print $6}' )
	   		memory_leak[f]=${arrary[k]}
	   		sortsz[f]=$((num=$sz))
	   		f=`expr $f + 1`

	   	fi
	   	h=0
		k=`expr $k + 1`
	done

	stop=0
	y=`expr $f - 1`
	for (( k=1; k<$f; k )) ; do 
	 for (( a=k; a<$y; a )) ; do
	  if [ `echo "${sortsz[k]} < ${sortsz[a+1]}" | bc` -eq 1 ]
	  then
		stop=${memory_leak[a+1]}
		stop2=${sortsz[a+1]}
		memory_leak[a+1]=${memory_leak[k]}
		sortsz[a+1]=${sortsz[k]}
		memory_leak[k]=${stop}
		sortsz[k]=${stop2}
		stop=0
		stop2=0
		
	  fi
	  a=`expr $a + 1`
	 done
	 k=`expr $k + 1`
	done


	for (( k=1; k<$f; k )) ; do 
	echo "memory leak" : ${memory_leak[k]}
	echo ${sortsz[k]} "byte"
	k=`expr $k + 1`
	done










else

	start1='2p'
	start=$(sed -n $start1 $work_path$p2|awk '{print $2}' )
	if [[ "${start}" != "Start" ]]
	then
		p1='2p'
		compare=$(sed -n $p1 $work_path$p2|awk '{print $3}' )
		echo ${start}
	fi
	WC=$(wc -l $work_path$p2 | awk '{print $1}')
	echo ${WC}
	j=1

	for (( k=4; k<=$WC; k )) ; do 
		p1=$k'p'
		address=$(sed -n $p1 $work_path$p2|awk '{print $3}' )
		if [[ "${address}" == "${compare}" ]]
		then
			add=$(sed -n $p1 $work_path$p2|awk '{print $4}' )
			if [[ "${add}" == "+" ]]
			then      
			       caller=$(sed -n $p1 $work_path$p2|awk '{print $5}' )
		     		arrary[j]=${caller}
		     		mallocsz[j]=${k}
		     		sz[j]=$(sed -n $p1 $work_path$p2|awk '{print $6}' )
		     		j=`expr $j + 1`
	     		fi
		fi
		k=`expr $k + 1`
	done

	i=0
	a=1
	for (( k=4; k<=$WC; k )) ; do 
		p1=$k'p'
		negative=$(sed -n $p1 $work_path$p2|awk '{print $4}' )
		if [[ "${negative}" == "-" ]]
		then      
		       temp=$(sed -n $p1 $work_path$p2|awk '{print $5}' )
		       free[a]=$temp
		       temp=0
			for (( l=1; l<=$j; l )) ; do 
				temp=$(sed -n $p1 $work_path$p2|awk '{print $5}' )
				if [[ "${arrary[l]}" == "${temp}" ]]
				then 
					match[i]=${temp}
					i=`expr $i + 1`
					break
				fi
				l=`expr $l + 1`
			done
			a=`expr $a + 1`
	     	fi
		k=`expr $k + 1`
	done

	for (( l=1; l<$a; l )) ; do 
		for (( k=l; k<$a; k )) ; do 
			if [[ "${free[l]}" == "${free[k+1]}" ]]
			then
				echo "double free" : ${free[l]}
			fi	
		k=`expr $k + 1`
		done
	l=`expr $l + 1`
	done




	h=0
	f=1
	for (( k=1; k<$j; k )) ; do 
		for (( l=0; l<$i; l )) ; do 

			if [[ "${arrary[k]}" == "${match[l]}" ]]
	   		then
	   			
	   			h=`expr $h + 1`			
	   		fi

	   		l=`expr $l + 1`
		done
		if [[ "${h}" == '0' ]]
	   	then	
	   		sz1=${mallocsz[k]}'p'
	   		sz=$(sed -n $sz1 $work_path$p2|awk '{print $6}' )
	   		memory_leak[f]=${arrary[k]}
	   		sortsz[f]=$((num=$sz))
	   		f=`expr $f + 1`

	   	fi
	   	h=0
		k=`expr $k + 1`
	done

	stop=0
	y=`expr $f - 1`
	for (( k=1; k<$f; k )) ; do 
	 for (( a=k; a<$y; a )) ; do
	  if [ `echo "${sortsz[k]} < ${sortsz[a+1]}" | bc` -eq 1 ]
	  then
		stop=${memory_leak[a+1]}
		stop2=${sortsz[a+1]}
		memory_leak[a+1]=${memory_leak[k]}
		sortsz[a+1]=${sortsz[k]}
		memory_leak[k]=${stop}
		sortsz[k]=${stop2}
		stop=0
		stop2=0
		
	  fi
	  a=`expr $a + 1`
	 done
	 k=`expr $k + 1`
	done


	for (( k=1; k<$f; k )) ; do 
	echo "memory leak" : ${memory_leak[k]}
	echo ${sortsz[k]} "byte"
	k=`expr $k + 1`
	done

fi


