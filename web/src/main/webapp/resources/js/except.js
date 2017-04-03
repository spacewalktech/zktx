function StringBuffer(){ 
this.content = new Array; 
} 
StringBuffer.prototype.append = function( str ){ 
this.content.push( str ); 
} 
StringBuffer.prototype.toString = function(){ 
return this.content.join(""); 
} 