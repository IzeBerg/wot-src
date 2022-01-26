package net.wg.gui.lobby.battleRoyale.vehicleInfoView
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import net.wg.data.constants.AlignType;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEROYALE_ALIASES;
   import net.wg.gui.components.advanced.ViewStackEx;
   import net.wg.gui.components.battleRoyale.VehicleWeakZonesBase;
   import net.wg.gui.components.controls.ImageTextComponent;
   import net.wg.gui.components.controls.tabs.OrangeTabMenu;
   import net.wg.gui.events.ViewStackEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.battleRoyale.vehicleInfoView.data.TabbedViewDataVO;
   import net.wg.gui.lobby.battleRoyale.vehicleInfoView.data.VehicleInfoViewVO;
   import net.wg.infrastructure.base.meta.IBattleRoyaleVehicleInfoMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleVehicleInfoMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehicleInfoView extends BattleRoyaleVehicleInfoMeta implements IBattleRoyaleVehicleInfoMeta
   {
      
      private static const CLOSE_BUTTON_OFFSET:int = -40;
      
      private static const INFO_LABEL_OFFSET:int = -32;
      
      private static const MESSENGER_BAR_HEIGHT:int = 38;
      
      private static const VIEW_TAB_BAR_HEIGHT:int = 32;
      
      private static const TITLE_ICON_GAP:int = 2;
       
      
      public var viewTabBar:OrangeTabMenu = null;
      
      public var viewStack:ViewStackEx = null;
      
      public var background:Sprite = null;
      
      public var closeButton:ISoundButtonEx = null;
      
      public var vehicleTitle:ImageTextComponent = null;
      
      public var infoLabel:ImageTextComponent = null;
      
      public var infoButton:ISoundButtonEx = null;
      
      private var _tooltipId:String;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _weakZonesCmp:VehicleWeakZonesBase = null;
      
      private var _dataVO:VehicleInfoViewVO = null;
      
      private var _atlasHolder:Object;
      
      public function VehicleInfoView()
      {
         this._tooltipId = String.prototype;
         this._atlasHolder = {};
         super();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.setViewSize(param1,param2);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         App.atlasMgr.registerAtlas(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY,this._atlasHolder);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.vehicleTitle.gap = TITLE_ICON_GAP;
         this.viewTabBar.enableOversize = true;
         this.infoLabel.horizontalAlign = this.infoLabel.verticalAlign = AlignType.CENTER;
         this.vehicleTitle.horizontalAlign = this.vehicleTitle.verticalAlign = AlignType.CENTER;
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.handleEscape,false,0,true);
         this.infoButton.addEventListener(ButtonEvent.CLICK,this.onInfoButtonClickHandler,false,0,true);
         this.viewStack.addEventListener(ViewStackEvent.NEED_UPDATE,this.onViewStackNeedUpdateHandler,false,0,true);
         this.viewStack.addEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler,false,0,true);
         this._tooltipMgr = App.toolTipMgr;
         this.infoLabel.addEventListener(MouseEvent.ROLL_OVER,this.onInfoLabelRollOverHandler,false,0,true);
         this.infoLabel.addEventListener(MouseEvent.ROLL_OUT,this.onInfoLabelRollOutHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:UIComponent = null;
         var _loc4_:Rectangle = null;
         super.draw();
         if(this._dataVO != null && isInvalid(InvalidationType.DATA))
         {
            this.infoButton.label = this._dataVO.btnInfoLabel;
            this.vehicleTitle.htmlText = this._dataVO.vehTitle;
            this.vehicleTitle.iconSource = this._dataVO.nationIcon;
            this.closeButton.label = this._dataVO.btnCloseLabel;
            this.infoLabel.iconSource = this._dataVO.infoIconSource;
            if(this._weakZonesCmp != null)
            {
               this._weakZonesCmp.setData(this._dataVO);
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.background.width = width;
            this.background.height = height + MESSENGER_BAR_HEIGHT;
            this.viewTabBar.x = width - this.viewTabBar.getWidth() >> 1;
            this.vehicleTitle.x = this.infoLabel.x = width >> 1;
            this.infoLabel.y = height + INFO_LABEL_OFFSET | 0;
            this.closeButton.x = width - this.closeButton.width + CLOSE_BUTTON_OFFSET | 0;
            _loc1_ = this.viewTabBar.y + VIEW_TAB_BAR_HEIGHT;
            _loc2_ = height - _loc1_;
            _loc3_ = UIComponent(this.viewStack.currentView);
            if(_loc3_ == null)
            {
               _loc3_ = this.viewStack;
            }
            _loc4_ = _loc3_.getBounds(_loc3_);
            this.viewStack.x = (width - _loc4_.width >> 1) - _loc4_.x;
            this.viewStack.y = (_loc2_ - _loc4_.height >> 1) - _loc4_.y + _loc1_;
         }
      }
      
      override protected function onDispose() : void
      {
         App.atlasMgr.unregisterAtlas(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY,this._atlasHolder);
         this._atlasHolder = null;
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
         this.infoLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoLabelRollOverHandler);
         this.infoLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onInfoLabelRollOutHandler);
         this.viewStack.removeEventListener(ViewStackEvent.NEED_UPDATE,this.onViewStackNeedUpdateHandler);
         this.viewStack.removeEventListener(ViewStackEvent.VIEW_CHANGED,this.onViewStackViewChangedHandler);
         this.infoButton.removeEventListener(ButtonEvent.CLICK,this.onInfoButtonClickHandler);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.handleEscape);
         this.viewStack.dispose();
         this.viewStack = null;
         this.viewTabBar.dispose();
         this.viewTabBar = null;
         this.vehicleTitle.dispose();
         this.vehicleTitle = null;
         this.infoLabel.dispose();
         this.infoLabel = null;
         this.closeButton.dispose();
         this.closeButton = null;
         this.infoButton.dispose();
         this.infoButton = null;
         this.background = null;
         this._tooltipMgr = null;
         this._weakZonesCmp = null;
         this._dataVO = null;
         super.onDispose();
      }
      
      override protected function setData(param1:VehicleInfoViewVO) : void
      {
         this._dataVO = param1;
         invalidateData();
      }
      
      override protected function setTabsData(param1:DataProvider) : void
      {
         this.viewTabBar.dataProvider = param1;
         invalidateSize();
      }
      
      private function handleEscape(param1:Event) : void
      {
         onCloseS();
      }
      
      private function onViewStackNeedUpdateHandler(param1:ViewStackEvent) : void
      {
         if(param1.viewId == BATTLEROYALE_ALIASES.VEH_MODULES_CONFIGURATOR_CMP)
         {
            registerFlashComponentS(IDAAPIModule(param1.view),BATTLEROYALE_ALIASES.VEH_MODULES_CONFIGURATOR_CMP);
         }
         else
         {
            this._weakZonesCmp = VehicleWeakZonesBase(param1.view);
            if(this._weakZonesCmp != null)
            {
               this._weakZonesCmp.setData(this._dataVO);
            }
         }
      }
      
      private function onViewStackViewChangedHandler(param1:ViewStackEvent) : void
      {
         var _loc2_:TabbedViewDataVO = this.viewTabBar.selectedItem as TabbedViewDataVO;
         if(_loc2_ != null)
         {
            this.infoLabel.htmlText = _loc2_.tipText;
            this.infoLabel.toolTip = _loc2_.tooltipComplexStr;
            this._tooltipId = _loc2_.tooltipSpecialId;
         }
         invalidateSize();
      }
      
      private function onInfoLabelRollOverHandler(param1:MouseEvent) : void
      {
         if(this._tooltipId)
         {
            this._tooltipMgr.showSpecial(this._tooltipId,null);
         }
      }
      
      private function onInfoLabelRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onInfoButtonClickHandler(param1:ButtonEvent) : void
      {
         onShowIntroS();
      }
   }
}
