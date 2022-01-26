package net.wg.gui.lobby.techtree.sub
{
   import fl.motion.easing.Linear;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.DragType;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.controls.LevelsContainer;
   import net.wg.gui.lobby.techtree.controls.PremiumPanelBackground;
   import net.wg.gui.lobby.techtree.controls.PremiumPanelHitArea;
   import net.wg.gui.lobby.techtree.controls.PremiumPanelItems;
   import net.wg.gui.lobby.techtree.data.NationVODataProvider;
   import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
   import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
   import net.wg.gui.lobby.techtree.data.vo.NationGridDisplaySettings;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.helpers.LevelHeaderInfo;
   import net.wg.gui.lobby.techtree.helpers.NTGraphics;
   import net.wg.gui.lobby.techtree.helpers.NationTreeActionsHelper;
   import net.wg.gui.lobby.techtree.interfaces.INationTreeDataProvider;
   import net.wg.gui.lobby.techtree.interfaces.INodesContainer;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.interfaces.ITechTreePage;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.ICursorManager;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   import net.wg.infrastructure.managers.IContextMenuManager;
   import net.wg.infrastructure.managers.ITutorialManager;
   import net.wg.utils.IAssertable;
   import net.wg.utils.IScheduler;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class NationTree extends UIComponentEx implements INodesContainer, IDraggable, ITutorialCustomComponent
   {
      
      public static const CONTAINER_HEIGHT:int = 610;
      
      private static const NODE_WIDTH:int = 130;
      
      private static const NODE_HEIGHT:int = 36;
      
      private static const SCROLL_STEP_FACTOR:int = 64;
      
      private static const SCROLLBAR_BOOTOM_OFFSET:int = 2;
      
      private static const SCROLLBAR_RIGHT_OFFSET:int = 7;
      
      private static const TREE_NODE_SELECTOR_X_SHIFT:int = 40;
      
      private static const TREE_NODE_SELECTOR_Y_SHIFT:int = -25;
      
      private static const DEF_ACTIVATE_COOLDOWN:int = 250;
      
      private static const MIN_RIGHT_MARGIN:int = 26;
      
      private static const TUTORIAL_DESCR_SEPARATOR:String = ":";
      
      private static const MAIN_LINE_OFFSET_Y:int = -45;
      
      private static const INV_RENDERERS_LINES_STATE:String = "invRenderersState";
      
      private static const VSCROLL_OFFSET_X:int = 65;
      
      private static const VSCROLL_OFFSET_Y:int = -110;
      
      private static const PREMIUM_PANEL_HEIGHT:int = 325;
      
      private static const PREMIUM_PANEL_VERTICAL_OFFSET:int = 110;
      
      private static const PREMIUM_PANEL_ANIMATION_OFFSET:int = 215;
      
      private static const PREMIUM_PANEL_TITLE_OFFSET:int = 32;
      
      private static const PREMIUM_SHADOW_TWEEN_DURATION:int = 250;
      
      private static const PREMIUM_PANEL_ITEMS_V_OFFSET:int = 12;
      
      private static const PREMIUM_PANEL_HIT_AREA_OPEN_OFFSET:int = 34;
      
      private static const PREMIUM_PANEL_HIT_AREA_DEFAULT_OFFSET:int = 4;
      
      private static const PREMIUM_PANEL_NODES_DEFAULT_START_Y:int = 40;
      
      private static const PREMIUM_PANEL_CLICK_AREA_OFFSET:int = 11;
      
      private static const LEVELS_BG_COLOR:uint = 1249808;
      
      private static const LEVELS_BG_COLOR_BP:uint = 1449766;
      
      private static const LEVELS_BG_ALPHA:Number = 0.95;
      
      private static const VEHICLE_LABEL:String = "vehicleLabel";
      
      private static const PANEL_TITLE:String = "panelTitle";
      
      private static const LEVELS_BG_NAME:String = "levelsBg";
      
      private static const MIN_NODE_MARGIN:int = 23;
      
      private static const NT_GRAPHICS_OFFSET_X:int = -4;
      
      private static const NT_WIDTH_OFFSET:int = 4;
      
      private static const VSCROLL_NO_PANEL_OFFSET_Y:int = 18;
      
      private static const MAIN_LINE_WIDTH_OFFSET:int = -6;
       
      
      public var scrollBar:ScrollBar = null;
      
      public var vScrollBar:ScrollBar = null;
      
      public var ntGraphics:NTGraphics = null;
      
      public var treeNodeSelector:ISoundButtonEx = null;
      
      public var bounds:Sprite = null;
      
      public var premiumPanelBack:PremiumPanelBackground = null;
      
      public var premiumPanel:PremiumPanelItems = null;
      
      public var premiumPanelShadow:Sprite = null;
      
      public var levels:LevelsContainer;
      
      public var premiumHitArea:PremiumPanelHitArea = null;
      
      public var premiumPanelClickArea:Sprite = null;
      
      private var _blueprintModeOn:Boolean = false;
      
      private var _renderers:Vector.<IRenderer> = null;
      
      private var _dataProvider:INationTreeDataProvider = null;
      
      private var _hPositionByNation:Object = null;
      
      private var _vPositionByNation:Object = null;
      
      private var _totalWidth:int;
      
      private var _totalHeight:int;
      
      private var _isDragging:Boolean = false;
      
      private var _dragHOffset:int;
      
      private var _dragVOffset:int;
      
      private var _itemRendererName:String = "";
      
      private var _itemRendererClass:Class = null;
      
      private var _view:ITechTreePage = null;
      
      private var _requestInCoolDown:Boolean = false;
      
      private var _curRend:IRenderer = null;
      
      private var _asserter:IAssertable = null;
      
      private var _tutorialMgr:ITutorialManager = null;
      
      private var _scheduler:IScheduler = null;
      
      private var _cursorMgr:ICursorManager = null;
      
      private var _contextMenuMgr:IContextMenuManager = null;
      
      private var _premiumPanelShadowTween:Tween = null;
      
      private var _savedVScrollVisibility:Boolean = false;
      
      private var _levelsBg:Sprite = null;
      
      private var _premiumPanelShadowHitArea:Sprite = null;
      
      private var _ntGraphicsOffsetY:int;
      
      private var _nationTreeActionsHelper:NationTreeActionsHelper = null;
      
      public function NationTree()
      {
         super();
         this._tutorialMgr = App.tutorialMgr;
         this._tutorialMgr.addListenersToCustomTutorialComponent(this);
         this._asserter = App.utils.asserter;
         this._scheduler = App.utils.scheduler;
         this._cursorMgr = App.cursor;
         this._contextMenuMgr = App.contextMenuMgr;
         this._hPositionByNation = {};
         this._vPositionByNation = {};
         this._levelsBg = new Sprite();
         this._levelsBg.name = LEVELS_BG_NAME;
         this._levelsBg.x = -x;
         var _loc1_:Graphics = this._levelsBg.graphics;
         _loc1_.clear();
         _loc1_.beginFill(0);
         _loc1_.drawRect(0,0,1,1);
         _loc1_.endFill();
         this.updateLevelsBgColor();
         addChildAt(this._levelsBg,getChildIndex(this.levels));
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._nationTreeActionsHelper = new NationTreeActionsHelper();
         this._dataProvider = new NationVODataProvider();
         this._dataProvider.addEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.onDataProviderDataBuildCompleteHandler,false,0,true);
         this._renderers = new Vector.<IRenderer>();
         this.ntGraphics.container = this;
      }
      
      override protected function onDispose() : void
      {
         this.levels.dispose();
         this.levels = null;
         this._tutorialMgr.removeListenersFromCustomTutorialComponent(this);
         this._tutorialMgr = null;
         visible = false;
         this._scheduler.cancelTask(this.deactivateCoolDown);
         this._scheduler = null;
         this.removeItemRenderers();
         this.view = null;
         NodeData.setDisplayInfoClass(null);
         this._nationTreeActionsHelper.dispose();
         this._nationTreeActionsHelper = null;
         if(this.scrollBar != null)
         {
            this.scrollBar.removeEventListener(Event.SCROLL,this.onScrollBarScrollHandler);
            this.scrollBar = null;
         }
         if(this.vScrollBar != null)
         {
            this.vScrollBar.removeEventListener(Event.SCROLL,this.onVScrollBarScrollHandler);
            this.vScrollBar = null;
         }
         removeEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler);
         this._contextMenuMgr = null;
         this.clearCursors();
         this._cursorMgr = null;
         this.cleanNodeSelectorCallbacks(this.premiumPanel.treeNodeSelector);
         this.premiumPanel.cleanUp(this.ntGraphics.clearUpRenderer);
         this.premiumPanel.dispose();
         this.premiumPanel = null;
         this.premiumPanelBack.dispose();
         this.premiumPanelBack = null;
         this.clearPremiumShadowTween();
         this.premiumPanelShadow.removeChild(this._premiumPanelShadowHitArea);
         this._premiumPanelShadowHitArea = null;
         this.premiumPanelShadow = null;
         this.premiumHitArea.removeEventListener(MouseEvent.MOUSE_OVER,this.onPremPanelMouseOverHandler);
         this.premiumHitArea.removeEventListener(MouseEvent.MOUSE_OUT,this.onPremPanelMouseOutHandler);
         this.premiumHitArea.removeEventListener(MouseEvent.MOUSE_MOVE,this.onPremPanelMouseMoveHandler);
         this.premiumHitArea = null;
         this.premiumPanelClickArea = null;
         this.ntGraphics.removeEventListener(MouseEvent.MOUSE_MOVE,this.onNtGraphicsMouseMoveHandler);
         this.ntGraphics.dispose();
         this.ntGraphics = null;
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.onDataProviderDataBuildCompleteHandler);
            this._dataProvider.dispose();
            this._dataProvider = null;
         }
         this._renderers = null;
         if(this._vPositionByNation)
         {
            App.utils.data.cleanupDynamicObject(this._vPositionByNation);
         }
         this._vPositionByNation = null;
         if(this._hPositionByNation)
         {
            App.utils.data.cleanupDynamicObject(this._hPositionByNation);
         }
         this._hPositionByNation = null;
         this._itemRendererClass = null;
         this._view = null;
         this._curRend = null;
         this._asserter = null;
         this.cleanNodeSelectorCallbacks(this.treeNodeSelector);
         this.treeNodeSelector.dispose();
         this.treeNodeSelector = null;
         this.bounds = null;
         this._levelsBg = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._totalWidth = _width;
         this._totalHeight = _height;
         if(this.scrollBar != null)
         {
            this.scrollBar.addEventListener(Event.SCROLL,this.onScrollBarScrollHandler,false,0,true);
            this.scrollBar.focusTarget = this;
            this.scrollBar.tabEnabled = false;
            this.scrollBar.isSmooth = true;
         }
         if(this.vScrollBar != null)
         {
            this.vScrollBar.addEventListener(Event.SCROLL,this.onVScrollBarScrollHandler,false,0,true);
            this.vScrollBar.focusTarget = this;
            this.vScrollBar.tabEnabled = false;
            this.vScrollBar.isSmooth = true;
         }
         addEventListener(MouseEvent.MOUSE_WHEEL,this.onMouseWheelHandler,false,0,true);
         this.setCursors();
         this.ntGraphics.mouseEnabled = false;
         this.ntGraphics.addEventListener(MouseEvent.MOUSE_MOVE,this.onNtGraphicsMouseMoveHandler,false,0,true);
         this.premiumHitArea.addEventListener(MouseEvent.MOUSE_OVER,this.onPremPanelMouseOverHandler);
         this.premiumHitArea.addEventListener(MouseEvent.MOUSE_OUT,this.onPremPanelMouseOutHandler);
         this.premiumHitArea.addEventListener(MouseEvent.MOUSE_MOVE,this.onPremPanelMouseMoveHandler,false,0,true);
         this.premiumPanelShadow.mouseEnabled = false;
         this.setupTreeNodeSelector(this.treeNodeSelector);
         this.setupTreeNodeSelector(this.premiumPanel.treeNodeSelector);
         this.premiumPanel.bgLeftOffset = x;
         this.premiumPanelBack.x = -x;
         this.premiumPanelBack.panelHeight = PREMIUM_PANEL_HEIGHT;
         this.premiumPanelBack.mouseChildren = this.premiumPanelBack.mouseEnabled = false;
         this.premiumHitArea.x = -x;
         this.premiumPanelClickArea.x = -x;
         this.premiumPanelShadow.x = -x;
         this.updateTreeNodeSelector();
         this._premiumPanelShadowHitArea = new Sprite();
         this.premiumPanelShadow.addChild(this._premiumPanelShadowHitArea);
         this.premiumPanelShadow.hitArea = this._premiumPanelShadowHitArea;
      }
      
      override protected function draw() : void
      {
         var _loc1_:NationGridDisplaySettings = null;
         super.draw();
         if(this._dataProvider && isInvalid(InvalidationType.DATA))
         {
            this.ntGraphics.setup();
            this._nationTreeActionsHelper.reset();
            this.premiumPanel.setNodeSize(NODE_WIDTH,NODE_HEIGHT);
            this.premiumPanel.levelsInfo = this._dataProvider.getPremiumLevelInfo();
            this.premiumPanel.gridSettings = this._dataProvider.getPremiumGridSettings();
            this.premiumPanel.initPremiumPanelWithDots();
            this.updatePremiumPanelLayouts();
            this.itemRendererName = this._dataProvider.getDisplaySettings().nodeRendererName;
            this.drawRenderers();
            if(this._renderers.length > 0)
            {
               this.ntGraphics.mainLine.y = this.rootRenderer.y + MAIN_LINE_OFFSET_Y;
               _loc1_ = this._dataProvider.getCommonGridSettings();
               this.ntGraphics.mainLine.width = 2 * _loc1_.start.x + (_loc1_.columns - 1) * _loc1_.step.x + NODE_WIDTH + MAIN_LINE_WIDTH_OFFSET;
               this.drawLevels();
            }
            this.updatePremiumPanelVisibility(this.isPremiumPanelVisible());
            if(!this._hPositionByNation.hasOwnProperty(this.dataProvider.nation))
            {
               this.scrollToIndex(this.dataProvider.getScrollIndex());
            }
            else
            {
               this.updateScrollHPosition(this._hPositionByNation[this.dataProvider.nation]);
               this.updateScrollVPosition(this._vPositionByNation[this.dataProvider.nation]);
            }
            this.ntGraphics.show();
            this.levels.visible = true;
            this._tutorialMgr.dispatchEventForCustomComponent(this);
            this.updateCursors();
            this.hideTreeNodeSelector();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayouts();
         }
         if(isInvalid(INV_RENDERERS_LINES_STATE))
         {
            this.drawLines();
         }
      }
      
      public function closePremiumPanel(param1:Boolean = false) : void
      {
         if(param1 || this.premiumPanel.isOpened && this.premiumHitArea && this.premiumHitArea.mouseY <= 0 && !this._isDragging)
         {
            if(this.premiumPanel.isOpened)
            {
               App.soundMgr.playControlsSnd(SoundManagerStates.SND_OUT,SoundTypes.PREMIUM_PANEL,null);
            }
            this.premiumPanelBack.hidePanel(PREMIUM_PANEL_ANIMATION_OFFSET);
            this.premiumPanel.hidePanel(PREMIUM_PANEL_ANIMATION_OFFSET);
            this.clearPremiumShadowTween();
            this._premiumPanelShadowTween = new Tween(PREMIUM_SHADOW_TWEEN_DURATION,this.premiumPanelShadow,{"alpha":1},{"ease":Linear.easeNone});
            this.resetPremiumHitArea();
            this.vScrollBar.visible = this._savedVScrollVisibility;
            this._contextMenuMgr.hide();
         }
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
      
      public function getDragType() : String
      {
         return DragType.SOFT;
      }
      
      public function getHitArea() : InteractiveObject
      {
         return this.bounds;
      }
      
      public function getNation() : String
      {
         return this._dataProvider.nation;
      }
      
      public function getNodeByID(param1:int) : IRenderer
      {
         return this._renderers[this._dataProvider.getIndexByID(param1)];
      }
      
      public function getTutorialDescriptionName() : String
      {
         return name + TUTORIAL_DESCR_SEPARATOR + this._itemRendererName;
      }
      
      public function hideTreeNodeSelector() : void
      {
         this._curRend = null;
         this.updateTreeNodeSelector();
      }
      
      public function invalidateNodesData(param1:String, param2:Object) : void
      {
         this.ntGraphics.hide();
         this.levels.visible = false;
         this._hPositionByNation[this.dataProvider.nation] = this.scrollHPosition;
         this._vPositionByNation[this.dataProvider.nation] = this.scrollVPosition;
         this._dataProvider.invalidate(param1,param2);
      }
      
      public function invalidatePremiumPanelLabels(param1:Object) : void
      {
         this.premiumPanel.premiumBtnLabelTemplate = !!param1.hasOwnProperty(VEHICLE_LABEL) ? param1[VEHICLE_LABEL] : [];
         this.premiumPanelBack.panelTitle = !!param1.hasOwnProperty(PANEL_TITLE) ? param1[PANEL_TITLE] : Values.EMPTY_STR;
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return true;
      }
      
      public function onDragging(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = App.stage.mouseX;
         var _loc4_:Number = App.stage.mouseY;
         if(this._curRend)
         {
            this.hideTreeNodeSelector();
         }
         this.updateScrollHPosition(this.scrollHPosition - (_loc3_ - this._dragHOffset) / SCROLL_STEP_FACTOR);
         if(!this.isPremiumPanelVisible() || !this.premiumPanel.isOpened)
         {
            this.updateScrollVPosition(this.scrollVPosition - (_loc4_ - this._dragVOffset) / SCROLL_STEP_FACTOR);
         }
         this._dragHOffset = _loc3_;
         this._dragVOffset = _loc4_;
      }
      
      public function onEndDrag() : void
      {
         this._isDragging = false;
         this.ntGraphics.mouseChildren = true;
         this.premiumPanel.mouseChildren = this.premiumPanel.mouseEnabled = true;
         this.premiumHitArea.mouseChildren = this.premiumPanelClickArea.mouseChildren = true;
         this.premiumHitArea.mouseEnabled = this.premiumPanelClickArea.mouseEnabled = this.premiumPanel.visible;
         if(this.premiumPanel.isOpened && !this.premiumHitArea.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
         {
            this.closePremiumPanel(true);
         }
      }
      
      public function onStartDrag() : void
      {
         this._isDragging = true;
         this._dragHOffset = App.stage.mouseX;
         this._dragVOffset = App.stage.mouseY;
         this.ntGraphics.mouseChildren = false;
         this.premiumPanel.mouseChildren = this.premiumPanel.mouseEnabled = false;
         this.premiumHitArea.mouseChildren = this.premiumHitArea.mouseEnabled = false;
         this.premiumPanelClickArea.mouseChildren = this.premiumPanelClickArea.mouseEnabled = false;
      }
      
      public function openPremiumPanel() : void
      {
         if(!this.premiumPanel.isOpened)
         {
            App.soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.PREMIUM_PANEL,null);
            this.premiumPanelBack.showPanel(PREMIUM_PANEL_ANIMATION_OFFSET);
            this.premiumPanel.showPanel(PREMIUM_PANEL_ANIMATION_OFFSET - PREMIUM_PANEL_TITLE_OFFSET);
            this.premiumHitArea.y = this.premiumPanelBack.defaultY - PREMIUM_PANEL_ANIMATION_OFFSET;
            this.premiumHitArea.height = PREMIUM_PANEL_HEIGHT + PREMIUM_PANEL_HIT_AREA_OPEN_OFFSET;
            this.premiumPanelClickArea.y = this.premiumHitArea.y;
            this.premiumPanelClickArea.height = this.premiumHitArea.height;
            this.premiumPanelClickArea.mouseEnabled = false;
            this.clearPremiumShadowTween();
            this._premiumPanelShadowTween = new Tween(PREMIUM_SHADOW_TWEEN_DURATION,this.premiumPanelShadow,{"alpha":0},{"ease":Linear.easeNone});
            this.vScrollBar.visible = false;
            this._contextMenuMgr.hide();
         }
      }
      
      public function setItemsField(param1:Array, param2:String) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:IRenderer = null;
         var _loc3_:int = param1.length;
         var _loc7_:int = this._dataProvider.length;
         var _loc8_:int = 0;
         while(_loc8_ < _loc3_)
         {
            _loc5_ = param1[_loc8_];
            _loc4_ = this._dataProvider.getIndexByID(_loc5_[0]);
            if(_loc4_ > -1 && _loc7_ > _loc4_)
            {
               this._dataProvider.setItemField(param2,_loc4_,_loc5_[1]);
               _loc6_ = this._renderers[_loc4_];
               _loc6_.invalidateNodeState();
            }
            _loc8_++;
         }
         if(param2 == NodeData.VEH_COMPARE_TREE_NODE_DATA)
         {
            this.updateTreeNodeSelector();
         }
      }
      
      public function setNodesStates(param1:Number, param2:Array, param3:String = null) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:Boolean = false;
         var _loc4_:int = param2.length;
         var _loc8_:int = this._dataProvider.length;
         var _loc9_:int = 0;
         while(_loc9_ < _loc4_)
         {
            _loc6_ = param2[_loc9_];
            _loc5_ = this._dataProvider.getIndexByID(_loc6_[0]);
            if(_loc5_ > -1 && _loc8_ > _loc5_)
            {
               if(param3 != null)
               {
                  _loc7_ = this._dataProvider.setItemField(param3,_loc5_,_loc6_[2]);
               }
               else
               {
                  _loc7_ = false;
               }
               if(this._dataProvider.setState(_loc5_,param1,_loc6_[1]) || _loc7_)
               {
                  this._renderers[_loc5_].invalidateNodeState();
               }
            }
            _loc9_++;
         }
      }
      
      public function setVehicleTypeXP(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc2_:int = param1.length;
         var _loc5_:int = this._dataProvider.length;
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_)
         {
            _loc4_ = param1[_loc6_];
            _loc3_ = this._dataProvider.getIndexByID(_loc4_[0]);
            if(_loc3_ > -1 && _loc5_ > _loc3_)
            {
               this._dataProvider.setEarnedXP(_loc3_,_loc4_[1]);
               this._renderers[_loc3_].invalidateNodeState();
            }
            _loc6_++;
         }
      }
      
      private function showLevelHighlight(param1:int) : void
      {
         this.levels.showLevelHighlight(param1);
      }
      
      private function hideLevelHighlight() : void
      {
         this.levels.hideLevelHighlight();
      }
      
      private function updateLevelsBgColor() : void
      {
         var _loc1_:ColorTransform = new ColorTransform();
         _loc1_.color = !!this._blueprintModeOn ? uint(LEVELS_BG_COLOR_BP) : uint(LEVELS_BG_COLOR);
         _loc1_.alphaMultiplier = LEVELS_BG_ALPHA;
         this._levelsBg.transform.colorTransform = _loc1_;
      }
      
      private function clearPremiumShadowTween() : void
      {
         if(this._premiumPanelShadowTween != null)
         {
            this._premiumPanelShadowTween.paused = true;
            this._premiumPanelShadowTween.dispose();
            this._premiumPanelShadowTween = null;
         }
      }
      
      private function scrollToIndex(param1:int) : void
      {
         var _loc2_:IRenderer = null;
         if(-1 < param1 && param1 < this._renderers.length)
         {
            _loc2_ = this._renderers[param1];
            if(_loc2_ != null)
            {
               this.updateScrollHPosition((_loc2_.x + (NODE_WIDTH - (width + NT_WIDTH_OFFSET) >> 1)) / SCROLL_STEP_FACTOR);
               this.updateScrollVPosition((_loc2_.y + (NODE_HEIGHT - height >> 1)) / SCROLL_STEP_FACTOR);
            }
         }
      }
      
      private function getLevelsMaxY() : int
      {
         return this.levels.y + this.levels.height;
      }
      
      private function updateLayouts() : void
      {
         this.bounds.width = _width;
         this.bounds.height = _height;
         this._levelsBg.width = _width + Math.abs(this._levelsBg.x);
         this._levelsBg.height = this.getLevelsMaxY();
         this.updatePremiumPanelLayouts();
         if(this.scrollBar != null)
         {
            this.scrollBar.y = _height - SCROLLBAR_BOOTOM_OFFSET | 0;
            this.scrollBar.width = _width - SCROLLBAR_RIGHT_OFFSET | 0;
            this.scrollBar.validateNow();
         }
         if(this.vScrollBar != null)
         {
            this.vScrollBar.x = _width + VSCROLL_OFFSET_X | 0;
            this.updateVScrollBarHeight();
         }
         this.updateScrollHPosition(this.scrollHPosition);
         this.updateScrollVPosition(this.scrollVPosition);
         this.updateCursors();
         this._nationTreeActionsHelper.updateLayouts();
      }
      
      private function updateCursors() : void
      {
         this.clearCursors();
         this.setCursors();
      }
      
      private function setCursors() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         if(this._cursorMgr != null)
         {
            _loc1_ = this.maxHScroll > 0;
            _loc2_ = this.maxVScroll > 0;
            _loc3_ = !!_loc2_ ? Cursors.DRAG_CLOSE : Cursors.MOVE;
            if(_loc1_ || _loc2_)
            {
               this._cursorMgr.registerDragging(this,_loc3_);
            }
            if(_loc1_)
            {
               this._cursorMgr.registerDragging(this.premiumHitArea,_loc3_);
            }
         }
      }
      
      private function clearCursors() : void
      {
         if(this._cursorMgr != null)
         {
            this._cursorMgr.unRegisterDragging(this);
            this._cursorMgr.unRegisterDragging(this.premiumHitArea);
         }
      }
      
      private function updateVScrollBarHeight() : void
      {
         this.vScrollBar.height = _height + VSCROLL_OFFSET_Y - this.getVScrollBottomOffset() | 0;
         this.vScrollBar.validateNow();
         this.updateScrollVPosition(this.scrollVPosition);
      }
      
      private function updatePremiumPanelLayouts() : void
      {
         if(this.premiumPanel == null)
         {
            return;
         }
         this.premiumPanelBack.defaultY = this.getPremiumPanelBottomOffset() >> 0;
         this.premiumPanel.defaultY = this.premiumPanelBack.defaultY - PREMIUM_PANEL_ITEMS_V_OFFSET;
         this.premiumPanel.panelWidth = this.ntGraphics.width;
         this.premiumPanelBack.panelWidth = _width + x;
         this.premiumHitArea.width = _width + x;
         this.premiumPanelClickArea.width = _width + x;
         this.premiumPanelShadow.width = _width + x;
         this.premiumPanelShadow.y = _height - this.premiumPanelShadow.height;
         this.closePremiumPanel(true);
      }
      
      private function activateCoolDown() : void
      {
         this._requestInCoolDown = true;
         this._scheduler.scheduleTask(this.deactivateCoolDown,DEF_ACTIVATE_COOLDOWN);
      }
      
      private function onPremPanelMouseOverHandler(param1:Event) : void
      {
         if(!this._isDragging)
         {
            this.hideTreeNodeSelector();
            this.openPremiumPanel();
         }
      }
      
      private function resetPremiumHitArea() : void
      {
         var _loc1_:NationGridDisplaySettings = this._dataProvider.getPremiumGridSettings();
         var _loc2_:int = _loc1_ != null && _loc1_.start ? int(_loc1_.start.y) : int(PREMIUM_PANEL_NODES_DEFAULT_START_Y);
         this.premiumHitArea.y = this.premiumPanel.defaultY + _loc2_ - PREMIUM_PANEL_HIT_AREA_DEFAULT_OFFSET >> 0;
         this.premiumHitArea.height = PREMIUM_PANEL_HEIGHT;
         this.premiumPanelClickArea.y = this.premiumPanel.defaultY + PREMIUM_PANEL_CLICK_AREA_OFFSET;
         this.premiumPanelClickArea.height = PREMIUM_PANEL_HEIGHT + _loc2_;
         this.premiumPanelClickArea.mouseEnabled = true;
      }
      
      private function onPremPanelMouseOutHandler(param1:Event) : void
      {
         this.closePremiumPanel();
      }
      
      private function deactivateCoolDown() : void
      {
         this._requestInCoolDown = false;
      }
      
      private function createItemRenderer() : IRenderer
      {
         return new this._itemRendererClass();
      }
      
      private function setupItemRenderer(param1:IRenderer, param2:int, param3:NodeData, param4:uint = 1) : void
      {
         this._nationTreeActionsHelper.setupRenderer(param1,param3,this.ntGraphics);
         param1.container = this;
         param1.setup(param2,param3,param4);
         param1.addEventListener(TechTreeEvent.CLICK_2_OPEN,this.onRendererClick2OpenHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_UNLOCK,this.onRendererClick2UnlockHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_BUY,this.onRendererClick2BuyHandler,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OVER,this.onRendRollOverHandler,false,0,true);
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onRendRollOutHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.RESTORE_VEHICLE,this.onRendererRestoreVehicleHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.STATE_CHANGED,this.onRendererStateChangedHandler,false,0,true);
      }
      
      private function removeItemRenderer(param1:IRenderer) : void
      {
         param1.removeEventListener(TechTreeEvent.CLICK_2_OPEN,this.onRendererClick2OpenHandler);
         param1.removeEventListener(TechTreeEvent.CLICK_2_UNLOCK,this.onRendererClick2UnlockHandler);
         param1.removeEventListener(TechTreeEvent.CLICK_2_BUY,this.onRendererClick2BuyHandler);
         param1.removeEventListener(MouseEvent.ROLL_OVER,this.onRendRollOverHandler);
         param1.removeEventListener(MouseEvent.ROLL_OUT,this.onRendRollOutHandler);
         param1.removeEventListener(TechTreeEvent.RESTORE_VEHICLE,this.onRendererRestoreVehicleHandler);
         param1.removeEventListener(TechTreeEvent.STATE_CHANGED,this.onRendererStateChangedHandler);
         this.removeRenderer(param1);
         param1.dispose();
      }
      
      private function removeItemRenderers() : void
      {
         while(this._renderers.length > 0)
         {
            this.removeItemRenderer(this._renderers.pop());
         }
      }
      
      private function drawRenderers() : void
      {
         var _loc2_:IRenderer = null;
         var _loc3_:NodeData = null;
         if(this._itemRendererClass == null)
         {
            return;
         }
         this.ntGraphics.clearCache();
         var _loc1_:int = this._dataProvider.length;
         while(this._renderers.length > _loc1_)
         {
            this.removeItemRenderer(this._renderers.pop());
         }
         var _loc4_:uint = !!this._blueprintModeOn ? uint(NodeEntityType.BLUEPRINT_TREE) : uint(NodeEntityType.NATION_TREE);
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         this.premiumPanel.clearButtons();
         var _loc7_:int = 0;
         while(_loc7_ < _loc1_)
         {
            _loc3_ = this._dataProvider.getItemAt(_loc7_);
            if(_loc7_ < this._renderers.length)
            {
               _loc5_ = false;
               _loc2_ = this._renderers[_loc7_];
               this.ntGraphics.clearUpRenderer(_loc2_);
               _loc6_ = _loc2_.isPremium() != this._dataProvider.isPremiumItem(_loc7_);
               this.setupItemRenderer(_loc2_,_loc7_,_loc3_,_loc4_);
               if(_loc6_ || _loc2_.isPremium())
               {
                  this.removeRenderer(_loc2_);
                  if(!_loc2_.isPremium())
                  {
                     this.ntGraphics.addChild(DisplayObject(_loc2_));
                  }
                  else
                  {
                     this.premiumPanel.addRenderer(_loc2_);
                  }
               }
            }
            else
            {
               _loc5_ = true;
               _loc2_ = this.createItemRenderer();
            }
            if(_loc5_ && _loc2_ != null)
            {
               this.setupItemRenderer(_loc2_,_loc7_,_loc3_,_loc4_);
               if(!_loc2_.isPremium())
               {
                  this.ntGraphics.addChild(DisplayObject(_loc2_));
               }
               else
               {
                  this.premiumPanel.addRenderer(_loc2_);
               }
               this._renderers.push(_loc2_);
            }
            _loc7_++;
         }
      }
      
      private function removeRenderer(param1:IRenderer) : void
      {
         if(this.premiumPanel.hasRenderer(param1))
         {
            this.premiumPanel.removeRenderer(param1);
         }
         else
         {
            this.ntGraphics.removeRenderer(param1);
         }
      }
      
      private function drawLines() : void
      {
         this.ntGraphics.clearLinesAndArrowsRenderers();
         var _loc1_:int = this._renderers.length;
         if(_loc1_ > 0)
         {
            this.ntGraphics.drawTopLines(this._renderers[0],false);
         }
         var _loc2_:int = 1;
         while(_loc2_ < _loc1_)
         {
            this.ntGraphics.drawNodeLines(this._renderers[_loc2_],false);
            _loc2_++;
         }
      }
      
      private function drawLevels() : void
      {
         var _loc7_:NTDisplayInfo = null;
         var _loc8_:IRenderer = null;
         var _loc9_:int = 0;
         var _loc1_:Vector.<LevelHeaderInfo> = new Vector.<LevelHeaderInfo>(this._dataProvider.getCommonGridSettings().columns);
         var _loc2_:int = 0;
         var _loc3_:Boolean = this._dataProvider.getDisplaySettings().isLevelDisplayed;
         var _loc4_:LevelHeaderInfo = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         this._ntGraphicsOffsetY = int.MAX_VALUE;
         for each(_loc8_ in this._renderers)
         {
            _loc5_ = Math.max(_loc5_,_loc8_.getInX() + NODE_WIDTH);
            _loc7_ = _loc8_.getDisplayInfo() as NTDisplayInfo;
            if(!_loc8_.isPremium())
            {
               this._ntGraphicsOffsetY = Math.min(this._ntGraphicsOffsetY,_loc8_.y);
               _loc6_ = Math.max(_loc6_,_loc8_.y + NODE_HEIGHT);
            }
            if(_loc3_)
            {
               _loc2_ = Boolean(_loc7_) ? int(_loc7_.column - 1) : int(-1);
               if(_loc2_ >= 0)
               {
                  if(_loc1_[_loc2_] != null)
                  {
                     _loc4_ = _loc1_[_loc2_];
                     _loc4_.start = Math.min(_loc4_.start,_loc8_.getInX());
                     _loc4_.end = Math.max(_loc4_.end,_loc8_.getInX());
                  }
                  else
                  {
                     _loc1_[_loc2_] = new LevelHeaderInfo(_loc8_.getInX(),_loc8_.getInX(),_loc8_.getLevel());
                  }
               }
            }
         }
         _loc9_ = this.drawLevelsDelimiters(_loc1_,CONTAINER_HEIGHT - (this.scrollBar != null ? this.scrollBar.height : 0),NODE_WIDTH);
         this._totalWidth = _loc5_ + Math.max(_loc9_,MIN_RIGHT_MARGIN);
         this._totalHeight = Math.max(_loc6_ + MIN_NODE_MARGIN,this.ntGraphics.mainLine.y + this.ntGraphics.mainLine.height);
         this._ntGraphicsOffsetY = Math.min(this._ntGraphicsOffsetY - MIN_NODE_MARGIN,this.ntGraphics.mainLine.y);
      }
      
      private function drawLevelsDelimiters(param1:Vector.<LevelHeaderInfo>, param2:int, param3:int) : int
      {
         return this.levels == null ? int(0) : int(this.levels.updateLevels(param1,param2,param3));
      }
      
      private function setupTreeNodeSelector(param1:ISoundButtonEx) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.tooltip = VEH_COMPARE.TECHTREE_TOOLTIPS_ADDTOCOMPARE;
         param1.addEventListener(MouseEvent.ROLL_OUT,this.onTreeNodeSelectorRollOutHandler,false,0,true);
         param1.addEventListener(ButtonEvent.CLICK,this.onTreeNodeSelectorClickHandler,false,0,true);
      }
      
      private function cleanNodeSelectorCallbacks(param1:ISoundButtonEx) : void
      {
         if(param1 != null)
         {
            param1.removeEventListener(MouseEvent.ROLL_OUT,this.onTreeNodeSelectorRollOutHandler);
            param1.removeEventListener(ButtonEvent.CLICK,this.onTreeNodeSelectorClickHandler);
         }
      }
      
      private function updateTreeNodeSelector() : void
      {
         var _loc2_:NodeData = null;
         var _loc1_:Point = null;
         if(this._curRend != null && !this._blueprintModeOn && !this._isDragging)
         {
            _loc2_ = this.dataProvider.getItemByID(this._curRend.getID());
            if(_loc2_ != null && _loc2_.isCompareModeAvailable && !_loc2_.isCompareBasketFull)
            {
               if(!this._curRend.isPremium())
               {
                  this.treeNodeSelector.x = this._curRend.x + this.ntGraphics.x + TREE_NODE_SELECTOR_X_SHIFT;
                  this.treeNodeSelector.y = this._curRend.y + this.ntGraphics.y + TREE_NODE_SELECTOR_Y_SHIFT;
                  this.treeNodeSelector.visible = true;
               }
               else
               {
                  _loc1_ = new Point(this._curRend.x + TREE_NODE_SELECTOR_X_SHIFT,this._curRend.y + TREE_NODE_SELECTOR_Y_SHIFT);
                  this.premiumPanel.setNodeSelectorVisibility(_loc1_,true);
               }
               return;
            }
         }
         this.treeNodeSelector.visible = false;
         this.premiumPanel.setNodeSelectorVisibility(_loc1_,false);
      }
      
      private function updateScrollHPosition(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = this.maxHScroll > 0;
         param1 = Math.max(0,Math.min(this.maxHScroll,param1));
         if(this.scrollBar != null)
         {
            this.scrollBar.setScrollProperties(this.scrollHPageSize,0,this.maxHScroll);
            this.scrollBar.position = param1;
            this.scrollBar.visible = _loc2_;
         }
         if(_loc2_)
         {
            _loc3_ = -param1 * SCROLL_STEP_FACTOR;
         }
         else
         {
            _loc3_ = _width - this._totalWidth >> 1;
         }
         if(this.maxVScroll > 0)
         {
            _loc3_ += NT_GRAPHICS_OFFSET_X;
         }
         this.levels.x = this.premiumPanel.x = this.ntGraphics.x = _loc3_;
      }
      
      private function isPremiumPanelVisible() : Boolean
      {
         return !this._blueprintModeOn && this.premiumPanel.visibleNodesCount > 0;
      }
      
      private function updateScrollVPosition(param1:Number) : void
      {
         param1 = Math.max(0,Math.min(this.maxVScroll,param1));
         var _loc2_:Boolean = this.maxVScroll > 0;
         if(this.vScrollBar != null)
         {
            this.vScrollBar.setScrollProperties(this.scrollVPage,0,this.maxVScroll);
            this.vScrollBar.position = param1;
            this.vScrollBar.visible = _loc2_;
            this._savedVScrollVisibility = _loc2_;
         }
         if(_loc2_)
         {
            this.ntGraphics.y = -param1 * SCROLL_STEP_FACTOR + this.getLevelsMaxY() - this._ntGraphicsOffsetY | 0;
         }
         else
         {
            this.ntGraphics.y = this.getLevelsMaxY() - this._ntGraphicsOffsetY + (this.getPremiumPanelBottomOffset() - this.getLevelsMaxY() - (this._totalHeight - this._ntGraphicsOffsetY) >> 1);
         }
      }
      
      private function getPremiumPanelBottomOffset() : int
      {
         return _height - PREMIUM_PANEL_VERTICAL_OFFSET;
      }
      
      private function getVScrollBottomOffset() : int
      {
         return !!this.isPremiumPanelVisible() ? int(PREMIUM_PANEL_VERTICAL_OFFSET) : int(VSCROLL_NO_PANEL_OFFSET_Y);
      }
      
      public function updatePremiumPanelVisibility(param1:Boolean) : void
      {
         this.premiumPanel.visible = param1;
         this.premiumPanelBack.visible = param1;
         this.premiumHitArea.mouseEnabled = param1;
         this.premiumPanelClickArea.mouseEnabled = param1;
         this.premiumPanelShadow.visible = param1;
      }
      
      public function get rootRenderer() : IRenderer
      {
         return this._renderers[0];
      }
      
      public function get view() : ITechTreePage
      {
         return this._view;
      }
      
      public function set view(param1:ITechTreePage) : void
      {
         if(param1 == this._view)
         {
            return;
         }
         this._view = param1;
         if(this._view != null)
         {
            this.scrollBar = this._view.getScrollBar();
            this.scrollBar.isSmooth = true;
            this.vScrollBar = this._view.getVScrollBar();
            this.vScrollBar.isSmooth = true;
         }
      }
      
      public function get dataProvider() : INationTreeDataProvider
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:INationTreeDataProvider) : void
      {
         if(this._dataProvider != null)
         {
            this._dataProvider.removeEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.onDataProviderDataBuildCompleteHandler);
         }
         this._dataProvider = param1;
         if(this._dataProvider != null)
         {
            this._dataProvider.addEventListener(TechTreeEvent.DATA_BUILD_COMPLETE,this.onDataProviderDataBuildCompleteHandler,false,0,true);
         }
      }
      
      public function get blueprintModeOn() : Boolean
      {
         return this._blueprintModeOn;
      }
      
      public function set blueprintModeOn(param1:Boolean) : void
      {
         var _loc3_:IRenderer = null;
         if(this._blueprintModeOn == param1)
         {
            return;
         }
         this._blueprintModeOn = param1;
         this.updateTreeNodeSelector();
         var _loc2_:uint = !!this._blueprintModeOn ? uint(NodeEntityType.BLUEPRINT_TREE) : uint(NodeEntityType.NATION_TREE);
         for each(_loc3_ in this._renderers)
         {
            _loc3_.entityType = _loc2_;
         }
         this.updatePremiumPanelVisibility(this.isPremiumPanelVisible());
         this.updateVScrollBarHeight();
         this.updateLevelsBgColor();
      }
      
      private function set itemRendererName(param1:String) : void
      {
         if(param1 == Values.EMPTY_STR || this._itemRendererName == param1)
         {
            return;
         }
         this._itemRendererName = param1;
         var _loc2_:Class = App.utils.classFactory.getClass(this._itemRendererName);
         this._asserter.assertNotNull(_loc2_,Errors.BAD_LINKAGE + this._itemRendererName);
         this._itemRendererClass = _loc2_;
         this.removeItemRenderers();
      }
      
      private function get scrollHPosition() : Number
      {
         return this.scrollBar.position;
      }
      
      private function get maxHScroll() : Number
      {
         return (this._totalWidth - (width + NT_WIDTH_OFFSET)) / SCROLL_STEP_FACTOR;
      }
      
      private function get scrollHPageSize() : Number
      {
         return (width + NT_WIDTH_OFFSET) / SCROLL_STEP_FACTOR;
      }
      
      private function get scrollVPosition() : Number
      {
         return this.vScrollBar.position;
      }
      
      private function get maxVScroll() : Number
      {
         return (this._totalHeight - this._ntGraphicsOffsetY - this.getPremiumPanelBottomOffset() + this.getLevelsMaxY()) / SCROLL_STEP_FACTOR;
      }
      
      private function get scrollVPage() : Number
      {
         return height / SCROLL_STEP_FACTOR;
      }
      
      private function onRendererStateChangedHandler(param1:TechTreeEvent) : void
      {
         var _loc2_:IRenderer = this.rootRenderer;
         if(_loc2_ != null && NodeStateCollection.instance.isRedrawNTLines(param1.nodeState))
         {
            invalidate(INV_RENDERERS_LINES_STATE);
         }
      }
      
      private function onDataProviderDataBuildCompleteHandler(param1:TechTreeEvent) : void
      {
         invalidateData();
      }
      
      private function onScrollBarScrollHandler(param1:Event) : void
      {
         var _loc2_:Number = param1.target.position;
         if(isNaN(_loc2_))
         {
            return;
         }
         this.updateScrollHPosition(_loc2_);
         this._contextMenuMgr.hide();
      }
      
      private function onVScrollBarScrollHandler(param1:Event) : void
      {
         var _loc2_:Number = param1.target.position;
         if(isNaN(_loc2_))
         {
            return;
         }
         this.updateScrollVPosition(_loc2_);
         this._contextMenuMgr.hide();
      }
      
      private function onMouseWheelHandler(param1:MouseEvent) : void
      {
         var _loc2_:Number = 0;
         if(this.maxHScroll > 0)
         {
            _loc2_ = this.scrollHPosition - (param1.delta > 0 ? 1 : -1);
            this.updateScrollHPosition(_loc2_);
         }
         else if(!this.premiumPanel.isOpened && this.maxVScroll > 0)
         {
            _loc2_ = this.scrollVPosition - (param1.delta > 0 ? 1 : -1);
            this.updateScrollVPosition(_loc2_);
         }
         this.updateTreeNodeSelector();
      }
      
      private function onRendererClick2OpenHandler(param1:TechTreeEvent) : void
      {
         if(this.view == null)
         {
            return;
         }
         this.view.goToNextVehicleS(this.dataProvider.getItemAt(param1.index).id);
      }
      
      private function onRendererClick2UnlockHandler(param1:TechTreeEvent) : void
      {
         if(!this._requestInCoolDown && this.view != null)
         {
            this.view.request4UnlockS(this.dataProvider.getItemAt(param1.index).id);
            this.activateCoolDown();
         }
      }
      
      private function onRendererClick2BuyHandler(param1:TechTreeEvent) : void
      {
         if(!this._requestInCoolDown && this.view != null)
         {
            this.view.request4BuyS(this.dataProvider.getItemAt(param1.index).id);
            this.activateCoolDown();
         }
      }
      
      private function onRendererRestoreVehicleHandler(param1:TechTreeEvent) : void
      {
         var _loc2_:NodeData = null;
         if(!this._requestInCoolDown && this.view != null && param1.index > -1)
         {
            _loc2_ = this._dataProvider.getItemAt(param1.index);
            this.view.request4RestoreS(_loc2_.id);
            this.activateCoolDown();
         }
      }
      
      private function onTreeNodeSelectorClickHandler(param1:ButtonEvent) : void
      {
         if(!this._requestInCoolDown && this.view != null)
         {
            this.view.request4VehCompareS(this._curRend.getID());
            this.activateCoolDown();
         }
      }
      
      private function onRendRollOverHandler(param1:MouseEvent) : void
      {
         this._curRend = param1.target as IRenderer;
         var _loc2_:NTDisplayInfo = this._curRend.getDisplayInfo() as NTDisplayInfo;
         this.updateTreeNodeSelector();
         if(this._curRend)
         {
            this.showLevelHighlight(Boolean(_loc2_) ? int(_loc2_.column) : int(0));
            if(this._curRend.isPremium() && !this.premiumPanel.isOpened)
            {
               this.openPremiumPanel();
            }
            if(!this._curRend.isPremium() && this.premiumPanel.isOpened)
            {
               this.closePremiumPanel(true);
            }
         }
      }
      
      private function onRendRollOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:ISoundButtonEx = null;
         if(this._curRend)
         {
            _loc2_ = !!this._curRend.isPremium() ? this.premiumPanel.treeNodeSelector : this.treeNodeSelector;
         }
         if(_loc2_ && !_loc2_.hitArea.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
         {
            this.hideSelectorAndHighlight();
         }
      }
      
      private function onTreeNodeSelectorRollOutHandler(param1:MouseEvent) : void
      {
         if(!this._curRend.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
         {
            this.hideSelectorAndHighlight();
         }
      }
      
      private function hideSelectorAndHighlight() : void
      {
         this.hideLevelHighlight();
         this.hideTreeNodeSelector();
      }
      
      private function onNtGraphicsMouseMoveHandler(param1:MouseEvent) : void
      {
         if(param1.buttonDown)
         {
            this.getHitArea().dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
         }
      }
      
      private function onPremPanelMouseMoveHandler(param1:MouseEvent) : void
      {
         if(this.maxHScroll > 0 && param1.buttonDown)
         {
            this.getHitArea().dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
         }
      }
   }
}
