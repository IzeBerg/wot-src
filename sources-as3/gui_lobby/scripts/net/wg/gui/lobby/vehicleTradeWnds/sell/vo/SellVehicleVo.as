package net.wg.gui.lobby.vehicleTradeWnds.sell.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   
   public class SellVehicleVo extends DAAPIDataClass
   {
      
      private static const ACTION_LABEL:String = "action";
       
      
      public var userName:String = "";
      
      public var icon:String = "";
      
      public var level:Number = 0;
      
      public var isElite:Boolean = false;
      
      public var isPremium:Boolean = false;
      
      public var type:String = "";
      
      public var nationID:Number = 0;
      
      public var sellPrice:Array = null;
      
      public var action:ActionPriceVO = null;
      
      public var hasCrew:Boolean = false;
      
      public var intCD:Number = 0;
      
      public var isRented:Boolean = false;
      
      public var roleStr:String = "";
      
      public var roleIcon:String = "";
      
      public var description:String = "";
      
      public var inNationGroupDescription:String = "";
      
      public var hasNationGroup:Boolean = false;
      
      public var crewLabel:String = "";
      
      public var priceLabel:String = "";
      
      public var priceTextValue:String = "";
      
      public var priceTextColor:int = -1;
      
      public var currencyIcon:String = "";
      
      public var crewTooltip:String = "";
      
      public var barracksDropDownData:Array = null;
      
      public var isPostProgressionUnlocked:Boolean = false;
      
      public function SellVehicleVo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ACTION_LABEL && param2 != null)
         {
            this.action = new ActionPriceVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.action != null)
         {
            this.action.dispose();
            this.action = null;
         }
         this.sellPrice.splice(0);
         this.sellPrice = null;
         this.barracksDropDownData.splice(0);
         this.barracksDropDownData = null;
         super.onDispose();
      }
   }
}
