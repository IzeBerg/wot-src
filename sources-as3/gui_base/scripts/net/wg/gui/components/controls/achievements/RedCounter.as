package net.wg.gui.components.controls.achievements
{
   public class RedCounter extends CounterComponent
   {
       
      
      public function RedCounter()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         minBgWindowWidth = 14;
         buttonMode = false;
      }
   }
}
