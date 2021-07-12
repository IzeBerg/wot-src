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
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   
   public class VPBrowseTab extends VehiclePreviewBrowseTabMeta implements IViewStackExContent, IVehiclePreviewBrowseTabMeta
   {
      
      private static const TITLE_OFFSET:int = 40;
      
      private static const COLLECTIBLE_OFFSET:int = 30;
      
      private static const BENEFITS_OFFSET:int = -30;
      
      private static const MINIMAL_HEIGHT:int = 900;
       
      
      public var title:TextField;
      
      public var historicReference:TextField;
      
      public var collectibleInfo:VPCollectibleInfo;
      
      private var _benefitsComponent:BenefitsComponent = null;
      
      private var _titleInfoStr:String = "";
      
      private var _isCollectible:Boolean = false;
      
      private var _isTooltip:Boolean = false;
      
      private var _isSmallAndCompact:Boolean = false;
      
      public function VPBrowseTab()
      {
         super();
      }
      
      private static function onHistoricReferenceRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private static function onHistoricReferenceRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEHICLE_HISTORICAL_REFERENCE,null);
      }
      
      private static function onTitleRollOutHandler(param1:Event) : void
      {
         App.toolTipMgr.hide();
      }
      
      private static function onTitleRollOverHandler(param1:Event) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.VEHICLE_HISTORICAL_REFERENCE,null);
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
         this.historicReference.autoSize = TextFieldAutoSize.LEFT;
         this.historicReference.wordWrap = true;
         this.historicReference.multiline = true;
         this.collectibleInfo.addEventListener(InvalidationType.LAYOUT,this.updateLayout);
         this.title.text = VEHICLE_PREVIEW.INFOPANEL_TAB_ELITEFACTSHEET_INFO;
         this.title.autoSize = TextFieldAutoSize.LEFT;
         this.historicReference.addEventListener(MouseEvent.ROLL_OVER,onHistoricReferenceRollOverHandler);
         this.historicReference.addEventListener(MouseEvent.ROLL_OUT,onHistoricReferenceRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         this.title.removeEventListener(MouseEvent.ROLL_OVER,onTitleRollOverHandler);
         this.title.removeEventListener(MouseEvent.ROLL_OUT,onTitleRollOutHandler);
         this.historicReference.removeEventListener(MouseEvent.ROLL_OVER,onHistoricReferenceRollOverHandler);
         this.historicReference.removeEventListener(MouseEvent.ROLL_OUT,onHistoricReferenceRollOutHandler);
         this.collectibleInfo.removeEventListener(InvalidationType.LAYOUT,this.updateLayout);
         this.historicReference = null;
         this.title = null;
         if(this._benefitsComponent)
         {
            this._benefitsComponent.dispose();
            this._benefitsComponent = null;
         }
         this.collectibleInfo.dispose();
         this.collectibleInfo = null;
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
            _loc1_ = this._benefitsComponent && this._benefitsComponent.compact && App.appHeight <= MINIMAL_HEIGHT;
            if(_loc1_ != this._isSmallAndCompact)
            {
               this._isSmallAndCompact = _loc1_;
               this.historicReference.visible = !this._isSmallAndCompact;
               if(this._isSmallAndCompact)
               {
                  this.title.addEventListener(MouseEvent.ROLL_OVER,onTitleRollOverHandler);
                  this.title.addEventListener(MouseEvent.ROLL_OUT,onTitleRollOutHandler);
                  this.title.htmlText = this._titleInfoStr;
                  mouseChildren = true;
               }
               else
               {
                  this.title.removeEventListener(MouseEvent.ROLL_OVER,onTitleRollOverHandler);
                  this.title.removeEventListener(MouseEvent.ROLL_OUT,onTitleRollOutHandler);
                  this.title.text = VEHICLE_PREVIEW.INFOPANEL_TAB_ELITEFACTSHEET_INFO;
                  mouseChildren = this._isTooltip;
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
         }
      }
      
      override protected function setData(param1:VPBrowseTabVO) : void
      {
         this.historicReference.htmlText = param1.historicReferenceTxt;
         this._isCollectible = param1.vehicleType == VEHPREVIEW_CONSTANTS.COLLECTIBLE || param1.vehicleType == VEHPREVIEW_CONSTANTS.COLLECTIBLE_WITHOUT_MODULES;
         this._titleInfoStr = param1.titleInfo;
         this._isTooltip = param1.showTooltip;
         mouseChildren = this._isTooltip;
         this.setRenderersData(param1.benefitsData);
         invalidateSize();
      }
      
      private function updateLayout(param1:Event) : void
      {
         invalidateLayout();
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
   }
}
