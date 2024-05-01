package net.wg.gui.lobby.vehicleTradeWnds.buy.vo
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.utils.VO.PriceVO;
   
   public class VehicleBuyContentVo extends DAAPIDataClass
   {
      
      private static const STUDY_DATA_FIELD:String = "studyData";
      
      private static const VEHICLE_PRICES_ACTION_FIELD:String = "vehiclePricesActionData";
      
      private static const VEHICLE_PRICES_FIELD:String = "vehiclePrices";
      
      private static const RENT_DATA_DD_FIELD:String = "rentDataDD";
      
      private static const SLOT_ACTION_PRICE_FIELD:String = "slotActionPriceData";
      
      private static const AMMO_ACTION_PRICE_FIELD:String = "ammoActionPriceData";
      
      private static const TRADE_IN_VEHICLE_PRICES_FIELD:String = "tradeInVehiclePrices";
      
      private static const TRADE_IN_VEHICLE_PRICES_ACTION_FIELD:String = "tradeInVehiclePricesActionData";
      
      private static const ERROR_RENT_DATA_ARRAY:String = "rentData array";
       
      
      public var priceLabel:String = "";
      
      public var tankmenTotalLabel:String = "";
      
      public var slotCheckboxTooltip:String = "";
      
      public var vehiclePricesActionData:ActionPriceVO = null;
      
      public var vehiclePrices:Array = null;
      
      public var isRentable:Boolean = false;
      
      public var rentDataProviderDD:Array = null;
      
      public var rentDataDD:Object = null;
      
      public var vehiclePrice:PriceVO = null;
      
      public var rentDataSelectedIndex:int = -1;
      
      public var studyFreeVo:VehicleBuyStudyVo = null;
      
      public var studySchoolVo:VehicleBuyStudyVo = null;
      
      public var studyAcademyVo:VehicleBuyStudyVo = null;
      
      public var slotPrice:int = -1;
      
      public var ammoPrice:Number = NaN;
      
      private var _slotActionPriceDataVo:ActionPriceVO = null;
      
      private var _ammoActionPriceDataVo:ActionPriceVO = null;
      
      public var isNoAmmo:Boolean = false;
      
      public var isStudyDisabled:Boolean = false;
      
      public var crewCheckbox:String = "";
      
      public var warningMsg:String = "";
      
      public var nation:int = -1;
      
      public var selectedTab:Number = -1;
      
      public var hasTradeOffVehicles:Boolean = false;
      
      public var tradeInPriceLabel:String = "";
      
      public var tradeInVehiclePrices:Array = null;
      
      public var tradeInVehiclePricesActionData:ActionPriceVO = null;
      
      public var tradeInStudyLabel:String = "";
      
      public var tradeInCrewCheckbox:String = "";
      
      public var tradeInVehiclePrice:PriceVO = null;
      
      public var studyDataVo:Vector.<VehicleBuyStudyVo> = null;
      
      public var studyData:Array = null;
      
      public function VehicleBuyContentVo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:VehicleBuyStudyVo = null;
         if(param1 == VEHICLE_PRICES_ACTION_FIELD && param2 != null)
         {
            this.vehiclePricesActionData = new ActionPriceVO(param2);
            this.updateVehicleActionPrice();
            return false;
         }
         if(param1 == TRADE_IN_VEHICLE_PRICES_ACTION_FIELD && param2 != null)
         {
            this.tradeInVehiclePricesActionData = new ActionPriceVO(param2);
            this.updateTradeInVehicleActionPrice();
            return false;
         }
         if(param1 == VEHICLE_PRICES_FIELD && param2 != null)
         {
            this.vehiclePrice = new PriceVO(param2);
            this.updateVehicleActionPrice();
            return false;
         }
         if(param1 == TRADE_IN_VEHICLE_PRICES_FIELD && param2 != null)
         {
            this.tradeInVehiclePrice = new PriceVO(param2);
            this.updateTradeInVehicleActionPrice();
            return false;
         }
         if(param1 == RENT_DATA_DD_FIELD && param2 != null)
         {
            this.setRentDataDD(param2);
         }
         if(param1 == SLOT_ACTION_PRICE_FIELD && param2 != null)
         {
            this._slotActionPriceDataVo = new ActionPriceVO(param2);
            this._slotActionPriceDataVo.forCredits = false;
            return false;
         }
         if(param1 == AMMO_ACTION_PRICE_FIELD && param2 != null)
         {
            this._ammoActionPriceDataVo = new ActionPriceVO(param2);
            this._ammoActionPriceDataVo.forCredits = true;
            return false;
         }
         if(param1 == STUDY_DATA_FIELD && param2 != null)
         {
            this.studyData = param2 as Array;
            this.studyDataVo = new Vector.<VehicleBuyStudyVo>();
            _loc3_ = 0;
            _loc4_ = this.studyData.length;
            _loc5_ = null;
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = new VehicleBuyStudyVo(this.studyData[_loc3_]);
               if(_loc5_.id == VehicleBuyStudyVo.STUDY_FREE_ID)
               {
                  this.studyFreeVo = _loc5_;
               }
               else if(_loc5_.id == VehicleBuyStudyVo.STUDY_SCHOOL_ID)
               {
                  if(_loc5_.actionPrice)
                  {
                     _loc5_.actionPrice.forCredits = true;
                  }
                  this.studySchoolVo = _loc5_;
               }
               else if(_loc5_.id == VehicleBuyStudyVo.STUDY_ACADEMY_ID)
               {
                  if(_loc5_.actionPrice)
                  {
                     _loc5_.actionPrice.forCredits = false;
                  }
                  this.studyAcademyVo = _loc5_;
               }
               this.studyDataVo.push(_loc5_);
               _loc3_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:VehicleBuyStudyVo = null;
         var _loc2_:Object = null;
         var _loc3_:VehicleBuyRentItemVo = null;
         if(this.vehiclePricesActionData != null)
         {
            this.vehiclePricesActionData.dispose();
            this.vehiclePricesActionData = null;
         }
         if(this.vehiclePrices != null)
         {
            this.vehiclePrices.splice(0,this.vehiclePrices.length);
            this.vehiclePrices = null;
         }
         if(this.vehiclePrice != null)
         {
            this.vehiclePrice.dispose();
            this.vehiclePrice = null;
         }
         if(this.tradeInVehiclePrices != null)
         {
            this.tradeInVehiclePrices.splice(0,this.tradeInVehiclePrices.length);
            this.tradeInVehiclePrices = null;
         }
         if(this.tradeInVehiclePrice != null)
         {
            this.tradeInVehiclePrice.dispose();
            this.tradeInVehiclePrice = null;
         }
         if(this._slotActionPriceDataVo != null)
         {
            this._slotActionPriceDataVo.dispose();
            this._slotActionPriceDataVo = null;
         }
         if(this._ammoActionPriceDataVo != null)
         {
            this._ammoActionPriceDataVo.dispose();
            this._ammoActionPriceDataVo = null;
         }
         this.studyData.splice(0,this.studyData.length);
         this.studyData = null;
         if(this.studyDataVo != null)
         {
            _loc1_ = null;
            while(this.studyDataVo.length > 0)
            {
               _loc1_ = this.studyDataVo.pop();
               _loc1_.dispose();
            }
            _loc1_ = null;
            this.studyDataVo = null;
         }
         this.studyFreeVo = null;
         this.studySchoolVo = null;
         this.studyAcademyVo = null;
         if(this.rentDataProviderDD != null)
         {
            for each(_loc2_ in this.rentDataProviderDD)
            {
               _loc3_ = VehicleBuyRentItemVo(_loc2_.data);
               _loc3_.dispose();
            }
            this.rentDataProviderDD.splice(0,this.rentDataProviderDD.length);
            this.rentDataProviderDD = null;
         }
         App.utils.data.cleanupDynamicObject(this.rentDataDD);
         this.rentDataDD = null;
         super.onDispose();
      }
      
      public function setRentDataDD(param1:Object) : void
      {
         var _loc6_:VehicleBuyRentItemVo = null;
         App.utils.data.cleanupDynamicObject(this.rentDataDD);
         this.rentDataDD = param1;
         var _loc2_:int = Values.DEFAULT_INT;
         if(this.rentDataDD.hasOwnProperty(VehicleBuyRentItemVo.SELECTED_ID) && this.rentDataDD.selectedId != undefined && this.rentDataDD.selectedId != null)
         {
            _loc2_ = this.rentDataDD.selectedId;
         }
         else
         {
            _loc2_ = VehicleBuyRentItemVo.DEF_ITEM_ID;
         }
         this.rentDataProviderDD = [];
         var _loc3_:Array = this.rentDataDD.data as Array;
         App.utils.asserter.assertNotNull(_loc3_,ERROR_RENT_DATA_ARRAY + Errors.CANT_NULL);
         var _loc4_:Number = _loc3_.length;
         var _loc5_:Number = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = new VehicleBuyRentItemVo(_loc3_[_loc5_]);
            if(_loc6_.itemId == _loc2_)
            {
               this.rentDataSelectedIndex = _loc5_;
            }
            this.rentDataProviderDD.push({
               "label":_loc6_.label,
               "data":_loc6_,
               "enabled":_loc6_.enabled
            });
            _loc5_++;
         }
      }
      
      private function updateVehicleActionPrice() : void
      {
         if(this.vehiclePricesActionData != null && this.vehiclePrice != null)
         {
            this.vehiclePricesActionData.forCredits = !this.vehiclePrice.isGold;
         }
      }
      
      private function updateTradeInVehicleActionPrice() : void
      {
         if(this.tradeInVehiclePricesActionData != null && this.tradeInVehiclePrices != null)
         {
            this.tradeInVehiclePricesActionData.forCredits = !this.tradeInVehiclePrices.isGold;
         }
      }
      
      public function get slotActionPriceDataVo() : ActionPriceVO
      {
         return this._slotActionPriceDataVo;
      }
      
      public function set slotActionPriceData(param1:Object) : void
      {
         if(this._slotActionPriceDataVo != null)
         {
            this._slotActionPriceDataVo.dispose();
         }
         if(param1 != null)
         {
            this._slotActionPriceDataVo = new ActionPriceVO(param1);
         }
      }
      
      public function get ammoActionPriceDataVo() : ActionPriceVO
      {
         return this._ammoActionPriceDataVo;
      }
      
      public function set ammoActionPriceData(param1:Object) : void
      {
         if(this._ammoActionPriceDataVo != null)
         {
            this._ammoActionPriceDataVo.dispose();
         }
         if(param1 != null)
         {
            this._ammoActionPriceDataVo = new ActionPriceVO(param1);
         }
      }
   }
}
