package net.wg.gui.lobby.eventBoards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class AwardsTableVO extends DAAPIDataClass
   {
      
      private static const TABLE_DATA:String = "tableData";
       
      
      private var _tableData:DataProvider = null;
      
      public function AwardsTableVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == TABLE_DATA)
         {
            this._tableData = new DataProvider();
            for each(_loc3_ in param2)
            {
               this._tableData.push(new AwardsListRendererVO(_loc3_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._tableData)
         {
            for each(_loc1_ in this._tableData)
            {
               _loc1_.dispose();
            }
            this._tableData.cleanUp();
            this._tableData = null;
         }
         super.onDispose();
      }
      
      public function get tableData() : DataProvider
      {
         return this._tableData;
      }
   }
}
