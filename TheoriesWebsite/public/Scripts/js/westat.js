var queries = [
    {
        context: 'mobile',
        match: function() {
            //console.log('Mobile callback. Maybe hook up some tel: numbers?');
            $('body').addClass('w-mobile');
        },
        unmatch: function() {
            // We're leaving mobile.
	    $('body').removeClass('w-mobile');
        }
    },
    {
        context: 'phone-portrait',
        match: function() {
            //console.log('entering phone portrait');
            $('body').addClass('w-phone-portrait');
	    $( '[id^="ps-mobile-accordion"]' ).accordion({ collapsible: true, header: ".ps-accordion-head" });
	    $( '[id^="ps-phone-accordion"]' ).accordion({ collapsible: true, header: ".ps-accordion-head" });
        },
        unmatch: function() {
            //console.log('leaving phone portrait!');
            $('body').removeClass('w-phone-portrait');
        }

    },
    {
        context: 'phone-landscape',
        match: function() {
            //console.log('entering phone landscape.');
            $('body').addClass('w-phone-landscape');
	    $( '[id^="ps-mobile-accordion"]' ).accordion({ collapsible: true, header: ".ps-accordion-head" });
	    $( '[id^="ps-phone-accordion"]' ).accordion({ collapsible: true, header: ".ps-accordion-head" });
        },
        unmatch: function() {
            //console.log('leaving phone landscape!');
            $('body').removeClass('w-phone-landscape');
	    $( '[id^="ps-phone-accordion"]' ).accordion( "destroy" );
        }

    },
    {
        context: 'tablet-portrait',
        match: function() {
            //console.log('entering tablet portrait.');
            $('body').addClass('w-tablet-portrait');
	    $( '[id^="ps-mobile-accordion"]' ).accordion({ collapsible: true, header: ".ps-accordion-head" });
	    $( '[id^="ps-portrait-accordion"]' ).accordion({ collapsible: true, header: ".ps-accordion-head" });
        },
        unmatch: function() {
            //console.log('leaving tablet portrait!');
            $('body').removeClass('w-tablet-portrait');
	    $( '[id^="ps-portrait-accordion"]' ).accordion( "destroy" );
	    $( '[id^="ps-mobile-accordion"]' ).accordion( "destroy" );
        }

    },
    {
        context: 'tablet-landscape',
        match: function() {
            //console.log('entering tablet landscape.');
	    //location.once().reload(false);
            $('body').addClass('w-tablet-landscape');
        },
        unmatch: function() {
            //console.log('leaving tablet landscape!');
	    //location.once().reload(false);
            $('body').removeClass('w-tablet-landscape');
        }

    },
    {
        context: 'desktop',
        match: function() {
            //console.log('entering desktop.');
            $('body').addClass('w-desktop');
        },
        unmatch: function() {
            //console.log('leaving desktop!');
            $('body').removeClass('w-desktop');
        }

    }
];
// Go!
MQ.init(queries);
/*!
	wesnav Responsive Mobile Menu
	(c) 2014 Josh Cope
	licensed under MIT
*/

