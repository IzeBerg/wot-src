package net.wg.gui.lobby.vehicleTradeWnds.buy.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   
   public class VehicleBuyStudyVo extends DAAPIDataClass
   {
      
      public static const STUDY_FREE_ID:String = "free";
      
      public static const STUDY_SCHOOL_ID:String = "school";
      
      public static const STUDY_ACADEMY_ID:String = "academy";
      
      private static const ACTION_PRICE_LABEL:String = "actionPrice";
       
      
      public var id:String = "";
      
      public var price:Number = -1;
      
      public var actionPrice:ActionPriceVO = null;
      
      public var label:String = "";
      
      public var crewType:int = -1;
      
      public function VehicleBuyStudyVo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ACTION_PRICE_LABEL && param2 != null)
         {
            this.actionPrice = new ActionPriceVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.actionPrice)
         {
            this.actionPrice.dispose();
            this.actionPrice = null;
         }
         super.onDispose();
      }
   }
}
