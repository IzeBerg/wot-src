package net.wg.gui.components.controls
{
   import flash.events.MouseEvent;
   
   public class CollapsedToggleButton extends SoundButtonEx
   {
      
      private static const OVER_STATE:String = "over";
      
      private static const OUT_STATE:String = "out";
       
      
      public function CollapsedToggleButton()
      {
         super();
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         setState(OVER_STATE);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         setState(OUT_STATE);
      }
   }
}
