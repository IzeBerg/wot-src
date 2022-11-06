package net.wg.gui.components.questProgress.components
{
   import flash.display.BlendMode;
   import net.wg.gui.components.common.FrameStateCmpnt;
   
   public class QPStatusBg extends FrameStateCmpnt
   {
       
      
      public function QPStatusBg()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.blendMode = BlendMode.SCREEN;
      }
   }
}
