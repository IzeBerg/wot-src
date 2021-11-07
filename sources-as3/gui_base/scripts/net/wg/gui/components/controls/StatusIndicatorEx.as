package net.wg.gui.components.controls
{
   import scaleform.clik.controls.StatusIndicator;
   
   public class StatusIndicatorEx extends StatusIndicator
   {
      
      private static const PADDING_LEFT:Number = 4;
      
      private static const PADDING_RIGHT:Number = 4;
       
      
      public function StatusIndicatorEx()
      {
         super();
      }
      
      public function get lineWidth() : Number
      {
         return this.width - StatusIndicatorEx.PADDING_LEFT - StatusIndicatorEx.PADDING_RIGHT;
      }
      
      public function get lineStart() : Number
      {
         return StatusIndicatorEx.PADDING_LEFT;
      }
   }
}
