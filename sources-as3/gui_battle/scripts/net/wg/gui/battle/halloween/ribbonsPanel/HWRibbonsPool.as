package net.wg.gui.battle.halloween.ribbonsPanel
{
   import flash.display.DisplayObjectContainer;
   import net.wg.gui.battle.views.ribbonsPanel.RibbonsPool;
   import net.wg.gui.components.ribbon.data.RibbonSettings;
   
   public class HWRibbonsPool extends RibbonsPool
   {
       
      
      public function HWRibbonsPool(param1:DisplayObjectContainer, param2:DisplayObjectContainer, param3:DisplayObjectContainer, param4:Array, param5:Function)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override protected function createRibbonSettings(param1:String, param2:String) : RibbonSettings
      {
         return new HWRibbonSettings(param1,param2);
      }
   }
}
