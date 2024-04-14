package net.wg.gui.lobby.vehicleTradeWnds.buy.views
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TEXT_ALIGN;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.ev.VehicleBuyEvent;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.interfaces.IVehicleBuyView;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyContentVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuySubmitVo;
   import net.wg.gui.lobby.vehicleTradeWnds.buy.vo.VehicleBuyTradeOffVo;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.utils.ILocale;
   import scaleform.clik.constants.InvalidationType;
   
   public class ContentBuyViewBase extends BaseDAAPIComponent implements IVehicleBuyView, IDAAPIModule
   {
      
      protected static const INV_TOTAL_RESULT:String = "InvTotalResult";
      
      protected static const DASH_LINE_LEFT_MARGIN:Number = 10;
      
      protected static const DASH_LINE_ACTION_PRICE_SHIFT:Number = -22;
      
      protected static const INV_TRADEOFF_VEHICLE:String = "InvVehicle";
      
      private static const WARNING_INSIDE_HEIGHT_PADDING:Number = 4;
       
      
      public var warningMsg:TextField = null;
      
      public var bounds:Sprite = null;
      
      protected var contentData:VehicleBuyContentVo = null;
      
      protected var locale:ILocale;
      
      protected var userTotalGold:Number = NaN;
      
      protected var userTotalCredits:Number = NaN;
      
      protected var isEnoughMoney:Boolean = false;
      
      protected var vehicleBuyTradeOffVo:VehicleBuyTradeOffVo = null;
      
      protected var tradeInIntCD:Number = -1;
      
      protected var tradeOffIntCD:Number = -1;
      
      public function ContentBuyViewBase()
      {
         this.locale = App.utils.locale;
         super();
      }
      
      public function setTrainingButtonsEnableState(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.warningMsg.visible = false;
         this.mouseEnabled = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.contentData != null && isInvalid(InvalidationType.DATA))
         {
            this.drawContent(this.contentData);
         }
         if(isInvalid(INV_TRADEOFF_VEHICLE))
         {
            this.drawTradeOffVehicle(this.vehicleBuyTradeOffVo);
         }
         if(isInvalid(INV_TOTAL_RESULT))
         {
            this.updateTotalResult();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateSize();
         }
      }
      
      override protected function onDispose() : void
      {
         this.contentData = null;
         if(this.vehicleBuyTradeOffVo)
         {
            this.vehicleBuyTradeOffVo = null;
         }
         this.warningMsg = null;
         this.bounds = null;
         this.locale = null;
         super.onDispose();
      }
      
      public function getActualHeight() : Number
      {
         return this.bounds.height;
      }
      
      public function getSubmitData() : VehicleBuySubmitVo
      {
         App.utils.asserter.assert(false,"Method getSubmitData must be overrider");
         return null;
      }
      
      public function memberTradeInIntCD(param1:Number) : void
      {
         this.tradeInIntCD = param1;
      }
      
      public function setTradeInWarningMessagege(param1:String) : void
      {
      }
      
      public function update(param1:VehicleBuyContentVo) : void
      {
         this.contentData = param1;
         invalidateData();
      }
      
      public function updateTotalCredits(param1:Number) : void
      {
         if(this.userTotalCredits == param1)
         {
            return;
         }
         this.userTotalCredits = param1;
         invalidate(INV_TOTAL_RESULT);
      }
      
      public function updateTotalGold(param1:Number) : void
      {
         if(this.userTotalGold == param1)
         {
            return;
         }
         this.userTotalGold = param1;
         invalidate(INV_TOTAL_RESULT);
      }
      
      public function updateTradeOffVehicle(param1:VehicleBuyTradeOffVo) : void
      {
         this.vehicleBuyTradeOffVo = param1;
         invalidate(INV_TRADEOFF_VEHICLE);
      }
      
      protected function updateSize() : void
      {
         dispatchEvent(new VehicleBuyEvent(VehicleBuyEvent.SIZE_CHANGE));
      }
      
      protected function drawTradeOffVehicle(param1:VehicleBuyTradeOffVo) : void
      {
         invalidate(INV_TOTAL_RESULT);
      }
      
      protected function drawContent(param1:VehicleBuyContentVo) : void
      {
         this.drawWarningMsg("");
      }
      
      protected function drawWarningMsg(param1:String) : void
      {
         var _loc2_:Boolean = param1 != Values.EMPTY_STR;
         this.warningMsg.autoSize = TEXT_ALIGN.LEFT;
         this.warningMsg.text = param1;
         this.warningMsg.visible = _loc2_;
         this.warningMsg.height = !!_loc2_ ? Number(this.warningMsg.textHeight + WARNING_INSIDE_HEIGHT_PADDING) : Number(0);
         invalidateSize();
      }
      
      protected function updateTotalResult() : void
      {
         this.dispatchUpdate();
      }
      
      protected final function dispatchUpdate() : void
      {
         dispatchEvent(new VehicleBuyEvent(VehicleBuyEvent.TOTAL_PRICE_UPDATED,false,false,this.isSetSubmitFocused()));
      }
      
      protected function isSetSubmitFocused() : Boolean
      {
         return false;
      }
      
      public function get isSubmitEnabled() : Boolean
      {
         return this.isEnoughMoney;
      }
   }
}
