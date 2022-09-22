package net.wg.gui.tutorial.controls
{
   import net.wg.gui.components.controls.SoundButton;
   
   public class HintVideoItemRenderer extends HintBaseItemRenderer
   {
       
      
      public var button:SoundButton;
      
      public function HintVideoItemRenderer()
      {
         super();
      }
      
      override protected function drawData() : void
      {
         super.drawData();
         this.button.label = _data.label;
         this.button.validateNow();
      }
   }
}
