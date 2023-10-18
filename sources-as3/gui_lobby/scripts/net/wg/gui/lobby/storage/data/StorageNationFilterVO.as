package net.wg.gui.lobby.storage.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class StorageNationFilterVO extends DAAPIDataClass
   {
      
      private static const NATIONS_DATA:String = "data";
       
      
      public var enabled:Boolean = false;
      
      public var selectedIndex:int = -1;
      
      private var _nations:DataProvider = null;
      
      public function StorageNationFilterVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this._nations.cleanUp();
         this._nations = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         if(param1 == NATIONS_DATA)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,"hotFilters must be Array");
            this._nations = new DataProvider(_loc3_);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get nations() : DataProvider
      {
         return this._nations;
      }
   }
}
