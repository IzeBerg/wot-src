package net.wg.gui.lobby.storage.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class StorageModulesFilterVO extends DAAPIDataClass
   {
      
      private static const MODULES_DATA:String = "data";
       
      
      public var enabled:Boolean = false;
      
      public var selectedIndex:int = -1;
      
      private var _modules:DataProvider = null;
      
      public function StorageModulesFilterVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this._modules.cleanUp();
         this._modules = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         if(param1 == MODULES_DATA)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,"hotFilters must be Array");
            this._modules = new DataProvider(_loc3_);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get modules() : DataProvider
      {
         return this._modules;
      }
   }
}
