package net.wg.gui.lobby.vehiclePreview.infoPanel.browse
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.constants.generated.VEHPREVIEW_CONSTANTS;
   import net.wg.gui.lobby.techtree.controls.BenefitsComponent;
   import net.wg.gui.lobby.vehiclePreview.data.VPBrowseTabVO;
   import net.wg.infrastructure.base.meta.IVehiclePreviewBrowseTabMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePreviewBrowseTabMeta;
   import net.wg.infrastructure.interfaces.IViewStackExContent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   
   public class VPBrowseTab extends VehiclePreviewBrowseTabMeta implements IViewStackExContent, IVehiclePreviewBrowseTabMeta
   {
      
      private static const TITLE_OFFSET:int = 40;
      
      private static const COLLECTIBLE_OFFSET:int = 30;
      
      private static const BENEFITS_OFFSET:int = -30;
      
      private static const MINIMAL_HEIGHT:int = 900;
      
      private static const DISCLAIMER_WIDTH:int = 680;
       
      
      public var title:TextField;
      
      public var historicReference:TextField;
      
      public var legalDisclaimer:LegalDisclaimer;
      
      public var collectibleInfo:VPCollectibleInfo;
      
      private var _benefitsComponent:BenefitsComponent = null;
      
      private var _titleInfoStr:String = "";
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _isCollectible:Boolean = false;
      
      private var _isTooltip:Boolean = false;
      
      private var _isSmallAndCompact:Boolean = false;
      
      private var _needDisclaimer:Boolean = false;
      
      public function VPBrowseTab()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         validateNow();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseEnabled = false;
         mouseChildren = true;
         this.historicReference.autoSize = TextFieldAutoSize.LEFT;
         this.historicReference.wordWrap = true;
         this.historicReference.multiline = true;
         this.historicReference.mouseEnabled = false;
         this.legalDisclaimer.width = DISCLAIMER_WIDTH;
         this.legalDisclaimer.mouseEnabled = false;
         this.legalDisclaimer.visible = false;
         this.legalDisclaimer.addEventListener(LegalDisclaimer.CLICK_EVENT_TYPE,this.onLegalDisclaimerClickEventTypeHandler);
         this.collectibleInfo.addEventListener(InvalidationType.LAYOUT,this.onCollectibleInfoLayoutHandler);
         this.title.text = VEHICLE_PREVIEW.INFOPANEL_TAB_ELITEFACTSHEET_INFO;
         this.title.autoSize = TextFieldAutoSize.LEFT;
         this.title.mouseEnabled = false;
         this.historicReference.addEventListener(MouseEvent.ROLL_OVER,this.onHistoricReferenceRollOverHandler);
         this.historicReference.addEventListener(MouseEvent.ROLL_OUT,this.onHistoricReferenceRollOutHandler);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.title.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
         this.title.removeEventListener(MouseEvent.ROLL_OUT,this.onTitleRollOutHandler);
         this.historicReference.removeEventListener(MouseEvent.ROLL_OVER,this.onHistoricReferenceRollOverHandler);
         this.historicReference.removeEventListener(MouseEvent.ROLL_OUT,this.onHistoricReferenceRollOutHandler);
         this.collectibleInfo.removeEventListener(InvalidationType.LAYOUT,this.onCollectibleInfoLayoutHandler);
         this.legalDisclaimer.removeEventListener(LegalDisclaimer.CLICK_EVENT_TYPE,this.onLegalDisclaimerClickEventTypeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.historicReference = null;
         this.legalDisclaimer.dispose();
         this.legalDisclaimer = null;
         this.title = null;
         if(this._benefitsComponent)
         {
            this._benefitsComponent.dispose();
            this._benefitsComponent = null;
         }
         this.collectibleInfo.dispose();
         this.collectibleInfo = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.collectibleInfo.visible = this._isCollectible;
            this.collectibleInfo.width = width;
            this.title.width = width;
            this.historicReference.width = width;
            this.legalDisclaimer.width = width;
            _loc1_ = this._benefitsComponent && this._benefitsComponent.compact && App.appHeight <= MINIMAL_HEIGHT;
            if(_loc1_ != this._isSmallAndCompact)
            {
               this._isSmallAndCompact = _loc1_;
               this.historicReference.visible = !this._isSmallAndCompact;
               if(this._isSmallAndCompact)
               {
                  this.title.mouseEnabled = true;
                  this.title.addEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
                  this.title.addEventListener(MouseEvent.ROLL_OUT,this.onTitleRollOutHandler);
                  this.title.htmlText = this._titleInfoStr;
                  this.historicReference.mouseEnabled = true;
               }
               else
               {
                  this.title.mouseEnabled = false;
                  this.title.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleRollOverHandler);
                  this.title.removeEventListener(MouseEvent.ROLL_OUT,this.onTitleRollOutHandler);
                  this.title.text = VEHICLE_PREVIEW.INFOPANEL_TAB_ELITEFACTSHEET_INFO;
                  this.historicReference.mouseEnabled = this._isTooltip;
               }
            }
            invalidateLayout();
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            _loc2_ = 0;
            if(this._isCollectible)
            {
               _loc2_ = this.collectibleInfo.y + this.collectibleInfo.height + COLLECTIBLE_OFFSET >> 0;
            }
            if(this._benefitsComponent)
            {
               this._benefitsComponent.y = _loc2_ + BENEFITS_OFFSET;
               _loc2_ = this._benefitsComponent.y + this._benefitsComponent.height + TITLE_OFFSET >> 0;
            }
            this.title.y = _loc2_;
            this.historicReference.y = _loc2_ + this.title.height >> 0;
            this.legalDisclaimer.visible = this._needDisclaimer;
            if(this._needDisclaimer)
            {
               this.legalDisclaimer.y = this.historicReference.y + this.historicReference.height >> 0;
            }
         }
      }
      
      override protected function setData(param1:VPBrowseTabVO) : void
      {
         this.historicReference.htmlText = param1.historicReferenceTxt;
         this._isCollectible = param1.vehicleType == VEHPREVIEW_CONSTANTS.COLLECTIBLE || param1.vehicleType == VEHPREVIEW_CONSTANTS.COLLECTIBLE_WITHOUT_MODULES;
         this._titleInfoStr = param1.titleInfo;
         this._isTooltip = param1.showTooltip;
         this._needDisclaimer = param1.needDisclaimer;
         this.historicReference.mouseEnabled = this._isTooltip;
         this.setRenderersData(param1.benefitsData);
         invalidateSize();
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function setActive(param1:Boolean) : void
      {
         setActiveStateS(param1);
      }
      
      public function update(param1:Object) : void
      {
      }
      
      private function setRenderersData(param1:DataProvider) : void
      {
         if(param1 != null && param1.length > 0)
         {
            if(this._benefitsComponent == null)
            {
               this._benefitsComponent = new BenefitsComponent();
               this._benefitsComponent.mouseEnabled = this._benefitsComponent.mouseChildren = false;
               this.addChild(this._benefitsComponent);
               invalidateSize();
            }
            this._benefitsComponent.setData(param1);
            this._benefitsComponent.compact = true;
         }
      }
      
      override public function get height() : Number
      {
         if(this.historicReference.visible)
         {
            return this.historicReference.y + this.historicReference.height;
         }
         if(this.collectibleInfo.visible)
         {
            return this.collectibleInfo.y + this.collectibleInfo.height;
         }
         return super.height;
      }
      
      private function onLegalDisclaimerClickEventTypeHandler(param1:Event) : void
      {
         onDisclaimerClickS();
      }
      
      private function onHistoricReferenceRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onHistoricReferenceRollOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEHICLE_HISTORICAL_REFERENCE,null);
      }
      
      private function onTitleRollOutHandler(param1:Event) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onTitleRollOverHandler(param1:Event) : void
      {
         this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEHICLE_HISTORICAL_REFERENCE,null);
      }
      
      private function onCollectibleInfoLayoutHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
