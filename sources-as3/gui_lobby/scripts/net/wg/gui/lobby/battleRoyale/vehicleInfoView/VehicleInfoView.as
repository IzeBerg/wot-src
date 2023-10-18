package net.wg.gui.lobby.battleRoyale.vehicleInfoView
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import net.wg.data.constants.AlignType;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.BATTLEROYALE_ALIASES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.battleRoyale.VehModuleConfiguratorCmp;
   import net.wg.gui.components.controls.ImageTextComponent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.battleRoyale.vehicleInfoView.data.VehicleInfoViewVO;
   import net.wg.infrastructure.base.meta.IBattleRoyaleVehicleInfoMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleVehicleInfoMeta;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehicleInfoView extends BattleRoyaleVehicleInfoMeta implements IBattleRoyaleVehicleInfoMeta
   {
      
      private static const CLOSE_BUTTON_OFFSET:int = -40;
      
      private static const INFO_LABEL_OFFSET:int = -32;
      
      private static const MESSENGER_BAR_HEIGHT:int = 38;
      
      private static const TITLE_HEIGHT:int = 100;
      
      private static const TITLE_ICON_GAP:int = -23;
      
      private static const ICON_OFFSET_Y:int = 3;
      
      private static const VEHICLE_TITLE_X_OFFSET:int = 20;
       
      
      public var moduleConfigurator:VehModuleConfiguratorCmp = null;
      
      public var background:Sprite = null;
      
      public var closeButton:ISoundButtonEx = null;
      
      public var vehicleTitle:ImageTextComponent = null;
      
      public var infoLabel:ImageTextComponent = null;
      
      public var tutorialTF:TextField = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _dataVO:VehicleInfoViewVO = null;
      
      private var _atlasHolder:Object;
      
      public function VehicleInfoView()
      {
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
         registerFlashComponentS(this.moduleConfigurator,BATTLEROYALE_ALIASES.VEH_MODULES_CONFIGURATOR_CMP);
         this.vehicleTitle.gap = TITLE_ICON_GAP;
         this.vehicleTitle.iconOffsetY = ICON_OFFSET_Y;
         this.infoLabel.horizontalAlign = this.infoLabel.verticalAlign = AlignType.CENTER;
         this.vehicleTitle.horizontalAlign = this.vehicleTitle.verticalAlign = AlignType.CENTER;
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
         this.closeButton.addEventListener(ButtonEvent.CLICK,this.handleEscape,false,0,true);
         this._tooltipMgr = App.toolTipMgr;
         this.infoLabel.addEventListener(MouseEvent.ROLL_OVER,this.onInfoLabelRollOverHandler,false,0,true);
         this.infoLabel.addEventListener(MouseEvent.ROLL_OUT,this.onInfoLabelRollOutHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Rectangle = null;
         super.draw();
         if(this._dataVO != null && isInvalid(InvalidationType.DATA))
         {
            this.vehicleTitle.htmlText = this._dataVO.vehTitle;
            this.vehicleTitle.iconSource = this._dataVO.vehTypeIcon;
            this.closeButton.label = this._dataVO.btnCloseLabel;
            this.infoLabel.iconSource = this._dataVO.infoIconSource;
            this.infoLabel.htmlText = this._dataVO.infoText;
            this.tutorialTF.text = this._dataVO.tutorialText;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.background.width = width;
            this.background.height = height + MESSENGER_BAR_HEIGHT;
            this.vehicleTitle.x = this.infoLabel.x = (width >> 1) - VEHICLE_TITLE_X_OFFSET;
            this.infoLabel.y = height + INFO_LABEL_OFFSET | 0;
            this.closeButton.x = width - this.closeButton.width + CLOSE_BUTTON_OFFSET | 0;
            this.tutorialTF.x = width - this.tutorialTF.width >> 1;
            _loc1_ = height - TITLE_HEIGHT;
            _loc2_ = this.moduleConfigurator.getBounds(this.moduleConfigurator);
            this.moduleConfigurator.x = (width - _loc2_.width >> 1) - _loc2_.x;
            this.moduleConfigurator.y = (_loc1_ - _loc2_.height >> 1) - _loc2_.y + TITLE_HEIGHT;
         }
      }
      
      override protected function onDispose() : void
      {
         App.atlasMgr.unregisterAtlas(ATLAS_CONSTANTS.COMMON_BATTLE_LOBBY,this._atlasHolder);
         this._atlasHolder = null;
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
         this.infoLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoLabelRollOverHandler);
         this.infoLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onInfoLabelRollOutHandler);
         this.closeButton.removeEventListener(ButtonEvent.CLICK,this.handleEscape);
         this.vehicleTitle.dispose();
         this.vehicleTitle = null;
         this.infoLabel.dispose();
         this.infoLabel = null;
         this.closeButton.dispose();
         this.closeButton = null;
         this.moduleConfigurator = null;
         this.background = null;
         this.tutorialTF = null;
         this._tooltipMgr = null;
         this._dataVO = null;
         super.onDispose();
      }
      
      override protected function setData(param1:VehicleInfoViewVO) : void
      {
         this._dataVO = param1;
         invalidateData();
         invalidateSize();
      }
      
      private function handleEscape(param1:Event) : void
      {
         onCloseS();
      }
      
      private function onInfoLabelRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.BATTLE_ROYALE_BATTLE_PROGRESSION,null);
      }
      
      private function onInfoLabelRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
