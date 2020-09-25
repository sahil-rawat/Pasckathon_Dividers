var check=function(aadhar_no){
	var a_block;
	const a_split=[];
	var ind=0;
	const days_allowed=[];
	for(var i=0;i<3;i++){
		a_block=aadhar_no.slice(i*4,i*4+4)%7+1
		a_split.push(a_block)
	}
	function count(l){
		var count_n=a_split.filter(i => i===l).length
		return count_n
	}
	while(ind<3){
		var flag=count(a_split[ind])
		while(flag>1){
			a_split[ind]=a_split[ind]+1
			if(a_split[ind]>7){
				a_split[ind]=1
			}
			flag=count(a_split[ind])
		}
		ind=ind+1
	}
	days = 
	{
		1:"Monday",
		2:"Tuesday",
		3:"Wednesday",
		4:"Thursday",
		5:"Friday",
		6:"Saturday",
		7:"Sunday" 
	}
	for(var j=0;j<3;j++){
		days_allowed.push(days[a_split[j]])
	}
	return days_allowed
}

exports.check=check;