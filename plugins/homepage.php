<?php
/**
 * Builds the core content of the home page.
 * Implements a plugin.
 * 
 * @author hm
 */
class HomePage extends Page{
	/** Constructor.
	 * 
	 * @param $session
	 */
	function __construct(&$session){
		parent::__construct($session, 'home');
	}
	/** Builds the core content of the page.
	 * 
	 * Overwrites the method in the baseclass.
	 */
	function build(){
		$this->readContentTemplate();
	}		
	/** Will be called on a button click.
	 * 
	 * @param $button	the name of the button
	 * @return false: a redirection will be done. true: the current page will be redrawn
	 */
	function onButtonClick($button){
		$rc = true;
		if (strcmp($button, 'button_next') == 0){
			$rc = $this->navigation(false);
		} elseif (strcmp($button, 'button_start') == 0){
			$answer = NULL;
			$options = SVOPT_BACKGROUND;
			$command = 'startgui';
			//APPL, ARGS, USER, OPTS
			$params = array('echo', '#!PROJ!#', 'root', 'console');
			$this->session->exec($answer, $options, $command, $params, 0);
		} else {
			$this->session->log("unknown button: $button");
		}
		return $rc;
	} 
}
?>