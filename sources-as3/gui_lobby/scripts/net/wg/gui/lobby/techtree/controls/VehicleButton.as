package net.wg.gui.lobby.techtree.controls
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.Aliases;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.data.ResearchRootVO;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
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
      
      private var _imageSource:String = "";
      
      private var _comparisonVisible:Boolean = true;
      
      private var _comparisonEnabled:Boolean = false;
      
      private var _comparisonLabel:String = "";
      
      private var _comparisonTooltip:String = "";
      
      private var _previewEnabled:Boolean = false;
      
      private var _previewLabel:String = "";
      
      private var _sizePrefix:String = "large_";
      
      private var _modePrefix:String = "";
      
      private var _isPremium:Boolean = false;
      
      private var _vehicleId:uint = 0;
      
      private var _vehicleState:uint = 0;
      
      public function VehicleButton()
      {
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
         if(isInvalid(InvalidationType.DATA))
         {
            this.vehicleImage.source = this._imageSource;
            this.addToComparisonBtn.visible = this._comparisonVisible;
            if(this._comparisonVisible)
            {
               this.addToComparisonBtn.enabled = this._comparisonEnabled;
               this.addToComparisonBtn.label = this._comparisonLabel;
               this.addToComparisonBtn.tooltip = this._comparisonTooltip;
            }
            if(this.goToVehicleViewBtn != null)
            {
               this.goToVehicleViewBtn.enabled = this._previewEnabled;
               this.goToVehicleViewBtn.label = this._previewLabel;
            }
            this.premiumBg.visible = this.premiumAnimation.visible = this.vehicleOverlay.visible = this._isPremium;
            if(this.vehicleOverlay.visible)
            {
               this.vehicleOverlay.source = this._imageSource;
            }
         }
      }
      
      public function setData(param1:ResearchRootVO, param2:NodeData, param3:Boolean = false) : void
      {
         this._imageSource = param1.shopIconPath;
         this._comparisonVisible = param1.compareBtnVisible;
         this._comparisonEnabled = param1.compareBtnEnabled;
         this._comparisonLabel = param1.compareBtnLabel;
         this._comparisonTooltip = param1.compareBtnTooltip;
         this._previewEnabled = param1.previewBtnEnabled;
         this._previewLabel = param1.previewBtnLabel;
         this._isPremium = param3;
         this._vehicleId = param2.id;
         this._vehicleState = param2.state;
         invalidateData();
      }
      
      private function showContextMenu() : void
      {
         if(!App.contextMenuMgr)
         {
            return;
         }
         App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.RESEARCH_VEHICLE,this,{
            "nodeCD":this._vehicleId,
            "nodeState":this._vehicleState,
            "previewAlias":Aliases.RESEARCH
         });
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
