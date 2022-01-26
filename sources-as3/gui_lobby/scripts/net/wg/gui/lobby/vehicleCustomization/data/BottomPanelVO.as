package net.wg.gui.lobby.vehicleCustomization.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BottomPanelVO extends DAAPIDataClass
   {
      
      private static const BILL_VO:String = "billVO";
       
      
      public var buyBtnLabel:String = "";
      
      public var buyBtnTooltip:String = "";
      
      public var buyBtnEnabled:Boolean = true;
      
      public var customizationDisplayType:int = 0;
      
      public var billVO:BottomPanelBillVO = null;
      
      public function BottomPanelVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == BILL_VO)
         {
            this.billVO = new BottomPanelBillVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.billVO)
         {
            this.billVO.dispose();
            this.billVO = null;
         }
         super.onDispose();
      }
   }
}
