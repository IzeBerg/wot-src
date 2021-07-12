package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class StatusFooterVO extends DAAPIDataClass
   {
      
      private static const SHEETS_BLOCK_DATA_FIELD:String = "sheetsBlockData";
      
      private static const TANK_GIRLS_BLOCK_DATA_FIELD:String = "tankgirlsBlockData";
       
      
      public var statusText:String = "";
      
      public var descrText:String = "";
      
      public var btnVisible:Boolean = false;
      
      public var btnLabel:String = "";
      
      public var btnEnabled:Boolean = true;
      
      public var tooltip:String = "";
      
      public var isQuestInProgress:Boolean = false;
      
      private var _sheetsBlockData:SheetsBlockVO = null;
      
      private var _tankgirlsBlockData:TankgirlsBlockVO = null;
      
      public function StatusFooterVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == SHEETS_BLOCK_DATA_FIELD)
         {
            this._sheetsBlockData = new SheetsBlockVO(param2);
            return false;
         }
         if(param1 == TANK_GIRLS_BLOCK_DATA_FIELD)
         {
            this._tankgirlsBlockData = new TankgirlsBlockVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._sheetsBlockData.dispose();
         this._sheetsBlockData = null;
         this._tankgirlsBlockData.dispose();
         this._tankgirlsBlockData = null;
         super.onDispose();
      }
      
      public function get sheetsBlockData() : SheetsBlockVO
      {
         return this._sheetsBlockData;
      }
      
      public function get tankgirlsBlockData() : TankgirlsBlockVO
      {
         return this._tankgirlsBlockData;
      }
   }
}