;(function ($, document, window) {
	var
	// default settings object.
	defaults = {
		label: 'MENU',
		//duplicate: true,
		duration: 200,
		easingOpen: 'swing',
		easingClose: 'swing',
		closedSymbol: '&#9658;',
		openedSymbol: '&#9660;',
		prependTo: 'body',
		parentTag: 'a',
		closeOnClick: false,
		allowParentLinks: false,
		init: function(){},
		open: function(){},
		close: function(){}
	},
	mobileMenu = 'wesnav',
	prefix = 'wesnav';
	
	function Plugin( element, options ) {
		this.element = element;

        // jQuery has an extend method which merges the contents of two or
        // more objects, storing the result in the first object. The first object
        // is generally empty as we don't want to alter the default options for
        // future instances of the plugin
        this.settings = $.extend( {}, defaults, options) ;
        
        this._defaults = defaults;
        this._name = mobileMenu;
        
        this.init();
	}
	
	Plugin.prototype.init = function () {
        var $this = this;
		var menu = $(this.element);
		var settings = this.settings;
		
		// clone menu if needed
		if (settings.duplicate) {
			$this.mobileNav = menu.clone();
			//remove ids from clone to prevent css issues
			$this.mobileNav.removeAttr('id');
			$this.mobileNav.find('*').each(function(i,e){
				$(e).removeAttr('id');
			});
		}
		else
			$this.mobileNav = menu;
		
		// styling class for the button
		var iconClass = prefix+'_icon';
		
		if (settings.label == '') {
			iconClass += ' '+prefix+'_no-text';
		}
		
		if (settings.parentTag == 'a') {
			settings.parentTag = 'a href="#"';
		}
		
		// create menu bar
		$this.mobileNav.attr('class', prefix+'_nav');
		var menuBar = $('<div class="'+prefix+'_menu"></div>');
		$this.btn = $('<'+settings.parentTag+' aria-haspopup="true" tabindex="0" class="'+prefix+'_btn '+prefix+'_open"><span class="'+prefix+'_menutxt">'+settings.label+'</span><span class="'+iconClass+'"><span class="'+prefix+'_icon-bar"></span><span class="'+prefix+'_icon-bar"></span><span class="'+prefix+'_icon-bar"></span></span></a>');
		//$(menuBar).append($this.btn);		
		$(settings.prependTo).prepend(menuBar);
		menuBar.append($this.mobileNav);
		
		// iterate over structure adding additional structure
		var items = $this.mobileNav.find('li');
		$(items).each(function () {
			var item = $(this);
			data = {};
			data.children = item.children('ul').attr('role','menu');
			item.data("menu", data);
			
			// if a list item has a nested menu
			if (data.children.length > 0) {
			
				// select all text before the child menu
				var a = item.contents();
				var nodes = [];
				$(a).each(function(){
					if(!$(this).is("ul")) {
						nodes.push(this);
					}
					else {
						return false;
					}
				});
				
				// wrap item text with tag and add classes
				var wrap = $(nodes).wrapAll('<'+settings.parentTag+' role="menuitem" aria-haspopup="true" tabindex="0" class="'+prefix+'_item"/>').parent();
				
				item.addClass(prefix+'_collapsed');
				item.addClass(prefix+'_parent');
				
				// create parent arrow
				$(nodes).last().after('<span class="'+prefix+'_arrow">'+settings.closedSymbol+'</span>');
				
			
			} else if ( item.children().length == 0) {
				 item.addClass(prefix+'_txtnode');
			}
			
			// accessibility for links
			item.children('a').attr('role', 'menuitem').click(function(event){
				//Emulate menu close if set
                //Ensure that it's not a parent
				if (settings.closeOnClick && !$(event.target).parent().closest('li').hasClass(prefix+'_parent'))
					$($this.btn).click();
			});
            
            //also close on click if parent links are set
            if (settings.closeOnClick && settings.allowParentLinks) {
                item.children('a').children('a').click(function(event){
                    //Emulate menu close
                        $($this.btn).click();
                });
            }
		});
		
		// structure is in place, now hide appropriate items
		$(items).each(function () {
			var data = $(this).data("menu");
			$this._visibilityToggle(data.children, false, null, true);
		});
		
		// finally toggle entire menu
		//$this._visibilityToggle($this.mobileNav, false, 'init', true);
		
		// accessibility for menu button
		$this.mobileNav.attr('role','menu');
		
		// outline prevention when using mouse
		$(document).mousedown(function(){
			$this._outlines(false);
		});
		
		$(document).keyup(function(){
			$this._outlines(true);
		});
		
		// menu button click
		$($this.btn).click(function (e) {
			e.preventDefault();
			$this._menuToggle();			
		});
		
		// click on menu parent
		$this.mobileNav.on('click', '.'+prefix+'_item', function(e){
			e.preventDefault();
			$this._itemClick($(this));
		});
		
		// check for enter key on menu button and menu parents
		$($this.btn).keydown(function (e) {
			var ev = e || event;
			if(ev.keyCode == 13) {
				e.preventDefault();
				$this._menuToggle();
			}
		});
		
		$this.mobileNav.on('keydown', '.'+prefix+'_item', function(e) {
			var ev = e || event;
			if(ev.keyCode == 13) {
				e.preventDefault();
				$this._itemClick($(e.target));
			}
		});
		
		// allow links clickable within parent tags if set
		if (settings.allowParentLinks) {
			$('.'+prefix+'_item a').click(function(e){
					e.stopImmediatePropagation();
			});
		}
    };
	
	//toggle menu
	Plugin.prototype._menuToggle = function(el){
		var $this = this;
		var btn = $this.btn;
		var mobileNav = $this.mobileNav;
		
		if (btn.hasClass(prefix+'_collapsed')) {
			btn.removeClass(prefix+'_collapsed');
			btn.addClass(prefix+'_open');
		} else {
			btn.removeClass(prefix+'_open');
			btn.addClass(prefix+'_collapsed');
		}
		btn.addClass(prefix+'_animating');
		$this._visibilityToggle(mobileNav, true, btn);
	}
	
	// toggle clicked items
	Plugin.prototype._itemClick = function(el) {
		var $this = this;
		var settings = $this.settings;
		var data = el.data("menu");
		if (!data) {
			data = {};
			data.arrow = el.children('.'+prefix+'_arrow');
			data.ul = el.next('ul');
			data.parent = el.parent();
			el.data("menu", data);
		}
		if (data.parent.hasClass(prefix+'_collapsed')) {
			data.arrow.html(settings.openedSymbol);
			data.parent.removeClass(prefix+'_collapsed');
			data.parent.addClass(prefix+'_open');
			data.parent.addClass(prefix+'_animating');
			$this._visibilityToggle(data.ul, true, el);
		} else {
			data.arrow.html(settings.closedSymbol);
			data.parent.addClass(prefix+'_collapsed');
			data.parent.removeClass(prefix+'_open');
			data.parent.addClass(prefix+'_animating');
			$this._visibilityToggle(data.ul, true, el);
		}
	}

	// toggle actual visibility and accessibility tags
	Plugin.prototype._visibilityToggle = function(el, animate, trigger, init) {
		var $this = this;
		var settings = $this.settings;
		var items = $this._getActionItems(el);
		var duration = 0;
		if (animate)
			duration = settings.duration;
		
		if (el.hasClass(prefix+'_hidden')) {
			el.removeClass(prefix+'_hidden');
			el.slideDown(duration, settings.easingOpen, function(){
				
				$(trigger).removeClass(prefix+'_animating');
				$(trigger).parent().removeClass(prefix+'_animating');
				
				//Fire open callback
				if (!init) {
					settings.open(trigger);
				}
			});
			el.attr('aria-hidden','false');
			items.attr('tabindex', '0');
			$this._setVisAttr(el, false);
		} else {
			el.addClass(prefix+'_hidden');
			el.slideUp(duration, this.settings.easingClose, function() {
				el.attr('aria-hidden','true');
				items.attr('tabindex', '-1');
				$this._setVisAttr(el, true);
				el.hide(); //jQuery 1.7 bug fix
				
				$(trigger).removeClass(prefix+'_animating');
				$(trigger).parent().removeClass(prefix+'_animating');
				
				//Fire init or close callback
				if (!init)
					settings.close(trigger);
				else if (trigger == 'init')
					settings.init();
			});
		}
	}

	// set attributes of element and children based on visibility
	Plugin.prototype._setVisAttr = function(el, hidden) {
		var $this = this;
		
		// select all parents that aren't hidden
		var nonHidden = el.children('li').children('ul').not('.'+prefix+'_hidden');
		
		// iterate over all items setting appropriate tags
		if (!hidden) {
			nonHidden.each(function(){
				var ul = $(this);
				ul.attr('aria-hidden','false');
				var items = $this._getActionItems(ul);
				items.attr('tabindex', '0');
				$this._setVisAttr(ul, hidden);
			});
		} else {
			nonHidden.each(function(){
				var ul = $(this);
				ul.attr('aria-hidden','true');
				var items = $this._getActionItems(ul);
				items.attr('tabindex', '-1');
				$this._setVisAttr(ul, hidden);
			});
		}
	}

	// get all 1st level items that are clickable
	Plugin.prototype._getActionItems = function(el) {
		var data = el.data("menu");
		if (!data) {
			data = {};
			var items = el.children('li');
			var anchors = items.children('a');
			data.links = anchors.add(items.children('.'+prefix+'_item'));
			el.data("menu", data);
		}
		return data.links;
	}

	Plugin.prototype._outlines = function(state) {
		if (!state) {
			$('.'+prefix+'_item, .'+prefix+'_btn').css('outline','none');
		} else {
			$('.'+prefix+'_item, .'+prefix+'_btn').css('outline','');
		}
	}
	
	Plugin.prototype.toggle = function(){
		$this._menuToggle();
	}
	
	Plugin.prototype.open = function(){
		$this = this;
		if ($this.btn.hasClass(prefix+'_collapsed')) {
			$this._menuToggle();
		}
	}
	
	Plugin.prototype.close = function(){
		$this = this;
		if ($this.btn.hasClass(prefix+'_open')) {
			$this._menuToggle();
		}
	}
	
	$.fn[mobileMenu] = function ( options ) {
		var args = arguments;

		// Is the first parameter an object (options), or was omitted, instantiate a new instance
		if (options === undefined || typeof options === 'object') {
			return this.each(function () {

				// Only allow the plugin to be instantiated once due to methods
				if (!$.data(this, 'plugin_' + mobileMenu)) {

					// if it has no instance, create a new one, pass options to our plugin constructor,
					// and store the plugin instance in the elements jQuery data object.
					$.data(this, 'plugin_' + mobileMenu, new Plugin( this, options ));
				}
			});

		// If is a string and doesn't start with an underscore or 'init' function, treat this as a call to a public method.
		} else if (typeof options === 'string' && options[0] !== '_' && options !== 'init') {

			// Cache the method call to make it possible to return a value
			var returns;

			this.each(function () {
				var instance = $.data(this, 'plugin_' + mobileMenu);

				// Tests that there's already a plugin-instance and checks that the requested public method exists
				if (instance instanceof Plugin && typeof instance[options] === 'function') {

					// Call the method of our plugin instance, and pass it the supplied arguments.
					returns = instance[options].apply( instance, Array.prototype.slice.call( args, 1 ) );
				}
			});

			// If the earlier cached method gives a value back return the value, otherwise return this to preserve chainability.
			return returns !== undefined ? returns : this;
		}
	};
}(jQuery, document, window));

