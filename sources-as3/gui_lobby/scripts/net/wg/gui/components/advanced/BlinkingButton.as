package net.wg.gui.components.advanced
{
   import net.wg.gui.components.controls.IconButton;
   
   public class BlinkingButton extends IconButton
   {
       
      
      private var _blinking:Boolean;
      
      public function BlinkingButton()
      {
         super();
         setState("up");
      }
      
      override protected function canShowTooltipByHover() : Boolean
      {
         return enabled;
      }
      
      override protected function draw() : void
      {
         super.draw();
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         return !!this._blinking ? Vector.<String>(["blinking_",""]) : Vector.<String>([""]);
      }
      
      public function get blinking() : Boolean
      {
         return this._blinking;
      }
      
      public function set blinking(param1:Boolean) : void
      {
         if(this._blinking == param1)
         {
            return;
         }
         this._blinking = param1;
         setState(state);
      }
   }
}
