package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class RankedBattlesPageVO extends DAAPIDataClass
   {
      
      private static const MENU_ITEMS_FIELD_NAME:String = "menuItems";
       
      
      public var selectedIndex:int = -1;
      
      private var _menuDP:DataProvider;
      
      public function RankedBattlesPageVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         if(param1 == MENU_ITEMS_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,MENU_ITEMS_FIELD_NAME + Errors.CANT_NULL);
            this._menuDP = new DataProvider(_loc3_);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._menuDP)
         {
            this._menuDP.cleanUp();
            this._menuDP = null;
         }
         super.onDispose();
      }
      
      public function get menuDP() : DataProvider
      {
         return this._menuDP;
      }
   }
}
