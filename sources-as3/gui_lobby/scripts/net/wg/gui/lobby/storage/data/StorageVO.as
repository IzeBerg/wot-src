package net.wg.gui.lobby.storage.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class StorageVO extends DAAPIDataClass
   {
      
      private static const SECTIONS:String = "sections";
       
      
      public var bgSource:String = "";
      
      public var showDummyScreen:Boolean;
      
      private var _sections:DataProvider;
      
      public function StorageVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case SECTIONS:
               this._sections = new DataProvider(param2 as Array);
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._sections)
         {
            this._sections.cleanUp();
            this._sections = null;
         }
         super.onDispose();
      }
      
      public function get sections() : DataProvider
      {
         return this._sections;
      }
   }
}
