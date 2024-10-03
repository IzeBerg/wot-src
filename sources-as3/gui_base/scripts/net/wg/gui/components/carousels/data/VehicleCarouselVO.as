package net.wg.gui.components.carousels.data
{
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import net.wg.gui.components.controls.scroller.data.IScrollerItemRendererData;
   
   public class VehicleCarouselVO extends DAAPIUpdatableDataClass implements IScrollerItemRendererData
   {
      
      private static const SLOT_PRICE_ACTION_DATA:String = "slotPriceActionData";
      
      private static const PROGRESSION_POINTS_FIELD:String = "progressionPoints";
      
      private static const LEVEL_INFO_FIELD:String = "levelInfo";
       
      
      public var id:int = -1;
      
      public var intCD:int = -1;
      
      public var smallInfoText:String = "";
      
      public var infoText:String = "";
      
      public var infoHoverText:String = "";
      
      public var smallInfoHoverText:String = "";
      
      public var icon:String = "";
      
      public var iconAlt:String = "";
      
      public var iconSmall:String = "";
      
      public var iconSmallAlt:String = "";
      
      public var clanLock:Number = -1;
      
      public var slotPrice:Number = 0;
      
      public var slotPriceCurrency:String = "";
      
      public var alpha:Number = 1;
      
      public var unlockedInBattle:Boolean = false;
      
      public var restoreTank:Boolean = false;
      
      public var buyTank:Boolean = false;
      
      public var buySlot:Boolean = false;
      
      public var isWotPlusSlot:Boolean = false;
      
      public var lockBackground:Boolean = false;
      
      public var hasSale:Boolean = false;
      
      public var clickEnabled:Boolean = true;
      
      public var isUseRightBtn:Boolean = true;
      
      public var isRentPromotion:Boolean = false;
      
      public var hasRankedBonus:Boolean = false;
      
      public var hasProgression:Boolean = false;
      
      public var isEarnCrystals:Boolean = false;
      
      public var isCrystalsLimitReached:Boolean = false;
      
      public var isEarlyAccess:Boolean = false;
      
      public var label:String = "";
      
      public var level:Number = 0;
      
      public var elite:Boolean = false;
      
      public var premium:Boolean = false;
      
      public var favorite:Boolean = false;
      
      public var nation:Number = 0;
      
      public var xpImgSource:String = "";
      
      public var debutBoxesImgSource:String = "";
      
      public var tankType:String = "";
      
      public var rentLeft:String = "";
      
      public var statsText:String = "";
      
      public var visibleStats:Boolean = false;
      
      public var infoImgSrc:String = "";
      
      public var additionalImgSrc:String = "";
      
      public var extraImage:String = "";
      
      public var isCritInfo:Boolean = false;
      
      public var tooltip:String = "";
      
      public var isWulfTooltip:Boolean = false;
      
      public var lockedTooltip:String = "";
      
      public var progressionPoints:ProgressionPointsVO = null;
      
      public var levelInfo:CarouselLevelInfoVO = null;
      
      public var isNull:Boolean = true;
      
      public var isTestDriveEnabled:Boolean = false;
      
      public var isNationChangeAvailable:Boolean = false;
      
      public var isEventVehicle:Boolean = false;
      
      public var isEventVehicleSpecial:Boolean = false;
      
      private var _slotPriceActionData:ActionPriceVO = null;
      
      private var _hasExtendedInfo:Boolean = false;
      
      public function VehicleCarouselVO(param1:Object)
      {
         super(param1);
         this.isNull = param1 == null;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == SLOT_PRICE_ACTION_DATA)
         {
            this._slotPriceActionData = new ActionPriceVO(param2);
            return false;
         }
         if(param1 == PROGRESSION_POINTS_FIELD)
         {
            this.progressionPoints = new ProgressionPointsVO(param2);
            return false;
         }
         if(param1 == LEVEL_INFO_FIELD)
         {
            this.levelInfo = new CarouselLevelInfoVO(param2);
            this._hasExtendedInfo = this.levelInfo != null && this.levelInfo.level > 0;
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this._slotPriceActionData != null)
         {
            this._slotPriceActionData.dispose();
            this._slotPriceActionData = null;
         }
         if(this.progressionPoints != null)
         {
            this.progressionPoints.dispose();
            this.progressionPoints = null;
         }
         if(this.levelInfo != null)
         {
            this.levelInfo.dispose();
            this.levelInfo = null;
         }
         super.onDispose();
      }
      
      public function dataBasedWidth(param1:Boolean, param2:uint) : int
      {
         return !!this._hasExtendedInfo ? int(this.levelInfo.getActualWidth(param1,param2)) : int(Values.DEFAULT_INT);
      }
      
      public function getActionPriceVO() : ActionPriceVO
      {
         return this._slotPriceActionData;
      }
      
      public function get hasExtendedInfo() : Boolean
      {
         return this._hasExtendedInfo;
      }
      
      public function get isItemExtended() : Boolean
      {
         return this._hasExtendedInfo && !this.levelInfo.isCollapsed;
      }
      
      public function get isItemExtendendable() : Boolean
      {
         return this._hasExtendedInfo && this.levelInfo.isCollapsible;
      }
   }
}
