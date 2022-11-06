package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.interfaces.IArrowButton;
   import scaleform.clik.constants.InvalidationType;
   
   public class BaseArrowButton extends SoundButtonEx implements IArrowButton
   {
      
      private static const INVALID_EXTRA_WIDTH:String = "invalid_extra_width";
       
      
      public var arrowStates:MovieClip = null;
      
      private var _extraWidth:int = 0;
      
      public function BaseArrowButton()
      {
         super();
         constraintsDisabled = true;
         preventAutosizing = true;
      }
      
      override protected function onDispose() : void
      {
         this.arrowStates = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = _newFrame;
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            if(_loc1_)
            {
               this.arrowStates.gotoAndPlay(_loc1_);
            }
         }
         if(isInvalid(INVALID_EXTRA_WIDTH) && hitMc)
         {
            hitMc.width = width + this._extraWidth;
            hitMc.x = -this._extraWidth;
         }
      }
      
      public function set extraWidth(param1:Number) : void
      {
         if(this._extraWidth == param1)
         {
            return;
         }
         this._extraWidth = param1;
         invalidate(INVALID_EXTRA_WIDTH);
      }
   }
}
