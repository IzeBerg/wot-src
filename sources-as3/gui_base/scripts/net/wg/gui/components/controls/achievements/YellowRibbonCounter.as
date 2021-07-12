package net.wg.gui.components.controls.achievements
{
   public class YellowRibbonCounter extends CounterComponent
   {
       
      
      public function YellowRibbonCounter()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         minBgWindowWidth = 13;
      }
      
      override public function receiveBottomPadding() : Number
      {
         return -5;
      }
   }
}
