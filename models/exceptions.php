<?php

class NoFileException extends Exception {
	
}

class WrongFileTypeException extends Exception {
	
}

class NotMovedToDestinationException extends Exception {
	
}

class WordingTooLongException extends Exception {
	public $length;
                
        public function length($length){
            return $length;
        }
}

class PortraitException extends Exception {
    
}
class LowResolutionException extends Exception {
    
}