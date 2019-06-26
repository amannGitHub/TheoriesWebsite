(function(i){function p(){return Array.prototype.slice.call(arguments,1)}var n=i.pick,m=i.wrap,q=i.extend,o=HighchartsAdapter.fireEvent,k=i.Axis,r=i.Series;q(k.prototype,{isInBreak:function(h,f){var c=h.repeat||Infinity,b=h.from,a=h.to-h.from,c=f>=b?(f-b)%c:c-(b-f)%c;return h.inclusive?c<=a:c<a&&c!==0},isInAnyBreak:function(h,f){var c=this.options.breaks,b=c&&c.length,a,d,e;if(b){for(;b--;)this.isInBreak(c[b],h)&&(a=!0,d||(d=n(c[b].showPoints,this.isXAxis?!1:!0)));e=a&&f?a&&!d:a}return e}});m(k.prototype,
"setTickPositions",function(h){h.apply(this,Array.prototype.slice.call(arguments,1));if(this.options.breaks){var f=this.tickPositions,c=this.tickPositions.info,b=[],a;for(a=0;a<f.length;a++)this.isInAnyBreak(f[a])||b.push(f[a]);this.tickPositions=b;this.tickPositions.info=c}});m(k.prototype,"init",function(h,f,c){if(c.breaks&&c.breaks.length)c.ordinal=!1;h.call(this,f,c);if(this.options.breaks){var b=this;b.doPostTranslate=!0;this.val2lin=function(a){var d=a,e,c;for(c=0;c<b.breakArray.length;c++)if(e=
b.breakArray[c],e.to<=a)d-=e.len;else if(e.from>=a)break;else if(b.isInBreak(e,a)){d-=a-e.from;break}return d};this.lin2val=function(a){var d,e;for(e=0;e<b.breakArray.length;e++)if(d=b.breakArray[e],d.from>=a)break;else d.to<a?a+=d.len:b.isInBreak(d,a)&&(a+=d.len);return a};this.setExtremes=function(a,b,e,c,f){for(;this.isInAnyBreak(a);)a-=this.closestPointRange;for(;this.isInAnyBreak(b);)b-=this.closestPointRange;k.prototype.setExtremes.call(this,a,b,e,c,f)};this.setAxisTranslation=function(a){k.prototype.setAxisTranslation.call(this,
a);var d=b.options.breaks,a=[],e=[],c=0,f,g,h=b.userMin||b.min,l=b.userMax||b.max,j,i;for(i in d)g=d[i],f=g.repeat||Infinity,b.isInBreak(g,h)&&(h+=g.to%f-h%f),b.isInBreak(g,l)&&(l-=l%f-g.from%f);for(i in d){g=d[i];j=g.from;for(f=g.repeat||Infinity;j-f>h;)j-=f;for(;j<h;)j+=f;for(;j<l;j+=f)a.push({value:j,move:"in"}),a.push({value:j+(g.to-g.from),move:"out",size:g.breakSize})}a.sort(function(a,b){return a.value===b.value?(a.move==="in"?0:1)-(b.move==="in"?0:1):a.value-b.value});d=0;j=h;for(i in a){g=
a[i];d+=g.move==="in"?1:-1;if(d===1&&g.move==="in")j=g.value;d===0&&(e.push({from:j,to:g.value,len:g.value-j-(g.size||0)}),c+=g.value-j-(g.size||0))}b.breakArray=e;o(b,"afterBreaks");b.transA*=(l-b.min)/(l-h-c);b.min=h;b.max=l}}});m(r.prototype,"generatePoints",function(h){h.apply(this,p(arguments));var f=this.xAxis,c=this.yAxis,b=this.points,a,d=b.length,e=this.options.connectNulls,i;if(f&&c&&(f.options.breaks||c.options.breaks))for(;d--;)if(a=b[d],i=a.y===null&&e===!1,!i&&(f.isInAnyBreak(a.x,!0)||
c.isInAnyBreak(a.y,!0)))b.splice(d,1),this.data[d]&&this.data[d].destroyElements()});m(i.seriesTypes.column.prototype,"drawPoints",function(h){h.apply(this);var h=this.points,f=this.yAxis,c=f.breakArray||[],b=n(this.options.threshold,f.min),a,d,e,i,k,g;for(i=0;i<h.length;i++){d=h[i];g=d.stackY||d.y;for(k=0;k<c.length;k++){e=c[k];a=!1;if(b<e.from&&g>e.to||b>e.from&&g<e.from)a="pointBreak";else if(b<e.from&&g>e.from&&g<e.to||b>e.from&&g>e.to&&g<e.from)a="pointInBreak";a&&o(f,a,{point:d,brk:e})}}})})(Highcharts);