package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class FreeSheetPopoverVO extends DAAPIDataClass
   {
      
      private static const FREE_SHEETS_INFO_FIELD:String = "freeSheetsInfo";
      
      private static const PAWNER_SHEETS_INFO_FIELD:String = "pawnedSheetsInfo";
       
      
      public var titleText:String = "";
      
      public var freeSheetsInfo:SheetsInfoBlockVO = null;
      
      public var pawnedSheetsInfo:SheetsInfoBlockVO = null;
      
      public var hasPawnedSheets:Boolean = false;
      
      public function FreeSheetPopoverVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == FREE_SHEETS_INFO_FIELD)
         {
            this.freeSheetsInfo = new SheetsInfoBlockVO(param2);
            return false;
         }
         if(param1 == PAWNER_SHEETS_INFO_FIELD)
         {
            this.pawnedSheetsInfo = new SheetsInfoBlockVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.freeSheetsInfo.dispose();
         this.freeSheetsInfo = null;
         this.pawnedSheetsInfo.dispose();
         this.pawnedSheetsInfo = null;
         super.onDispose();
      }
   }
}
