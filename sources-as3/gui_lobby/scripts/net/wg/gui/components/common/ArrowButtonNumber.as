package net.wg.gui.components.common
{
   import flash.text.TextField;
   
   public class ArrowButtonNumber extends FrameStateCmpnt
   {
       
      
      public var labelTf:TextField = null;
      
      public function ArrowButtonNumber()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.labelTf = null;
         super.onDispose();
      }
      
      public function set label(param1:String) : void
      {
         this.labelTf.text = param1;
      }
   }
}
