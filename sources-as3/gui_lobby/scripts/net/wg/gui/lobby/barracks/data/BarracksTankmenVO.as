package net.wg.gui.lobby.barracks.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.InfoMessageVO;
   
   public class BarracksTankmenVO extends DAAPIDataClass
   {
      
      private static const TANKMEN_DATA_FIELD_NAME:String = "tankmenData";
      
      private static const NO_INFO_DATA_FIELD_NAME:String = "noInfoData";
       
      
      public var tankmenCount:String = "";
      
      public var placesCount:String = "";
      
      public var placesCountTooltip:String = "";
      
      public var hasNoInfoData:Boolean = false;
      
      public var noInfoData:InfoMessageVO = null;
      
      public function BarracksTankmenVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         if(param1 == TANKMEN_DATA_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array + " Got: " + param2);
            return false;
         }
         if(param1 == NO_INFO_DATA_FIELD_NAME && param2 != null)
         {
            this.noInfoData = new InfoMessageVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.noInfoData != null)
         {
            this.noInfoData.dispose();
            this.noInfoData = null;
         }
         super.onDispose();
      }
   }
}
