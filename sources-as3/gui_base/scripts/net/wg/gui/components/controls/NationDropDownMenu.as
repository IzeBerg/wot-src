package net.wg.gui.components.controls
{
   import scaleform.clik.data.DataProvider;
   
   public class NationDropDownMenu extends DropdownMenu
   {
       
      
      public function NationDropDownMenu()
      {
         super();
      }
      
      public function createNationFilter(param1:Array) : void
      {
         var _loc3_:Object = null;
         var _loc2_:Array = [{
            "label":MENU.NATIONS_ALL,
            "data":-1
         }];
         while(param1.length > 0)
         {
            _loc3_ = {
               "label":MENU.nations(param1.shift()),
               "data":param1.shift()
            };
            _loc2_.push(_loc3_);
         }
         this.setStaticData(_loc2_);
      }
      
      private function setStaticData(param1:Array) : void
      {
         dataProvider.cleanUp();
         dataProvider = new DataProvider(param1);
         invalidateData();
      }
   }
}
