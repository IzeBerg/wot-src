package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CUSTOMIZATION_ALIASES;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.components.advanced.tutorial.TutorialHint;
   import net.wg.gui.events.LobbyEvent;
   import net.wg.gui.lobby.vehicleCustomization.controls.CarouselItemRenderer;
   import net.wg.gui.lobby.vehicleCustomization.controls.CarouselRendererAttachedBase;
   import net.wg.gui.lobby.vehicleCustomization.controls.ProgressionEntryPoint;
   import net.wg.gui.lobby.vehicleCustomization.controls.magneticTool.IMagneticClickHandler;
   import net.wg.gui.lobby.vehicleCustomization.controls.magneticTool.MagneticToolController;
   import net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet.CustomizationPropertiesSheet;
   import net.wg.gui.lobby.vehicleCustomization.controls.seasonBar.CustomizaionSeasonsBar;
   import net.wg.gui.lobby.vehicleCustomization.controls.seasonBar.CustomizationSeasonRenderer;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorInitVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorsSetVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationAnchorsStateVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationHeaderVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotIdVO;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationSlotUpdateVO;
   import net.wg.gui.lobby.vehicleCustomization.data.customizationPanel.CustomizationCarouselRendererVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationAnchorEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationAnchorSetEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationButtonEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationCarouselScrollEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationItemSwitchEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationSoundEvent;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationStyleInfoEvent;
   import net.wg.infrastructure.base.meta.ICustomizationMainViewMeta;
   import net.wg.infrastructure.base.meta.impl.CustomizationMainViewMeta;
   import net.wg.infrastructure.interfaces.ICursorManager;
   import net.wg.utils.IGameInputManager;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.motion.Tween;
   import scaleform.gfx.MouseEventEx;
   
   public class CustomizationMainView extends CustomizationMainViewMeta implements ICustomizationMainViewMeta
   {
      
      private static const BOTTOM_OFFSET:int = 220;
      
      private static const MIN_RES_BOTTOM_OFFSET:int = 242;
      
      private static const MIN_RESOLUTION:int = 900;
      
      private static const INV_FOCUS_CHAIN:String = "InvFocusChain";
      
      private static const HIDE_CONTAINER_NAME:String = "hideContainer";
      
      private static const SIDEBAR_MIN_SCREEN_SIZE:int = 1367;
      
      private static const SEASON_BAR_DEFAULT_OFFSET_X:int = 98;
      
      private static const SEASON_BAR_SMALL_OFFSET_X:int = -150;
      
      private static const SEASON_BAR_OFFSET_Y:int = -129;
      
      private static const SEASON_BAR_STYLE_INFO_OFFSET_Y:Number = -60;
      
      private static const SEASON_BAR_SPACING:int = -153;
      
      private static const SEASON_RENDERER_HEIGHT:int = 56;
      
      private static const SHOW_ALPHA:Number = 1;
      
      private static const HIDE_ALPHA:Number = 0;
      
      private static const ANIMATION_DURATION:int = 200;
      
      private static const ANIMATION_DELAY:int = 150;
      
      private static const STYLE_INFO_ANIMATION_DURATION:int = 800;
      
      private static const STYLE_INFO_ANIMATION_DELAY:int = 200;
      
      private static const ENTRY_POINT:int = 0;
      
      private static const ENTRY_POINT_MIN:int = 10;
      
      public static const ENTRY_POINT_SCALE:Number = 1;
      
      private static const ENTRY_POINT_MIN_SCALE:Number = 0.75;
       
      
      public var notification:CustomizationNotification = null;
      
      public var propertiesSheet:CustomizationPropertiesSheet = null;
      
      public var customizationHeader:CustomizationHeader = null;
      
      public var styleInfo:CustomizationStyleInfo = null;
      
      public var bottomPanel:BottomPanel = null;
      
      public var vehicleView:CustomizationVehicleView = null;
      
      public var background:Sprite = null;
      
      public var seasonsBar:CustomizaionSeasonsBar = null;
      
      public var progressionEntryPoint:ProgressionEntryPoint = null;
      
      private var _actualWidth:int = 0;
      
      private var _actualHeight:int = 0;
      
      private var _focusChain:Vector.<InteractiveObject>;
      
      private var _magneticClickHandlers:Vector.<IMagneticClickHandler>;
      
      private var _magneticTool:MagneticToolController = null;
      
      private var _dragOccurred:Boolean = false;
      
      private var _inscriptionControllerShown:Boolean = false;
      
      private var _dragMouseX:Number = 0;
      
      private var _dragMouseY:Number = 0;
      
      private var _gameInputMgr:IGameInputManager = null;
      
      private var _cursor:ICursorManager;
      
      private var _customizationAnchorInitData:CustomizationAnchorInitVO = null;
      
      private var _progressionEntryPointVisible:Boolean = false;
      
      private var _tweens:Vector.<Tween>;
      
      private var _hideContainer:Sprite;
      
      public function CustomizationMainView()
      {
         this._focusChain = new Vector.<InteractiveObject>();
         this._tweens = new Vector.<Tween>();
         super();
         this._cursor = App.cursor;
      }
      
      private static function checkClickRightMouse(param1:MouseEvent) : Boolean
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
         return _loc3_ == MouseEventEx.RIGHT_BUTTON;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this._actualWidth = param1;
         this._actualHeight = param2;
         invalidateSize();
         this.styleInfo.invalidateSize();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._gameInputMgr = App.gameInputMgr;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.customizationHeader.updateSize(this._actualWidth);
            this.vehicleView.updateSize(this._actualWidth,this._actualHeight);
            _loc1_ = App.appHeight < MIN_RESOLUTION;
            _loc2_ = !!_loc1_ ? int(MIN_RES_BOTTOM_OFFSET) : int(BOTTOM_OFFSET);
            this.bottomPanel.y = this._actualHeight - this.bottomPanel.height + _loc2_ ^ 0;
            this.bottomPanel.width = this._actualWidth;
            this.background.width = App.appWidth;
            this.background.height = App.appHeight;
            _loc3_ = !!_loc1_ ? Number(ENTRY_POINT_MIN_SCALE) : Number(ENTRY_POINT_SCALE);
            this.progressionEntryPoint.setScale(_loc3_);
            this.progressionEntryPoint.x = 0;
            this.progressionEntryPoint.y = this.bottomPanel.y - this.progressionEntryPoint.height;
            this.progressionEntryPoint.y += !!_loc1_ ? ENTRY_POINT_MIN : ENTRY_POINT;
            this.bottomPanel.invalidateSize();
            this.updateSeasonsBar();
         }
         if(isInvalid(INV_FOCUS_CHAIN))
         {
            this.refreshFocusChain();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.seasonsBar.spacing = SEASON_BAR_SPACING;
         this._gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onKeyDownHandler,true);
         this._gameInputMgr.setKeyHandler(Keyboard.LEFT,KeyboardEvent.KEY_DOWN,this.onKeyDownHandler,true);
         this._gameInputMgr.setKeyHandler(Keyboard.RIGHT,KeyboardEvent.KEY_DOWN,this.onKeyDownHandler,true);
         this._gameInputMgr.setKeyHandler(Keyboard.DELETE,KeyboardEvent.KEY_DOWN,this.onKeyDownHandler,true);
         this._gameInputMgr.setKeyHandler(Keyboard.NUMPAD_DECIMAL,KeyboardEvent.KEY_DOWN,this.onKeyDownHandler,true);
         App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.REGISTER_DRAGGING));
         App.stage.addEventListener(LobbyEvent.DRAGGING_START,this.onStageDraggingStartHandler);
         App.stage.addEventListener(LobbyEvent.DRAGGING_END,this.onStageDraggingEndHandler);
         App.stage.addEventListener(LobbyEvent.DRAGGING,this.onLobbyDraggingHandler);
         App.stage.addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         App.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         this.customizationHeader.addEventListener(CustomizationEvent.CLOSE_VIEW,this.onCloseViewHandler);
         this.customizationHeader.addEventListener(CustomizationEvent.SHOW_PROGRESSION_INFO,this.onShowProgressionInfoHandler);
         addEventListener(CustomizationEvent.SHOW_BUY_WINDOW,this.onShowBuyWindowHandler);
         addEventListener(CustomizationEvent.SHOW_PROGRESSION_DECALS_WINDOW,this.onProgressionEntryPointHandler);
         addEventListener(CustomizationItemEvent.SEEN_ITEM,this.onSeenItemHandler);
         addEventListener(CustomizationAnchorEvent.SELECT_ANCHOR,this.onSelectAnchorHandler);
         addEventListener(CustomizationAnchorEvent.LOCKED_ANCHOR,this.onLockedAnchorHandler);
         addEventListener(CustomizationAnchorEvent.OVER_ANCHOR,this.onOverAnchorHandler);
         addEventListener(CustomizationAnchorEvent.OUT_ANCHOR,this.onOutAnchorHandler);
         addEventListener(CustomizationAnchorEvent.DRAG_ANCHOR,this.onDragAnchorHandler);
         addEventListener(CustomizationSoundEvent.PLAY_SOUND,this.onCustomizationPlaySoundHandler);
         addEventListener(CustomizationItemEvent.SELECT_ITEM,this.onCarouselSelectItemHandler);
         this.propertiesSheet.addEventListener(CustomizationEvent.SHOW_PROPERTIES_SHEET,this.onShowPropertiesSheetHandler);
         this.propertiesSheet.addEventListener(CustomizationEvent.CLOSE_PROPERTIES_SHEET,this.onClosePropertiesSheetHandler);
         this.propertiesSheet.addEventListener(CustomizationEvent.SHOW_INSCRIPTION_CONTROLLER,this.onShowInscriptionControllerHandler);
         this.propertiesSheet.addEventListener(CustomizationEvent.HIDE_INSCRIPTION_CONTROLLER,this.onHideInscriptionControllerHandler);
         App.stage.addEventListener(CustomizationStyleInfoEvent.SHOW_STYLE_INFO,this.onShowStyleInfoHandler);
         App.stage.addEventListener(CustomizationStyleInfoEvent.HIDE_STYLE_INFO,this.onHideStyleInfoHandler);
         this.propertiesSheet.addEventListener(CustomizationItemSwitchEvent.SELECT_NEXT_ITEM,this.onSelectNextItemHandler);
         this.vehicleView.anchorsSet.addEventListener(CustomizationAnchorSetEvent.ANCHORS_FILLED,this.onAnchorsFilledHandler);
         this.seasonsBar.addEventListener(Event.COMPLETE,this.onSeasonBarCompleteHandler);
         this.seasonsBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onSeasonBarIndexChangeHandler);
         this.bottomPanel.addEventListener(CustomizationButtonEvent.BUTTON_PRESSED,this.onBottomPanelButtonPressedHandler);
         App.stage.addEventListener(CustomizationCarouselScrollEvent.AVAILABLE_PAGING,this.onAvailablePagingHandler);
         var _loc1_:Sprite = new Sprite();
         addChild(_loc1_);
         this.background.hitArea = _loc1_;
         this._magneticTool = new MagneticToolController(this,this.getMagneticClickHandlers());
         this.addToHideContainer();
         propertiesSheetSetS(this.propertiesSheet,this.propertiesSheet.width,this.propertiesSheet.height,CustomizationPropertiesSheet.OFFSET_X,CustomizationPropertiesSheet.OFFSET_Y);
         this.styleInfo.visible = false;
         this.progressionEntryPoint.label = App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.MIDDLE_TITLE,App.utils.locale.makeString(VEHICLE_CUSTOMIZATION.PROGRESSION_ENTRYPOINT));
         this.updateProgressionEntryPointVisibility();
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         registerFlashComponentS(this.propertiesSheet,Aliases.CUSTOMIZATION_PROPERTIES_SHEET);
         registerFlashComponentS(this.bottomPanel,Aliases.CUSTOMIZATION_BOTTOM_PANEL);
         registerFlashComponentS(this.styleInfo,Aliases.CUSTOMIZATION_STYLE_INFO);
      }
      
      override protected function onDispose() : void
      {
         App.popoverMgr.hide();
         App.stage.removeEventListener(LobbyEvent.DRAGGING_START,this.onStageDraggingStartHandler);
         App.stage.removeEventListener(LobbyEvent.DRAGGING_END,this.onStageDraggingEndHandler);
         App.stage.removeEventListener(LobbyEvent.DRAGGING,this.onLobbyDraggingHandler);
         App.stage.dispatchEvent(new LobbyEvent(LobbyEvent.UNREGISTER_DRAGGING));
         App.stage.removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         App.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         this.customizationHeader.removeEventListener(CustomizationEvent.CLOSE_VIEW,this.onCloseViewHandler);
         this.customizationHeader.removeEventListener(CustomizationEvent.SHOW_PROGRESSION_INFO,this.onShowProgressionInfoHandler);
         removeEventListener(CustomizationEvent.SHOW_BUY_WINDOW,this.onShowBuyWindowHandler);
         removeEventListener(CustomizationEvent.SHOW_PROGRESSION_DECALS_WINDOW,this.onProgressionEntryPointHandler);
         this._gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         this._gameInputMgr.clearKeyHandler(Keyboard.LEFT,KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         this._gameInputMgr.clearKeyHandler(Keyboard.RIGHT,KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         this._gameInputMgr.clearKeyHandler(Keyboard.DELETE,KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         this._gameInputMgr.clearKeyHandler(Keyboard.NUMPAD_DECIMAL,KeyboardEvent.KEY_DOWN,this.onKeyDownHandler);
         removeEventListener(CustomizationAnchorEvent.SELECT_ANCHOR,this.onSelectAnchorHandler);
         removeEventListener(CustomizationAnchorEvent.LOCKED_ANCHOR,this.onLockedAnchorHandler);
         removeEventListener(CustomizationAnchorEvent.OVER_ANCHOR,this.onOverAnchorHandler);
         removeEventListener(CustomizationAnchorEvent.OUT_ANCHOR,this.onOutAnchorHandler);
         removeEventListener(CustomizationAnchorEvent.DRAG_ANCHOR,this.onDragAnchorHandler);
         removeEventListener(CustomizationSoundEvent.PLAY_SOUND,this.onCustomizationPlaySoundHandler);
         removeEventListener(CustomizationItemEvent.SEEN_ITEM,this.onSeenItemHandler);
         removeEventListener(CustomizationItemEvent.SELECT_ITEM,this.onCarouselSelectItemHandler);
         this.propertiesSheet.removeEventListener(CustomizationEvent.SHOW_PROPERTIES_SHEET,this.onShowPropertiesSheetHandler);
         this.propertiesSheet.removeEventListener(CustomizationEvent.CLOSE_PROPERTIES_SHEET,this.onClosePropertiesSheetHandler);
         this.propertiesSheet.removeEventListener(CustomizationEvent.SHOW_INSCRIPTION_CONTROLLER,this.onShowInscriptionControllerHandler);
         this.propertiesSheet.removeEventListener(CustomizationEvent.HIDE_INSCRIPTION_CONTROLLER,this.onHideInscriptionControllerHandler);
         App.stage.removeEventListener(CustomizationStyleInfoEvent.SHOW_STYLE_INFO,this.onShowStyleInfoHandler);
         App.stage.removeEventListener(CustomizationStyleInfoEvent.HIDE_STYLE_INFO,this.onHideStyleInfoHandler);
         this.propertiesSheet.removeEventListener(CustomizationItemSwitchEvent.SELECT_NEXT_ITEM,this.onSelectNextItemHandler);
         this.vehicleView.anchorsSet.removeEventListener(CustomizationAnchorSetEvent.ANCHORS_FILLED,this.onAnchorsFilledHandler);
         this.seasonsBar.removeEventListener(Event.COMPLETE,this.onSeasonBarCompleteHandler);
         this.seasonsBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onSeasonBarIndexChangeHandler);
         this.bottomPanel.removeEventListener(CustomizationButtonEvent.BUTTON_PRESSED,this.onBottomPanelButtonPressedHandler);
         App.stage.removeEventListener(CustomizationCarouselScrollEvent.AVAILABLE_PAGING,this.onAvailablePagingHandler);
         this._magneticTool.dispose();
         this._magneticTool = null;
         this._magneticClickHandlers.splice(0,this._magneticClickHandlers.length);
         this._magneticClickHandlers = null;
         this.removeTweens();
         this._tweens = null;
         this.notification.dispose();
         this.notification = null;
         this._hideContainer = null;
         this._cursor = null;
         this.customizationHeader.dispose();
         this.customizationHeader = null;
         this.styleInfo = null;
         this.bottomPanel = null;
         this.vehicleView.dispose();
         this.vehicleView = null;
         this._focusChain.splice(0,this._focusChain.length);
         this._focusChain = null;
         this.propertiesSheet = null;
         this._gameInputMgr = null;
         this.background = null;
         this.seasonsBar.dispose();
         this.seasonsBar = null;
         this.progressionEntryPoint.dispose();
         this.progressionEntryPoint = null;
         this._customizationAnchorInitData = null;
         App.stage.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_UP,true,false,0,Keyboard.ESCAPE));
         super.onDispose();
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(this.bottomPanel.tabNavigator.tabBar);
      }
      
      override protected function onSetModalFocus(param1:InteractiveObject) : void
      {
         if(param1 == null)
         {
            param1 = this;
         }
         super.onSetModalFocus(param1);
      }
      
      override protected function setHeaderData(param1:CustomizationHeaderVO) : void
      {
         this.customizationHeader.setHeaderData(param1);
      }
      
      override protected function setAnchorsData(param1:CustomizationAnchorsSetVO) : void
      {
         this.vehicleView.setAnchorPositions(param1);
      }
      
      override protected function setAnchorInit(param1:CustomizationAnchorInitVO) : void
      {
         this._customizationAnchorInitData = param1;
         this.vehicleView.setAnchorInit(param1);
      }
      
      override protected function updateAnchorData(param1:CustomizationAnchorInitVO) : void
      {
         this.vehicleView.updateAnchorData(param1);
      }
      
      override protected function setSeasonsBarData(param1:DataProvider) : void
      {
         this.seasonsBar.dataProvider = param1;
         if(this.seasonsBar.selectedIndex == Values.DEFAULT_INT && param1.length > 0)
         {
            this.seasonsBar.selectedIndex = 0;
         }
         this.seasonsBar.height = param1.length * SEASON_RENDERER_HEIGHT;
      }
      
      override protected function onRegionHighlighted(param1:CustomizationSlotIdVO, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         this.vehicleView.anchorsSet.highlightAnchor(param1);
         if(param4)
         {
            this._cursor.forceSetCursor(!!param3 ? Cursors.BUTTON : Cursors.DRAG_OPEN);
         }
         if(!param2)
         {
            return;
         }
         if(!param1 || param1.slotType == Values.DEFAULT_INT)
         {
            this.resetMagneticTool();
         }
         var _loc5_:CustomizationSlotUpdateVO = this.vehicleView.anchorsSet.getSlotDataById(param1);
         if(_loc5_ != null)
         {
            this.vehicleView.anchorsSet.setSelectedSlot(param1);
         }
      }
      
      override protected function updateSelectedRegions(param1:CustomizationSlotIdVO) : void
      {
         if(param1.isEmpty())
         {
            this.vehicleView.anchorsSet.deselectCurrentAnchor();
         }
         else
         {
            this.vehicleView.anchorsSet.setSelectedSlot(param1);
         }
      }
      
      override protected function setNotificationCounters(param1:Array) : void
      {
         this.seasonsBar.setNotificationCounters(param1);
      }
      
      override protected function setAnchorsState(param1:CustomizationAnchorsStateVO) : void
      {
         this.vehicleView.setAnchorsState(param1);
      }
      
      override protected function attachToCursor(param1:CustomizationCarouselRendererVO) : void
      {
         var _loc2_:int = this.bottomPanel.getItemIndexByIndCD(param1.intCD);
         dispatchEvent(new CustomizationItemEvent(CustomizationItemEvent.SELECT_ITEM,_loc2_,param1.intCD,param1.progressionLevel));
         if(!param1)
         {
            return;
         }
         this._magneticTool.attachDataToCursor(param1);
         this.vehicleView.onStartDrop();
      }
      
      override protected function reselect(param1:CustomizationCarouselRendererVO) : void
      {
         this.bottomPanel.onSelectItemS(this.bottomPanel.carousel.selectedIndex,param1.intCD,param1.progressionLevel);
         this._magneticTool.attachDataToCursor(param1);
      }
      
      public function as_enableDND(param1:Boolean) : void
      {
         this._magneticTool.enableSelected = param1;
      }
      
      public function as_hide(param1:Boolean) : void
      {
         this.resetMagneticTool();
         this.alpha = !!param1 ? Number(SHOW_ALPHA) : Number(HIDE_ALPHA);
         mouseEnabled = mouseChildren = param1;
      }
      
      public function as_progressionEntryPointVisible(param1:Boolean) : void
      {
         this._progressionEntryPointVisible = param1;
         this.updateProgressionEntryPointVisibility();
      }
      
      public function as_releaseItem(param1:Boolean) : void
      {
         this.resetMagneticTool(param1);
      }
      
      public function as_selectSeason(param1:int) : void
      {
         this.seasonsBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onSeasonBarIndexChangeHandler);
         this.seasonsBar.selectedIndex = param1;
         this.seasonsBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onSeasonBarIndexChangeHandler);
      }
      
      public function as_showCarouselsArrowsNotification(param1:String) : void
      {
         this.bottomPanel.showOverlay(param1,true);
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
         return _loc1_.concat(this.bottomPanel.getFocusChain());
      }
      
      public function onLobbyZoomChange(param1:Number) : void
      {
      }
      
      private function updateProgressionEntryPointVisibility() : void
      {
         this.progressionEntryPoint.visible = this._progressionEntryPointVisible;
      }
      
      private function getMagneticClickHandlers() : Vector.<IMagneticClickHandler>
      {
         if(!this._magneticClickHandlers)
         {
            this._magneticClickHandlers = new Vector.<IMagneticClickHandler>();
            this._magneticClickHandlers.push(this.vehicleView.anchorsSet);
            this._magneticClickHandlers.push(this.bottomPanel.carousel);
            this._magneticClickHandlers.push(this.seasonsBar);
         }
         return this._magneticClickHandlers;
      }
      
      private function clearSelectedItem(param1:Boolean = true) : void
      {
         onReleaseItemS();
         if(param1)
         {
            this.vehicleView.anchorsSet.deselectCurrentAnchor();
         }
      }
      
      private function addToHideContainer() : void
      {
         this._hideContainer = new Sprite();
         this._hideContainer.name = HIDE_CONTAINER_NAME;
         addChild(this._hideContainer);
         removeChild(this.seasonsBar);
         removeChild(this.bottomPanel);
         removeChild(this.vehicleView);
         removeChild(this.propertiesSheet);
         removeChild(this.notification);
         removeChild(this.progressionEntryPoint);
         this._hideContainer.addChild(this.vehicleView);
         this._hideContainer.addChild(this.notification);
         this._hideContainer.addChild(this.seasonsBar);
         this._hideContainer.addChild(this.bottomPanel);
         this._hideContainer.addChild(this.propertiesSheet);
         this._hideContainer.addChild(this.progressionEntryPoint);
      }
      
      private function removeTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this._tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._tweens.splice(0,this._tweens.length);
      }
      
      private function refreshFocusChain() : void
      {
         var _loc1_:InteractiveObject = null;
         for each(_loc1_ in this._focusChain)
         {
            _loc1_.tabIndex = -1;
         }
         this._focusChain.splice(0,this._focusChain.length);
         this._focusChain = this.getFocusChain();
         App.utils.commons.initTabIndex(this._focusChain);
         if(this._focusChain.length > 0)
         {
            setFocus(this._focusChain[0]);
         }
      }
      
      private function closeView(param1:Boolean = false) : void
      {
         App.popoverMgr.hide();
         this.resetMagneticTool();
         if(param1)
         {
            if(this.styleInfo.visible)
            {
               App.stage.dispatchEvent(new CustomizationStyleInfoEvent(CustomizationStyleInfoEvent.CLOSE_STYLE_INFO));
            }
            else
            {
               onPressEscBtnS();
            }
         }
         else
         {
            onCloseWindowS();
         }
      }
      
      private function onHideContainerEnd() : void
      {
         this._hideContainer.visible = false;
      }
      
      private function updateSeasonsBar() : void
      {
         var _loc1_:Boolean = this.styleInfo.visible || App.appWidth < SIDEBAR_MIN_SCREEN_SIZE;
         var _loc2_:int = !!_loc1_ ? int(SEASON_BAR_SMALL_OFFSET_X) : int(SEASON_BAR_DEFAULT_OFFSET_X);
         this.seasonsBar.x = _loc2_;
         this.seasonsBar.y = (this._actualHeight - this.seasonsBar.height >> 1) + (!!this.styleInfo.visible ? SEASON_BAR_STYLE_INFO_OFFSET_Y : SEASON_BAR_OFFSET_Y);
         this.updateSeasonRenders(_loc1_);
      }
      
      private function updateSeasonRenders(param1:Boolean) : void
      {
         var _loc3_:CustomizationSeasonRenderer = null;
         var _loc2_:int = this.seasonsBar.dataProvider.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = CustomizationSeasonRenderer(this.seasonsBar.getButtonAt(_loc4_));
            if(_loc3_)
            {
               _loc3_.toggleResolution(param1);
            }
            _loc4_++;
         }
      }
      
      private function resetMagneticTool(param1:Boolean = true) : void
      {
         this.vehicleView.anchorsSet.onMagneticReset();
         this._magneticTool.resetSelect();
         this.clearSelectedItem(param1);
      }
      
      private function onShowProgressionInfoHandler(param1:CustomizationEvent) : void
      {
         showQuestProgressionInfoWindowS();
      }
      
      private function onAvailablePagingHandler(param1:CustomizationCarouselScrollEvent) : void
      {
         this.propertiesSheet.anchorSwitchers.updateAvailableScroll(param1.leftScroll,param1.rightScroll);
      }
      
      private function onSeasonBarCompleteHandler(param1:Event) : void
      {
         this.updateSeasonsBar();
      }
      
      private function onSeasonBarIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc3_:CustomizationCarouselRendererVO = null;
         this.vehicleView.anchorsSet.animatedAnchorStateTransitionsEnabled = false;
         changeSeasonS(param1.index,MagneticToolController.isAllSeasonSelected());
         var _loc2_:CarouselRendererAttachedBase = CarouselRendererAttachedBase(App.cursor.getAttachedSprite());
         if(_loc2_)
         {
            _loc3_ = CustomizationCarouselRendererVO(_loc2_.data);
            if(_loc3_ && !_loc3_.isAllSeasons)
            {
               this._magneticTool.resetSelect();
               this.clearSelectedItem(true);
            }
         }
      }
      
      private function onSeenItemHandler(param1:CustomizationItemEvent) : void
      {
         resetC11nItemsNoveltyS([param1.itemId]);
      }
      
      private function onSelectNextItemHandler(param1:CustomizationItemSwitchEvent) : void
      {
         if(!this.styleInfo.visible)
         {
            onPressSelectNextItemS(param1.reverse);
         }
      }
      
      private function onAnchorsFilledHandler(param1:CustomizationAnchorSetEvent) : void
      {
         onAnchorsShownS(param1.anchors);
      }
      
      private function onShowPropertiesSheetHandler(param1:CustomizationEvent) : void
      {
         this.resetMagneticTool(false);
         this.vehicleView.anchorsSet.deselectCurrentAnchor();
      }
      
      private function onClosePropertiesSheetHandler(param1:CustomizationEvent) : void
      {
         if(this._customizationAnchorInitData && this._customizationAnchorInitData.typeRegions == CUSTOMIZATION_ALIASES.ANCHOR_TYPE_PROJECTION_DECAL)
         {
         }
         this.bottomPanel.hideOverlay();
      }
      
      private function onShowStyleInfoHandler(param1:CustomizationStyleInfoEvent) : void
      {
         var _loc2_:int = this._hideContainer.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._hideContainer.getChildAt(_loc3_).visible = false;
            _loc3_++;
         }
         this.bottomPanel.setCarouselNotificationsVisibility(false);
         this.seasonsBar.visible = true;
         this.removeTweens();
         this.styleInfo.alpha = this.seasonsBar.alpha = HIDE_ALPHA;
         this._tweens.push(new Tween(STYLE_INFO_ANIMATION_DURATION,this.styleInfo,{"alpha":SHOW_ALPHA},{
            "delay":STYLE_INFO_ANIMATION_DELAY,
            "fastTransform":false
         }));
         this._tweens.push(new Tween(STYLE_INFO_ANIMATION_DURATION,this.seasonsBar,{"alpha":SHOW_ALPHA},{
            "delay":STYLE_INFO_ANIMATION_DELAY,
            "fastTransform":false
         }));
         this.updateSeasonsBar();
      }
      
      private function onHideStyleInfoHandler(param1:CustomizationStyleInfoEvent) : void
      {
         var _loc2_:int = this._hideContainer.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this._hideContainer.getChildAt(_loc3_).visible = true;
            _loc3_++;
         }
         this.bottomPanel.setCarouselNotificationsVisibility(true);
         this.removeTweens();
         this.styleInfo.alpha = this.seasonsBar.alpha = SHOW_ALPHA;
         this.updateSeasonsBar();
      }
      
      private function onShowInscriptionControllerHandler(param1:CustomizationEvent) : void
      {
         this._inscriptionControllerShown = true;
         this.resetMagneticTool();
      }
      
      private function onHideInscriptionControllerHandler(param1:CustomizationEvent) : void
      {
         this._inscriptionControllerShown = false;
         if(this._dragOccurred)
         {
            this.propertiesSheet.visible = false;
            this.onStageDraggingStartHandler(new LobbyEvent(LobbyEvent.DRAGGING_START));
         }
      }
      
      private function onLobbyDraggingHandler(param1:LobbyEvent) : void
      {
         this._dragOccurred = stage.mouseX != this._dragMouseX || stage.mouseY != this._dragMouseY;
      }
      
      private function onSelectAnchorHandler(param1:CustomizationAnchorEvent) : void
      {
         var _loc2_:CustomizationSlotIdVO = null;
         if(param1.anchor.id != null)
         {
            _loc2_ = param1.anchor.id;
            this.onRegionHighlighted(_loc2_,false,false,false);
            onSelectAnchorS(_loc2_.areaId,_loc2_.slotType,_loc2_.regionIdx);
            this.notification.hide();
         }
      }
      
      private function onLockedAnchorHandler(param1:CustomizationAnchorEvent) : void
      {
         this.notification.addToAnchor(param1.anchor);
         this.notification.show();
      }
      
      private function onOverAnchorHandler(param1:CustomizationAnchorEvent) : void
      {
         var _loc2_:CustomizationSlotIdVO = null;
         if(param1.anchor.id != null)
         {
            _loc2_ = param1.anchor.id;
            onHoverAnchorS(_loc2_.areaId,_loc2_.slotType,_loc2_.regionIdx,true);
         }
      }
      
      private function onOutAnchorHandler(param1:CustomizationAnchorEvent) : void
      {
         var _loc2_:CustomizationSlotIdVO = null;
         if(param1.anchor.id != null)
         {
            _loc2_ = param1.anchor.id;
            onHoverAnchorS(_loc2_.areaId,_loc2_.slotType,_loc2_.regionIdx,false);
         }
      }
      
      private function onDragAnchorHandler(param1:CustomizationAnchorEvent) : void
      {
         var _loc2_:CustomizationSlotIdVO = param1.anchor.id;
         onDragAnchorS(_loc2_.areaId,_loc2_.slotType,_loc2_.regionIdx);
      }
      
      private function onCustomizationPlaySoundHandler(param1:CustomizationSoundEvent) : void
      {
         playCustomSoundS(param1.sound);
      }
      
      private function onCarouselSelectItemHandler(param1:CustomizationItemEvent) : void
      {
         if(!this._magneticTool.enableSelected)
         {
            return;
         }
         var _loc2_:CarouselItemRenderer = param1.target as CarouselItemRenderer;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:CustomizationCarouselRendererVO = CustomizationCarouselRendererVO(_loc2_.data);
         if(!_loc3_)
         {
            return;
         }
         this._magneticTool.attachDataToCursor(_loc3_);
         this.vehicleView.onStartDrop();
         playCustomSoundS(SoundTypes.CUSTOMIZATION_SELECT);
      }
      
      private function onStageDraggingStartHandler(param1:LobbyEvent) : void
      {
         var _loc3_:DisplayObject = null;
         if(this._inscriptionControllerShown)
         {
            return;
         }
         this.vehicleView.onDragStart();
         fadeOutAnchorsS(true);
         this._dragMouseX = stage.mouseX;
         this._dragMouseY = stage.mouseY;
         this.removeTweens();
         this._tweens.push(new Tween(ANIMATION_DURATION,this._hideContainer,{"alpha":HIDE_ALPHA},{
            "delay":ANIMATION_DELAY,
            "onComplete":this.onHideContainerEnd
         }));
         this._hideContainer.mouseEnabled = this._hideContainer.mouseChildren = false;
         this.notification.hide();
         var _loc2_:uint = 0;
         while(_loc2_ < numChildren)
         {
            _loc3_ = getChildAt(_loc2_);
            if(_loc3_ is TutorialHint)
            {
               (_loc3_ as TutorialHint).fadeOut();
            }
            _loc2_++;
         }
      }
      
      private function onStageDraggingEndHandler(param1:LobbyEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:DisplayObject = null;
         this.removeTweens();
         this._hideContainer.visible = true;
         this.propertiesSheet.visible = true;
         if(this._hideContainer.alpha != SHOW_ALPHA)
         {
            this._tweens.push(new Tween(ANIMATION_DURATION,this._hideContainer,{"alpha":SHOW_ALPHA},{}));
         }
         this._hideContainer.mouseEnabled = this._hideContainer.mouseChildren = true;
         this.vehicleView.onDragEnd();
         if(!this._dragOccurred)
         {
            onLobbyClickS();
         }
         this._dragOccurred = false;
         fadeOutAnchorsS(false);
         while(_loc2_ < numChildren)
         {
            _loc3_ = getChildAt(_loc2_);
            if(_loc3_ is TutorialHint)
            {
               (_loc3_ as TutorialHint).fadeIn();
            }
            _loc2_++;
         }
      }
      
      private function onCloseViewHandler(param1:CustomizationEvent) : void
      {
         this.closeView();
      }
      
      private function onShowBuyWindowHandler(param1:CustomizationEvent) : void
      {
         showBuyWindowS();
      }
      
      private function onBottomPanelButtonPressedHandler(param1:CustomizationButtonEvent) : void
      {
         onButtonPressedS(param1.name);
      }
      
      private function onProgressionEntryPointHandler(param1:CustomizationEvent) : void
      {
         onProgressionEntryPointClickS();
      }
      
      private function onKeyDownHandler(param1:InputEvent = null) : void
      {
         switch(param1.details.code)
         {
            case Keyboard.ESCAPE:
               if(this._magneticTool.attachedData)
               {
                  this.resetMagneticTool();
               }
               else
               {
                  this.closeView(true);
               }
               break;
            case Keyboard.LEFT:
            case Keyboard.RIGHT:
               this.propertiesSheet.onKeyDownHandler(param1.details);
               this.bottomPanel.hideOverlay();
               break;
            case Keyboard.DELETE:
            case Keyboard.NUMPAD_DECIMAL:
               onRemoveSelectedItem();
         }
      }
      
      private function onMouseWheelHandler(param1:MouseEvent) : void
      {
         this.notification.hide();
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         if(this._dragOccurred)
         {
            return;
         }
         var _loc2_:Boolean = checkClickRightMouse(param1);
         if(this._magneticTool.attachedData)
         {
            if(_loc2_ || this._magneticTool.handleLeftClick(param1))
            {
               this.resetMagneticTool();
            }
         }
      }
   }
}
