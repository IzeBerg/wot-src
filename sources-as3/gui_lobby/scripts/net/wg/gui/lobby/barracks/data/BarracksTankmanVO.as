package net.wg.gui.lobby.barracks.data
{
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.lobby.components.data.BaseTankmanVO;
   
   public class BarracksTankmanVO extends BaseTankmanVO
   {
      
      private static const ACTION_PRICE_DATA_FIELD_NAME:String = "actionPriceData";
       
      
      public var isRankNameVisible:Boolean = false;
      
      public var slot:int = -1;
      
      public var inCurrentTank:Boolean = false;
      
      public var vehicleID:int = -1;
      
      public var locked:Boolean = false;
      
      public var lockMessage:String = "";
      
      public var isInSelfVehicleClass:Boolean = false;
      
      public var isInSelfVehicleType:Boolean = false;
      
      public var recoveryPeriodText:String = "";
      
      public var actionBtnLabel:String = "";
      
      public var actionBtnEnabled:Boolean = false;
      
      public var actionBtnTooltip:String = "";
      
      public var isSkillsVisible:Boolean = false;
      
      public var recruitID:String = "";
      
      public var empty:Boolean = false;
      
      public var freePlaces:int = -1;
      
      public var buy:Boolean = false;
      
      public var price:String = "";
      
      public var actionPriceData:ActionPriceVO = null;
      
      public var count:int = -1;
      
      public var notRecruited:Boolean = false;
      
      public function BarracksTankmanVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ACTION_PRICE_DATA_FIELD_NAME && param2 != null)
         {
            this.actionPriceData = new ActionPriceVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.actionPriceData != null)
         {
            this.actionPriceData.dispose();
            this.actionPriceData = null;
         }
         super.onDispose();
      }
   }
}
