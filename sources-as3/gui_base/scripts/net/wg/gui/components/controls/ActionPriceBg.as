package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   
   public class ActionPriceBg extends MovieClip
   {
       
      
      private var _state:String = "";
      
      public function ActionPriceBg()
      {
         super();
      }
      
      public function set state(param1:String) : void
      {
         if(param1 == this._state)
         {
            return;
         }
         this._state = param1;
         gotoAndStop(this._state);
      }
   }
}