var getQueryString = function (field, url) {
    var href = url ? url : window.location.href;
    var reg = new RegExp('[?&]' + field + '=([^&#]*)', 'i');
    var string = reg.exec(href);
    return string ? string[1] : null;
};

(function ($) {
    $('#skip-link a').click(function(){$('#w-content').attr('tabIndex', -1).focus();})
    if ($( '[id^="ps-accordion"]').length) {
	$( '[id^="ps-accordion"]' ).accordion({ header: ".ps-accordion-head", heightStyle: "content", disabled: true });
	// Getter
	var animate = $('[id^="ps-accordion"]').accordion( "option", "animate" );
	var collapsible = $('[id^="ps-accordion"]').accordion( "option", "collapsible" );
	var disabled = $('[id^="ps-accordion"]').accordion( "option", "disabled" );
	// Setter
	$( '[id^="ps-accordion"]' ).accordion( "option", {animate: 200, collapsible: true, disabled: false} );
    }
    if ($( '[id^="ps-accordion"].w-timeline').length) {
	$( '[id^="ps-accordion"].w-timeline' ).accordion({ collapsible: true, header: ".ps-accordion-head", heightStyle: "content", active: '' });
    }
    setTimeout(function(){
	$('body.theory-detail .wesnav_parent.active.active-trail').removeClass('active active-trail');
    }, 50);

   
    
// Collapsible messages list
    //hide message_body after the first one
    $(".message_list .message_body:gt(0)").hide();
    //hide message li after the 5th
    $(".message_list li:gt(4)").hide();
    //toggle message_body
    $(".message_head").click(function(){
        $(this).next(".message_body").slideToggle(500)
        return false;
    });
    //collapse all messages
    $(".collpase_all_message").click(function(){
        $(".message_body").slideUp(500)
        return false;
    });
    //show all messages
    $(".show_all_message").click(function(){
        $(this).hide()
        $(".show_recent_only").show()
        $(".message_list li:gt(4)").slideDown()
        return false;
    });
    //show recent messages only
    $(".show_recent_only").click(function(){
        $(this).hide()
        $(".show_all_message").show()
        $(".message_list li:gt(4)").slideUp()
        return false;
    });
    
    // slideshow
    if ($('[id^="ps-slider"]').length) {
	$('[id^="ps-slider"]').owlCarousel({
	    navigation : false,
	    slideSpeed : 300,
	    paginationSpeed : 400,
	    singleItem:true,
	    responsive: true,
	    responsiveRefreshRate : 200,
	    responsiveBaseWidth: ".owl-carousel",
	    autoPlay : true,
	    stopOnHover : true,
	    rewindSpeed : 100,
	});
    }

    
// Menu toggle
    if ($('#top-navigation .menu').length) {
	$('#top-navigation .menu').slicknav({
	    prependTo:'#top-navigation .block-content',
	    //'closedSymbol': '<img src="images/downArrowWhite.png">',
	    //'openedSymbol': '<img src="images/topArrowWhite.png">'
	    'closedSymbol': '',
	    'openedSymbol': '',
	    allowParentLinks: "true"
	});
	$('#top-navigation .menu').wesnav({
	    prependTo:'#top-navigation .block-content',
	    //'closedSymbol': '<img src="images/downArrowWhite.png">',
	    //'openedSymbol': '<img src="images/topArrowWhite.png">'
	    'closedSymbol': '',
	    'openedSymbol': '',
	    allowParentLinks: "true"
	});
    }

// Menu active
    $('.slicknav_nav li a, .wesnav_nav li a').each(function(){
        var p = window.location.pathname;
        console.log("p="+p);
        //if (p.indexOf($(this).attr('href')) > -1) {
        if (p.toLowerCase().indexOf($(this).attr('href')) > -1 || p.indexOf($(this).data('sref')) > -1 || p.indexOf($(this).data('eref')) > -1 || p.indexOf($(this).data('tref')) > -1) {
	       $(this).addClass('active');
	       $(this).parents('li').addClass('active active-trail');
	       $(this).parents('li').siblings('li').find('.active').removeClass('active');
	       $(this).parents('li').siblings('li').find('.active-trail').removeClass('active-trail');
       }
    });
   
    $(document).on('mouseleave', '.wesnav_parent', function(e) {
	var h = $(this).find('.wesnav_hidden');
	if (h.length == '') {
	    $(this)
		.removeClass('wesnav_open')
		.addClass('wesnav_collapsed');
	    $(this).find('ul')
		.toggleClass('wesnav_hidden')
		.attr('aria-hidden', true)
		.hide();
	}
    });

// collapsible filters
    $('.filter-menu').click(function(e){
	e.preventDefault;
	$(this).toggleClass('filter-open');
	$(this).parents('.block').toggleClass('inner-open');
        $('.block.collapsible')
	    .toggleClass('expanded')
	    .slideToggle();
    });
    
// Sticky Head
    sticky = function(){
        var leaderHeight = $('body.ps-sticky-head #w-leaderboard').height();
        var headHeight = $('body.ps-sticky-head #w-header').height();
        var navHeight =  $('body.ps-sticky-head #w-navigation').height();
        if ($('#w-leaderboard').length) {
            $('body.ps-sticky-head #w-header').css({'top':parseInt(leaderHeight) + 'px'});
            $('body.ps-sticky-head #w-navigation').css({'top':parseInt(leaderHeight + headHeight) + 'px'});
        } else {
            $('body.ps-sticky-head #w-header').css({'top':0});
            $('body.ps-sticky-head #w-navigation').css({'top':parseInt(headHeight) + 'px'});
        }      
        if ($('#w-highlight').length) {
            $('body.ps-sticky-head #w-highlight').css({'margin-top':parseInt(headHeight + navHeight) + 'px'});
        } else {
            $('body.ps-sticky-head #w-content').css({'margin-top':parseInt(headHeight + navHeight) + 'px'});
        }
    }
    $(window)
        .load(sticky, unifyHeights)
        .resize(sticky, unifyHeights);
    function unifyHeights() {    
	var maxHeight = 0;
	if ($(window).width() > 1028) {
	    $('.region').find('.ps-uniHeight').each(function(){      
		var height = $(this).outerHeight();      
		if ( height > maxHeight ) { maxHeight = height; }    
	    });    
	    $('.ps-uniHeight').css('height', maxHeight);
	}
    }
    
    // Tabs
    if ($('#w-tab').length) {
	$('#w-tab').responsiveTabs({
	    rotate: false,
	    startCollapsed: 'accordion',
	    collapsible: 'accordion',
	    setHash: true,
	    //animation: 'slide',
	    //disabled: [3,4]
	});
    }

/* video in lightbox */
    $("a[rel^='prettyPhoto']").click(function(){
	$('.activeVideo')
	    .attr('tabIndex', '')
	    .removeClass('activeVideo');
	$(this).toggleClass('activeVideo');
    });
    $(".theory-diagram a[rel^='prettyPhoto']").prettyPhoto({
	opacity: 0.30,
	default_width: 480,
	default_height: 270,
	social_tools:false,
	allow_resize: true,
	deeplinking: true,
	keyboard_shortcuts: false,
	modal: true,
	autoplay: true,
	//callback: function(){$('.activeVideo').attr('tabIndex', -1).focus();},
	gallery_markup: '<div class="pp_gallery"> \
				    <a href="#" class="pp_arrow_previous">Previous</a> \
				    <div> \
					    <ul> \
						    {gallery} \
					    </ul> \
				    </div> \
				    <a href="#" class="pp_arrow_next">Next</a> \
			    </div>',
	markup: '<div class="pp_pic_holder"> \
		    <div class="ppt">&nbsp;</div> \
		    <div class="pp_top"> \
			    <div class="pp_left"></div> \
			    <div class="pp_middle"></div> \
			    <div class="pp_right"></div> \
		    </div> \
		    <div class="pp_content_container"> \
			    <div class="pp_left"> \
			    <div class="pp_right"> \
				    <div class="pp_content"> \
					    <div class="pp_loaderIcon"></div> \
					    <div class="pp_fade"> \
						    <a href="#" class="pp_expand" title="Expand the image">Expand</a> \
						    <div class="pp_details"> \
							    <p class="pp_description"></p> \
							    <a class="pp_close" href="#">Close</a> \
						    </div> \
						    <div class="pp_hoverContainer"> \
							    <a class="pp_next" href="#">next</a> \
							    <a class="pp_previous" href="#">previous</a> \
						    </div> \
						    <div id="pp_full_res"></div> \
					    </div> \
				    </div> \
			    </div> \
			    </div> \
		    </div> \
		    <div class="pp_bottom"> \
			    <div class="pp_left"></div> \
			    <div class="pp_middle"></div> \
			    <div class="pp_right"></div> \
		    </div> \
	    </div> \
	    <div class="pp_overlay"></div>',
	changepicturecallback: function(){ initialize(); }
    });
//    $("a[rel^='prettyPhoto']").prettyPhoto({
//	opacity: 0.30,
//	default_width: 480,
//	default_height: 270,
//	social_tools:false,
//	keyboard_shortcuts: false,
//	modal: true,
//	autoplay: true,
//	callback: function(){$('.activeVideo').attr('tabIndex', -1).focus();},
//	changepicturecallback: function(){ initialize(); }
//    });
    function initialize() {
	var vid = $('.pp_content_container').find('video');
	if (vid.length) {
	    vid.mediaelementplayer({
		startLanguage:'en',
		toggleCaptionsButtonWhenOnlyOne:true,
		alwaysShowControls: true,
		success: function(media, node, player) {
		    $('#' + node.id + '-mode').html('mode: ' + media.pluginType);
		    setTimeout(function(){media.play();}, 500); 
		}
	    });
	}
	$('.pp_content').attr('tabIndex', -1).focus();
	if ($('.pp_content object').length) {
	    if ( $.browser.msie ) {
	    } else if ( $.browser.webkit ) {
		$('.pp_content object').attr('tabIndex', 1).focus();
	    } else if ( $.browser.mozilla ) {
		$('.pp_content object').attr('tabIndex', 1);
	    }
	}
    }	
    $(window).keydown(function(e){ 
	if(e.keyCode == "27"){ 
	    $.prettyPhoto.close();
	}
    });
    
/* video not in lightbox */
    if ($('.videoWrapper.ps-no-popup video').length) {
	$('.videoWrapper.ps-no-popup video').mediaelementplayer({
	    startLanguage:'en',
	    toggleCaptionsButtonWhenOnlyOne:true,
	    success: function(media, node, player) {
		$('#' + node.id + '-mode').html('mode: ' + media.pluginType);
	    }
	});
    }
    
// Add your own jQuery here

// Your own jquery ends here 
})(jQuery);