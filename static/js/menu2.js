/*
bluewater-manual OS menu2.js.css by © 2006-2009 Harald Holt (h2) & © 2006-2010 Trevor Walkley (bluewater)(trevor_walkley at aptenodytes.org) and Copyright: © 2008-2009 manul <vnaskov@gmail.com> , released under GNU Free Documentation License.Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.2 or any later version published by the Free Software Foundation; with no Invariant Sections, with no Front-Cover Texts, and with no Back-Cover Texts..

Last updated by bluewater 15/03/2009 UTC

*/

/********************************************
Show hide / DropMenu functions
********************************************/
// initialize variables
var count_div_ids = 30;// this is max number of ids for either dropmenus or onoff items
var timerID = null;
var timerOn = false;
var timecount = 550;// Change this to the time delay that you want
var drop_id = 'sm';// this needs to be global for setTimeout
var dom = ( document.getElementById ) ? document.getElementById : false;

/*
Main showHide control function, needs the item id and number, like dropMenu + 2
these will be either conctatenated or used directly for other functions called
*/
function showHide( menuNumber )
{
	if ( dom )
	{
		full_ID = drop_id + menuNumber;
		hideAll();
		showElement ( full_ID );
		stopTime();
	}
}


/* helper function to eventually fix the top pos of submenu after it appears;
so its top part is always within the page, and does not get cut out
see showElement() function, from where it is called
fix by Copyright: © 2008-2009 manul <vnaskov@gmail.com>
*/
function fix_sm_PosTop( obj ) {
	var curTopMargin = obj.offsetParent.offsetTop + obj.offsetTop;
	if(curTopMargin<0) {
		//must fix this sm guy; set his position to adjust once and forever;
		obj.style.position="absolute";
		var newtop=-obj.offsetParent.offsetTop.toString() + 'px';
		obj.style.top=newtop;
		obj.style.zIndex=+10;
	}
}


/*
Toggles the element visibility/display to visible/block
*/
function showElement( full_ID ) {
	if ( dom )
	{
		if ( document.getElementById( full_ID )	)// test to make sure element id exists
		{
			document.getElementById( full_ID ).style.display="block";
			//next line fix by Copyright: © 2008-2009 manul <vnaskov@gmail.com>
			fix_sm_PosTop(document.getElementById( full_ID ));
		}
	}
}

/*
The hideElement function is almost identical to the showElement function in it�s working,
except that it changes the visibility/display property to hidden/none.
*/
function hideElement( full_item_id ) {
	if ( dom )
	{
		if ( document.getElementById( full_item_id )	)// test to make sure element id exists
		{
			document.getElementById( full_item_id ).style.display="none";
		}
	}
}

/*
This function allows us to hide every element used the menu system at one time. This means
that we can make sure that all elements are turned off, before making the appropriate element
visible. All you need to do is call the hideElement function for each element used in your
menu system.
*/
function hideAll()
{
	if ( dom )
	{
		for (i = 0; i < count_div_ids ; i++)
		{
			full_item_id = drop_id + i;
			if ( document.getElementById( full_item_id )	)// test to make sure element id exists
			{
				hideElement( full_item_id );
			}
		}
	}
}

/*
This function starts the timer to hide every layer. We use this function to turn
all elements off, if the user has moused away from them for more than out timecount
value (set at 350 miliseconds in the global variable section)
*/
function startTime()
{
	if ( dom )
	{
		if (timerOn == false )
		{
			//note: the drop_id has to be either global or a hardcoded value in the settimeout function.
			timerID = setTimeout( "hideAll( drop_id )" , timecount);
			timerOn = true;
		}
	}
}

/*
Similarly, the stopTime function stops the timer altogether.
*/
function stopTime()
{
	if (timerOn)
	{
		clearTimeout(timerID);
		timerID = null;
		timerOn = false;
	}
}

// neutralize the default no js css action here:
if ( dom )
{
	document.write( '<style type="text/css">ul li:hover #sm1, ul li:hover  #sm2, ul li:hover  #sm3, ul li:hover #sm4,'
	+ ' ul li:hover #sm5, ul li:hover #sm6, ul li:hover #sm7, ul li:hover #sm8, ul li:hover #sm9, ul li:hover #sm10, '
	+ 'ul li:hover #sm11, ul li:hover #sm12, ul li:hover #sm13, ul li:hover #sm14, ul li:hover #sm15, ul li:hover #sm16, '
	+ 'ul li:hover #sm17, ul li:hover #sm18, ul li:hover #sm19, ul li:hover #sm20, ul li:hover #sm21, ul li:hover #sm22, '
	+ 'ul li:hover #sm23, ul li:hover #sm24, ul li:hover #sm25, ul li:hover #sm26, ul li:hover #sm27, ul li:hover #sm28, '
	+ 'ul li:hover #sm29, ul li:hover #sm30 { display:none;}</style>' );
}
