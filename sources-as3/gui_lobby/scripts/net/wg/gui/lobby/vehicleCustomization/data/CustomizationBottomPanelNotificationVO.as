package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class CustomizationBottomPanelNotificationVO extends DAAPIDataClass
   {
       
      
      public var switchersCounter:int = 0;
      
      public var tabsCounters:Array = null;
      
      public function CustomizationBottomPanelNotificationVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this.tabsCounters = null;
         super.onDispose();
      }
   }
}
