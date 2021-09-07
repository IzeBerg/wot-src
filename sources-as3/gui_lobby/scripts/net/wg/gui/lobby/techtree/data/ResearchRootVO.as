package net.wg.gui.lobby.techtree.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.VehicleButtonVO;
   import net.wg.gui.lobby.components.data.VehicleTitleVO;
   
   public class ResearchRootVO extends DAAPIDataClass
   {
      
      private static const VEHICLE_BUTTON:String = "vehicleButton";
      
      private static const VEHICLE_TITLE:String = "vehicleTitle";
       
      
      public var isInteractive:Boolean = true;
      
      public var buttonLabel:String = "";
      
      public var blueprintLabel:String = "";
      
      public var blueprintProgress:Number = 0;
      
      public var blueprintCanConvert:Boolean = false;
      
      public var bpbGlowEnabled:Boolean = false;
      
      public var itemPrices:Array = null;
      
      public var discountStr:String = "";
      
      public var rentBtnLabel:String = "";
      
      public var changeNationBtnVisibility:Boolean = false;
      
      public var isTankNationChangeAvailable:Boolean = false;
      
      public var nationChangeIsNew:Boolean = false;
      
      public var nationChangeTooltip:String = "";
      
      private var _vehicleButton:VehicleButtonVO = null;
      
      private var _vehicleTitle:VehicleTitleVO = null;
      
      public function ResearchRootVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == VEHICLE_BUTTON)
         {
            this._vehicleButton = new VehicleButtonVO(param2);
            return false;
         }
         if(param1 == VEHICLE_TITLE)
         {
            this._vehicleTitle = new VehicleTitleVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.itemPrices != null)
         {
            this.itemPrices.splice(0,this.itemPrices.length);
            this.itemPrices = null;
         }
         if(this._vehicleButton)
         {
            this._vehicleButton.dispose();
            this._vehicleButton = null;
         }
         if(this._vehicleTitle)
         {
            this._vehicleTitle.dispose();
            this._vehicleTitle = null;
         }
         super.onDispose();
      }
      
      public function get vehicleTitle() : VehicleTitleVO
      {
         return this._vehicleTitle;
      }
      
      public function get vehicleButton() : VehicleButtonVO
      {
         return this._vehicleButton;
      }
   }
}
