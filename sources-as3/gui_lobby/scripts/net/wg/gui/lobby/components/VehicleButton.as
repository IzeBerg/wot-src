package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.data.VehicleButtonVO;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehicleButton extends SoundButtonEx
   {
      
      private static const STATE_PREFIX_SELECTED:String = "selected_";
      
      private static const STATE_UP:String = "up";
      
      private static const SOUND_TYPE:String = "vehicleButton";
      
      private static const ICON_BUTTON_SOUND_TYPE:String = "researchIcon";
      
      public static const MEDIUM_SIZE:String = "medium_";
      
      public static const SMALL_SIZE:String = "small_";
      
      public static const LARGE_SIZE:String = "large_";
      
      public static const COMPARE_ONLY_MODE:String = "";
      
      public static const NORMAL_MODE:String = "preview_";
       
      
      public var vehicleImage:IImage = null;
      
      public var addToComparisonBtn:ISoundButtonEx = null;
      
      public var goToVehicleViewBtn:ISoundButtonEx = null;
      
      public var premiumAnimation:MovieClip = null;
      
      public var premiumBg:Sprite = null;
      
      public var vehicleOverlay:IImage = null;
      
      private var _sizePrefix:String = "large_";
      
      private var _modePrefix:String = "";
      
      private var _vehData:VehicleButtonVO = null;
      
      private var _hitMc:Sprite;
      
      public function VehicleButton()
      {
         this._hitMc = new Sprite();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         preventAutosizing = true;
         soundType = SOUND_TYPE;
         mouseEnabled = false;
         mouseChildren = true;
         this.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler,false,0,true);
         this.vehicleImage.buttonMode = true;
         this.vehicleImage.addEventListener(MouseEvent.CLICK,this.onVehicleClickHandler,false,0,true);
         this.addToComparisonBtn.mouseEnabledOnDisabled = true;
         this.addToComparisonBtn.soundType = ICON_BUTTON_SOUND_TYPE;
         this.addToComparisonBtn.focusable = false;
         this.addToComparisonBtn.addEventListener(ButtonEvent.CLICK,this.onAddToComparisonBtnClickHandler,false,0,true);
         this.premiumAnimation.mouseEnabled = this.premiumAnimation.mouseChildren = false;
         this.premiumBg.mouseEnabled = this.premiumBg.mouseChildren = false;
         this.vehicleOverlay.mouseEnabled = this.vehicleOverlay.mouseChildren = false;
         this._hitMc.name = "hitMc";
         addChild(this._hitMc);
         hitArea = this._hitMc;
         this.updatePrefixes();
      }
      
      override protected function canShowTooltipByHover() : Boolean
      {
         return false;
      }
      
      override protected function onDispose() : void
      {
         this.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.vehicleImage.removeEventListener(MouseEvent.CLICK,this.onVehicleClickHandler);
         this.vehicleImage.dispose();
         this.vehicleImage = null;
         this.addToComparisonBtn.removeEventListener(ButtonEvent.CLICK,this.onAddToComparisonBtnClickHandler);
         this.addToComparisonBtn.dispose();
         this.addToComparisonBtn = null;
         if(this.goToVehicleViewBtn != null)
         {
            this.goToVehicleViewBtn.removeEventListener(ButtonEvent.CLICK,this.onGoToVehicleBtnClickHandler);
            this.goToVehicleViewBtn.dispose();
            this.goToVehicleViewBtn = null;
         }
         this.vehicleOverlay.dispose();
         this.vehicleOverlay = null;
         this.premiumBg = null;
         this.premiumAnimation = null;
         this._vehData = null;
         this._hitMc = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_baseDisposed)
         {
            return;
         }
         if(this.goToVehicleViewBtn != null && isInvalid(InvalidationType.STATE))
         {
            this.goToVehicleViewBtn.soundType = ICON_BUTTON_SOUND_TYPE;
            this.goToVehicleViewBtn.focusable = false;
            this.goToVehicleViewBtn.addEventListener(ButtonEvent.CLICK,this.onGoToVehicleBtnClickHandler,false,0,true);
         }
         if(this._vehData && isInvalid(InvalidationType.DATA))
         {
            this.vehicleImage.source = this._vehData.shopIconPath;
            this._hitMc.graphics.beginFill(16777215,0);
            this._hitMc.graphics.drawRect(0,0,this.contentWidth,this.contentHeight);
            this._hitMc.graphics.endFill();
            this._hitMc.x = this.vehicleImage.x;
            this._hitMc.y = this.vehicleImage.y;
            this.subButtonsMode = !!this._vehData.isInInventory ? VehicleButton.COMPARE_ONLY_MODE : VehicleButton.NORMAL_MODE;
            this.addToComparisonBtn.visible = this._vehData.compareBtnVisible;
            if(this._vehData.compareBtnVisible)
            {
               this.addToComparisonBtn.enabled = this._vehData.compareBtnEnabled;
               this.addToComparisonBtn.label = this._vehData.compareBtnLabel;
               this.addToComparisonBtn.tooltip = this._vehData.compareBtnTooltip;
            }
            if(this.goToVehicleViewBtn != null)
            {
               this.goToVehicleViewBtn.visible = this._vehData.goToVehicleViewBtnVisible;
               this.goToVehicleViewBtn.enabled = this._vehData.previewBtnEnabled;
               this.goToVehicleViewBtn.label = this._vehData.previewBtnLabel;
            }
            this.premiumBg.visible = this.premiumAnimation.visible = this.vehicleOverlay.visible = this._vehData.isPremium;
            if(this.vehicleOverlay.visible)
            {
               this.vehicleOverlay.source = this._vehData.shopIconPath;
            }
         }
      }
      
      public function setData(param1:VehicleButtonVO) : void
      {
         this._vehData = param1;
         invalidateData();
      }
      
      private function showContextMenu() : void
      {
         if(!App.contextMenuMgr)
         {
            return;
         }
         if(this._vehData)
         {
            App.contextMenuMgr.show(this._vehData.cmHandlerType,this,{
               "vehCD":this._vehData.vehicleId,
               "nodeState":this._vehData.vehicleState,
               "previewAlias":this._vehData.previewAlias
            });
         }
      }
      
      private function updatePrefixes() : void
      {
         var _loc1_:String = this._sizePrefix + this._modePrefix;
         statesSelected = Vector.<String>([STATE_PREFIX_SELECTED,_loc1_]);
         statesDefault = Vector.<String>([_loc1_]);
         setState(STATE_UP);
      }
      
      public function set subButtonsMode(param1:String) : void
      {
         if(this._modePrefix == param1)
         {
            return;
         }
         this._modePrefix = param1;
         this.updatePrefixes();
      }
      
      public function get contentWidth() : Number
      {
         return this.vehicleImage.width;
      }
      
      public function get contentHeight() : Number
      {
         return this.vehicleImage.height;
      }
      
      public function set size(param1:String) : void
      {
         if(param1 == this._sizePrefix)
         {
            return;
         }
         this._sizePrefix = param1;
         this.updatePrefixes();
      }
      
      private function onGoToVehicleBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new TechTreeEvent(TechTreeEvent.GO_TO_VEHICLE_VIEW,null,0,NodeEntityType.RESEARCH_ROOT));
      }
      
      private function onAddToComparisonBtnClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_VEHICLE_COMPARE,null,0,NodeEntityType.RESEARCH_ROOT));
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isRightButton(param1))
         {
            this.showContextMenu();
         }
         else if(App.contextMenuMgr)
         {
            App.contextMenuMgr.hide();
         }
      }
      
      private function onVehicleClickHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.GO_TO_VEHICLE_VIEW,null,0,NodeEntityType.RESEARCH_ROOT));
         }
      }
   }
}
