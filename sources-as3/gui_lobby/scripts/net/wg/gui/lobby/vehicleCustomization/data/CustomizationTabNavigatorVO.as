package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class CustomizationTabNavigatorVO extends DAAPIDataClass
   {
      
      private static const TABS_DP:String = "tabsDP";
       
      
      public var tabsDP:DataProvider = null;
      
      public var selectedTab:int = -1;
      
      public function CustomizationTabNavigatorVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == TABS_DP)
         {
            this.tabsDP = new DataProvider();
            for each(_loc3_ in param2)
            {
               this.tabsDP.push(new CustomizationTabButtonVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:CustomizationTabButtonVO = null;
         if(this.tabsDP != null)
         {
            for each(_loc1_ in this.tabsDP)
            {
               _loc1_.dispose();
            }
            this.tabsDP.cleanUp();
            this.tabsDP = null;
         }
         super.onDispose();
      }
   }
}
