package net.wg.gui.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class TabsVO extends DAAPIDataClass
   {
      
      private static const TABS_FIELD_NAME:String = "tabs";
       
      
      public var tabs:DataProvider;
      
      public function TabsVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         switch(param1)
         {
            case TABS_FIELD_NAME:
               this.clearTabs();
               this.tabs = new DataProvider();
               for each(_loc3_ in param2)
               {
                  this.tabs.push(new TabDataVO(_loc3_));
               }
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearTabs();
         super.onDispose();
      }
      
      private function clearTabs() : void
      {
         var _loc1_:TabDataVO = null;
         if(this.tabs != null)
         {
            for each(_loc1_ in this.tabs)
            {
               _loc1_.dispose();
            }
            this.tabs.cleanUp();
            this.tabs = null;
         }
      }
   }
}
