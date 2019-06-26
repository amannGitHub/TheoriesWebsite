// this file is only used for further development and debugging, but not used otherwise
// the actual code is dynamically inserted in SWFFocus.as

function focusInit() {
	var i,j, k, oE,o,pE,p,st,ti,a,d,s,t, cN, prevId, nextId;
	oE=document.getElementsByTagName('object');
	if(oE.length == 0){
		oE=document.getElementsByTagName('embed');
	}
	for(i=0; i<oE.length; i++){
		o=oE[i];
		if( (o.data || o.src) && o.type=='application/x-shockwave-flash'){
			st=true;
			pE=o.getElementsByTagName('param');
			//for(j=0; j<pE.length; j++){
			//	p=pE[j];
			//	if(p.name.toLowerCase()=='seamlesstabbing'){
			//		if(p.value.toLowerCase()=='false'){
			//			st=false;
			//		}
			//		break;
			//	}
			//}
			//if(o.tagName.toLowerCase() == 'embed'){
			//	if(o.attributes['seamlesstabbing'] 
			//		&& o.attributes['seamlesstabbing'].value.toLowerCase()=='false'){
			//			st=false;
			//	} else {
			//		o.setAttribute('seamlesstabbing','true');
			//	}
			//}
			if(st){
				prevId = nextId = '';
				cN = o.className.split(' ');
				for (k = 0; k < cN.length; k++) {
					if (cN[k].indexOf('swfNext-') != -1)
						nextId = cN[k].substr(8);
					else if (cN[k].indexOf('swfPrev-') != -1)
						prevId = cN[k].substr(8); 
				}
				if (prevId == '') {
					prevId = 'beforeswfanchor'+ i;
					a=document.createElement('a');
					a.id='beforeswfanchor'+i;
					a.href='#';
					a.setAttribute('tabindex',-1);
					a.title='Flash start';
					o.parentNode.insertBefore(a,o);
					
				}
				if (nextId == '') {
					nextId = 'afterswfanchor'+ i;
					a=document.createElement('a');
					a.id= nextId;
					a.href='#';
					a.setAttribute('tabindex',-1);
					a.title='Flash end';
					o.parentNode.insertBefore(a,o.nextSibling);

				}
				o.SWFsetFocusIds(prevId, nextId);
				if (o.getAttribute('tabindex') <= 0)
					o.setAttribute('tabindex', 0);
				o.addEventListener('focus', function(e){e.target.SWFreFocus();},false);
			}
		}
	}
}	

swfobject.addDomLoadEvent(function(){setTimeout(focusInit, 100)});
