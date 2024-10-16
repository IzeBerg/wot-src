package net.wg.gui.lobby.techtree.sub
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.POSTPROGRESSION_CONSTS;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.controls.ExperienceBlock;
   import net.wg.gui.lobby.techtree.controls.NationFlagContainer;
   import net.wg.gui.lobby.techtree.data.ResearchRootVO;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.data.vo.ResearchPostProgressionDataVO;
   import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
   import net.wg.gui.lobby.techtree.helpers.ResearchGraphics;
   import net.wg.gui.lobby.techtree.interfaces.IBorderHighlighted;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.interfaces.IResearchPage;
   import net.wg.gui.lobby.techtree.nodes.FakeNode;
   import net.wg.gui.lobby.techtree.nodes.ResearchRoot;
   import net.wg.gui.lobby.techtree.postProgression.EntryPoint;
   import net.wg.gui.lobby.tradeIn.TradeOffWidget;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.utils.IClassFactory;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class ResearchItems extends ModulesTree implements ITutorialCustomComponent, IStageSizeDependComponent
   {
      
      private static const COOLDOWN:int = 250;
      
      private static const SEPARATOR:String = ":";
      
      private static const SMALL_SIZE_SCALE:Number = 0.5;
      
      private static const MEDIUM_SIZE_SCALE:Number = 0.8;
      
      private static const NODE_DATA_NOT_FOUND:String = "Data of node not found by event = ";
      
      private static const NODE_IS_NOT_VEHICLE:String = "Node is not vehicle";
      
      private static const UNLOCK_INFORMATION_NOT_DEFINED:String = "Unlock information is not defined for node = ";
      
      private static const NATION_FLAG_ALPHA:Number = 1.2;
      
      private static const XP_INFO_NAME:String = "xpInfo";
      
      private static const CORNER_X:int = 18;
      
      private static const PREMIUM_ROOT_OUT_X:int = 180;
      
      private static const ERROR:String = "Error";
      
      private static const INV_POST_PROGRESSION:String = "invPostProgression";
      
      private static const POST_PROGRESSION_MARGIN:int = 23;
      
      private static const POST_PROGRESSION_PADDING:int = 22;
      
      private static const POST_PROGRESSION_OFFSET_MIN_Y:int = 56;
      
      private static const POST_PROGRESSION_OFFSET_MAX_Y:int = 76;
      
      private static const MAX_ROWS:int = 6;
       
      
      public var view:IResearchPage = null;
      
      public var background:Sprite = null;
      
      public var backgroundCollectible:Sprite = null;
      
      public var nationFlagContainer:NationFlagContainer = null;
      
      private var _requestInCoolDown:Boolean = false;
      
      private var _topRenderers:Vector.<IRenderer> = null;
      
      private var _vehicleNodeClass:Class = null;
      
      private var _rootRendererData:ResearchRootVO = null;
      
      private var _classFactory:IClassFactory;
      
      private var _postProgressionEntry:EntryPoint = null;
      
      private var _postProgressionData:ResearchPostProgressionDataVO = null;
      
      public function ResearchItems()
      {
         this._classFactory = App.utils.classFactory;
         super();
      }
      
      override public function getNodeByID(param1:int) : IRenderer
      {
         var _loc2_:Object = positionById[param1];
         var _loc3_:IRenderer = null;
         if(!_loc2_)
         {
            return null;
         }
         if(_loc2_.column == -1)
         {
            _loc3_ = this._topRenderers[_loc2_.row];
         }
         else
         {
            _loc3_ = super.getNodeByID(param1);
         }
         return _loc3_;
      }
      
      override public function getTopLevel() : Vector.<IRenderer>
      {
         return this._topRenderers;
      }
      
      override public function removeItemRenderer(param1:IRenderer) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(TechTreeEvent.CLICK_2_UNLOCK,this.onRendererClick2UnlockHandler);
         param1.removeEventListener(TechTreeEvent.CLICK_2_BUY,this.onRendererClick2BuyHandler);
         param1.removeEventListener(TechTreeEvent.GO_TO_VEHICLE_VIEW,this.onRendererGoToVehicleViewHandler);
         param1.removeEventListener(TechTreeEvent.CLICK_2_OPEN,this.onRendererClick2OpenHandler);
         param1.removeEventListener(TechTreeEvent.CLICK_2_OPEN,this.onRenderer2Click2OpenHandler);
         param1.removeEventListener(TechTreeEvent.CLICK_VEHICLE_COMPARE,this.onRendererClickVehicleCompareHandler);
         param1.removeEventListener(TechTreeEvent.RESTORE_VEHICLE,this.onRendererRestoreVehicleHandler);
         param1.removeEventListener(TechTreeEvent.GO_TO_BLUEPRINT_VIEW,this.onGoToBlueprintViewHandler);
         param1.removeEventListener(TechTreeEvent.CLICK_2_RENT,this.onRendererClick2RentHandler);
         param1.removeEventListener(TechTreeEvent.GO_TO_SHOP,this.onRendererGoToShopHandler);
         param1.removeEventListener(TechTreeEvent.GO_TO_CHANGE_NATION_VIEW,this.onGoToChangeNationViewHandler);
         param1.removeEventListener(TechTreeEvent.ON_MODULE_HOVER,this.onRendererOnModuleHoverHandler);
         param1.removeEventListener(TechTreeEvent.GO_TO_EARLY_ACCESS_QUESTS_VIEW,this.onRendererGoToEarlyAccessQuestsViewHandler);
         param1.removeEventListener(TechTreeEvent.GO_TO_EARLY_ACCESS_BUY_VIEW,this.onRendererGoToEarlyAccessBuyViewHandler);
         super.removeItemRenderer(param1);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         if(isInvalid(InvalidationType.SIZE))
         {
            rootRenderer.validateNow();
            _loc1_ = 1;
            if(_viewWidth < StageSizeBoundaries.WIDTH_1280)
            {
               _loc1_ = SMALL_SIZE_SCALE;
            }
            else if(_viewWidth < StageSizeBoundaries.WIDTH_1600)
            {
               _loc1_ = MEDIUM_SIZE_SCALE;
            }
            if(_viewWidth >= StageSizeBoundaries.WIDTH_1600)
            {
               ResearchRoot(rootRenderer).size = ResearchRoot.LARGE_SIZE;
            }
            else if(_viewWidth >= StageSizeBoundaries.WIDTH_1280)
            {
               ResearchRoot(rootRenderer).size = ResearchRoot.NORMAL_SIZE;
            }
            else
            {
               ResearchRoot(rootRenderer).size = ResearchRoot.SMALL_SIZE;
            }
            rootRenderer.validateNow();
            this.background.scaleX = this.background.scaleY = _loc1_;
            this.backgroundCollectible.scaleX = this.backgroundCollectible.scaleY = _loc1_;
            this.nationFlagContainer.scaleX = this.nationFlagContainer.scaleY = _loc1_;
            invalidateLayout();
         }
         super.draw();
         if(isInvalid(INV_POST_PROGRESSION))
         {
            this.updatePostProgressionEntryPoint();
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updatePostProgressionPosition();
         }
         if(this._postProgressionEntry && isInvalid(InvalidationType.LAYOUT))
         {
            this._postProgressionEntry.invalidateLayout();
         }
      }
      
      override protected function drawLines() : void
      {
         super.drawLines();
         ResearchGraphics(rGraphics).buildTopRenderersLines(this._topRenderers);
      }
      
      override protected function onDrawComplete() : void
      {
         this.updateBackground();
      }
      
      override protected function onDispose() : void
      {
         App.tutorialMgr.removeListenersFromCustomTutorialComponent(this);
         while(this._topRenderers.length > 0)
         {
            this.removeItemRenderer(this._topRenderers.pop());
         }
         this._rootRendererData = null;
         this._topRenderers = null;
         this._vehicleNodeClass = null;
         this.background = null;
         this.backgroundCollectible = null;
         this.nationFlagContainer.dispose();
         this.nationFlagContainer = null;
         this.view = null;
         this._classFactory = null;
         if(this._postProgressionEntry)
         {
            this._postProgressionEntry.removeEventListener(TechTreeEvent.GO_TO_POST_PROGRESSION,this.onGoToPostProgressionHandler);
            this._postProgressionEntry.removeEventListener(MouseEvent.ROLL_OVER,this.onPostProgressionRollOverHandler);
            this._postProgressionEntry.removeEventListener(MouseEvent.ROLL_OUT,this.onPostProgressionRollOutHandler);
            this._postProgressionEntry.dispose();
            this._postProgressionEntry = null;
         }
         this._postProgressionData = null;
         NodeData.setDisplayInfoClass(null);
         super.onDispose();
      }
      
      override protected function createItemRenderer(param1:uint) : IRenderer
      {
         var _loc2_:IRenderer = null;
         if(NodeEntityType.isVehicleType(param1))
         {
            _loc2_ = new this._vehicleNodeClass();
            this.setupVehicleRenderer(_loc2_);
         }
         else
         {
            _loc2_ = super.createItemRenderer(param1);
         }
         return _loc2_;
      }
      
      override protected function updateRootData() : Boolean
      {
         var _loc2_:String = null;
         var _loc1_:Boolean = super.updateRootData();
         if(_loc1_)
         {
            _loc2_ = _dataProvider.nation;
            ResearchRoot(rootRenderer).data = this._rootRendererData;
            this.nationFlagContainer.setNation(_loc2_);
         }
         return _loc1_;
      }
      
      override protected function setupItemRenderer(param1:IRenderer) : void
      {
         super.setupItemRenderer(param1);
         param1.addEventListener(TechTreeEvent.CLICK_2_UNLOCK,this.onRendererClick2UnlockHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_BUY,this.onRendererClick2BuyHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_OPEN,this.onRenderer2Click2OpenHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.ON_MODULE_HOVER,this.onRendererOnModuleHoverHandler,false,0,true);
      }
      
      override protected function setupVehicleRenderer(param1:IRenderer, param2:Boolean = false) : void
      {
         super.setupVehicleRenderer(param1);
         param1.addEventListener(TechTreeEvent.CLICK_2_UNLOCK,this.onRendererClick2UnlockHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_BUY,this.onRendererClick2BuyHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.GO_TO_VEHICLE_VIEW,this.onRendererGoToVehicleViewHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_VEHICLE_COMPARE,this.onRendererClickVehicleCompareHandler);
         param1.addEventListener(TechTreeEvent.RESTORE_VEHICLE,this.onRendererRestoreVehicleHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.GO_TO_BLUEPRINT_VIEW,this.onGoToBlueprintViewHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.CLICK_2_RENT,this.onRendererClick2RentHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.GO_TO_SHOP,this.onRendererGoToShopHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.GO_TO_EARLY_ACCESS_QUESTS_VIEW,this.onRendererGoToEarlyAccessQuestsViewHandler,false,0,true);
         param1.addEventListener(TechTreeEvent.GO_TO_EARLY_ACCESS_BUY_VIEW,this.onRendererGoToEarlyAccessBuyViewHandler,false,0,true);
         if(!param2)
         {
            param1.addEventListener(TechTreeEvent.CLICK_2_OPEN,this.onRendererClick2OpenHandler,false,0,true);
         }
         param1.addEventListener(TechTreeEvent.GO_TO_CHANGE_NATION_VIEW,this.onGoToChangeNationViewHandler,false,0,true);
      }
      
      override protected function onCircleReferenceDetected() : void
      {
         super.onCircleReferenceDetected();
         if(this.view != null && App.utils != null)
         {
            this.view.showSystemMessageS(ERROR,App.utils.locale.makeString(SYSTEM_MESSAGES.UNLOCKS_DRAWFAILED));
         }
      }
      
      override protected function drawRenderers() : Boolean
      {
         var _loc1_:Boolean = super.drawRenderers();
         if(_loc1_)
         {
            this.updateTopRenderers();
            App.tutorialMgr.dispatchEventForCustomComponent(this);
         }
         return _loc1_;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._topRenderers = new Vector.<IRenderer>();
         var _loc1_:IClassFactory = App.utils.classFactory;
         this.vehicleNodeClass = _loc1_.getClass(Linkages.NATION_TREE_NODE_SKINNED);
         itemNodeClass = _loc1_.getClass(Linkages.RESEARCH_ITEM_NODE);
         fakeNodeClass = _loc1_.getClass(Linkages.FAKE_ITEM_NODE);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.tutorialMgr.addListenersToCustomTutorialComponent(this);
         App.stageSizeMgr.register(this);
         this.nationFlagContainer.alpha = NATION_FLAG_ALPHA;
         rGraphics.xRatio = CORNER_X;
      }
      
      override protected function updateLayout() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         var _loc4_:IRenderer = null;
         super.updateLayout();
         var _loc1_:Number = (this._topRenderers.length - 1) * yRatio;
         var _loc5_:Number = rootRenderer.getY();
         var _loc6_:Number = rootRenderer.getInX() + topLevelOffset;
         var _loc7_:int = this._topRenderers.length;
         _loc2_ = 0;
         _loc3_ = _loc5_ - (_loc1_ >> 1);
         while(_loc2_ < _loc7_)
         {
            _loc4_ = this._topRenderers[_loc2_];
            _loc4_.x = _loc6_;
            _loc4_.y = _loc3_ - (_loc4_.getY() - _loc4_.y);
            _loc2_++;
            _loc3_ += yRatio;
         }
         if(rootRenderer.isPremium())
         {
            rGraphics.x = PREMIUM_ROOT_OUT_X - rootRenderer.getOutX();
         }
      }
      
      public function generatedUnstoppableEvents() : Boolean
      {
         return true;
      }
      
      public function getTutorialDescriptionName() : String
      {
         return name + SEPARATOR + Linkages.RESEARCH_ITEM_NODE;
      }
      
      public function needPreventInnerEvents() : Boolean
      {
         return true;
      }
      
      public function setFreeXP(param1:Number) : void
      {
         if(this.xpInfo != null)
         {
            this.xpInfo.freeXP = param1;
         }
      }
      
      public function setItemsField(param1:Array, param2:String) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:Array = null;
         var _loc6_:IRenderer = null;
         var _loc3_:uint = param1.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc3_)
         {
            _loc5_ = param1[_loc7_];
            _loc4_ = _dataProvider.getIndexByID(_loc5_[0]);
            if(_loc4_ > -1 && _dataProvider.length > _loc4_)
            {
               _dataProvider.setItemField(param2,_loc4_,_loc5_[1]);
               _loc6_ = this.getNodeByID(_loc5_[0]);
               _loc6_.invalidateNodeState();
            }
            else
            {
               _loc4_ = _dataProvider.getTopLevelIndexByID(_loc5_[0]);
               if(_loc4_ > -1 && _dataProvider.topLength > _loc4_)
               {
                  _dataProvider.setTopLevelField(param2,_loc4_,_loc5_[1]);
                  _loc6_ = this.getNodeByID(_loc5_[0]);
                  _loc6_.invalidateNodeState();
               }
            }
            _loc7_++;
         }
      }
      
      public function setNodesStates(param1:Number, param2:Array, param3:String = null, param4:Boolean = false) : void
      {
         var _loc6_:Array = null;
         var _loc7_:Boolean = false;
         var _loc8_:IRenderer = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc5_:uint = param2.length;
         var _loc11_:uint = 0;
         while(_loc11_ < _loc5_)
         {
            _loc6_ = param2[_loc11_];
            _loc9_ = _loc6_[0];
            _loc8_ = null;
            _loc7_ = false;
            _loc10_ = _dataProvider.getIndexByID(_loc9_);
            if(_loc10_ > -1 && _dataProvider.length > _loc10_)
            {
               if(param3 != null)
               {
                  _dataProvider.setItemField(param3,_loc10_,_loc6_[2]);
               }
               _loc7_ = _dataProvider.setState(_loc10_,param1,_loc6_[1]);
               _loc8_ = this.getNodeByID(_loc9_);
            }
            else
            {
               _loc10_ = _dataProvider.getTopLevelIndexByID(_loc9_);
               if(_loc10_ > -1 && _dataProvider.topLength > _loc10_)
               {
                  if(param3 != null)
                  {
                     _dataProvider.setTopLevelField(param3,_loc10_,_loc6_[2]);
                  }
                  _loc7_ = _dataProvider.setTopLevelState(_loc10_,param1,_loc6_[1]);
                  _loc8_ = this.getNodeByID(_loc9_);
               }
            }
            if((_loc7_ || param4) && _loc8_ != null)
            {
               _loc8_.invalidateNodeState();
            }
            _loc11_++;
         }
      }
      
      public function setPostProgressionData(param1:ResearchPostProgressionDataVO) : void
      {
         this._postProgressionData = param1;
         invalidate(INV_POST_PROGRESSION);
      }
      
      public function setRootData(param1:ResearchRootVO) : void
      {
         if(param1 == this._rootRendererData)
         {
            return;
         }
         this._rootRendererData = param1;
         invalidateData();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         if(_viewWidth == param1 && _viewHeight == param2)
         {
            return;
         }
         _viewWidth = param1;
         _viewHeight = param2;
         invalidateSize();
      }
      
      public function setVehicleTypeXP(param1:Array) : void
      {
         var _loc3_:Array = null;
         var _loc4_:IRenderer = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:uint = param1.length;
         var _loc7_:uint = 0;
         while(_loc7_ < _loc2_)
         {
            _loc3_ = param1[_loc7_];
            _loc5_ = _loc3_[0];
            _loc4_ = null;
            _loc6_ = _dataProvider.getIndexByID(_loc5_);
            if(_loc6_ > -1 && _dataProvider.length > _loc6_)
            {
               _dataProvider.setEarnedXP(_loc6_,_loc3_[1]);
               _loc4_ = this.getNodeByID(_loc5_);
            }
            else
            {
               _loc6_ = _dataProvider.getTopLevelIndexByID(_loc5_);
               if(_loc6_ > -1 && _dataProvider.topLength > _loc6_)
               {
                  _dataProvider.setTopLevelXP(_loc6_,_loc3_[1]);
                  _loc4_ = this.getNodeByID(_loc5_);
               }
            }
            if(_loc4_ != null)
            {
               _loc4_.invalidateNodeState();
            }
            _loc7_++;
         }
      }
      
      public function setXpInfoLinkage(param1:String) : void
      {
         ResearchRoot(rootRenderer).setXpBlockLinkage(param1,XP_INFO_NAME);
      }
      
      public function showPostProgressionUnlockAnimation() : void
      {
         this.updatePostProgressionEntryPoint();
         if(this._postProgressionEntry)
         {
            this._postProgressionEntry.showUnlockAnimation();
         }
      }
      
      public function updateWalletStatus() : void
      {
         if(this.xpInfo != null)
         {
            this.xpInfo.updateWalletStatus();
         }
      }
      
      private function updateBackground() : void
      {
         this.background.visible = !rootRenderer.isCollectible();
         this.backgroundCollectible.visible = rootRenderer.isCollectible();
      }
      
      private function updateTopRenderers() : void
      {
         var _loc2_:IRenderer = null;
         var _loc3_:Object = null;
         var _loc4_:NodeData = null;
         var _loc1_:uint = _dataProvider.topLength;
         var _loc5_:Boolean = false;
         while(this._topRenderers.length > _loc1_)
         {
            this.removeItemRenderer(this._topRenderers.pop());
         }
         var _loc6_:uint = 0;
         while(_loc6_ < _loc1_)
         {
            if(_loc6_ < this._topRenderers.length)
            {
               _loc5_ = false;
               _loc2_ = this._topRenderers[_loc6_];
               if(rGraphics != null)
               {
                  rGraphics.clearUpRenderer(_loc2_);
               }
            }
            else
            {
               _loc5_ = true;
               _loc2_ = this.createItemRenderer(NodeEntityType.TOP_VEHICLE);
            }
            if(_loc2_ != null)
            {
               _loc3_ = {
                  "row":_loc6_,
                  "column":-1
               };
               _loc4_ = _dataProvider.getTopLevelAt(_loc6_);
               positionById[_loc4_.id] = _loc3_;
               _loc2_.setup(_loc6_,_loc4_,NodeEntityType.TOP_VEHICLE,_loc3_);
               _loc2_.validateNow();
               if(_loc5_)
               {
                  this._topRenderers.push(_loc2_);
                  rGraphics.addChild(DisplayObject(_loc2_));
               }
            }
            _loc6_++;
         }
      }
      
      private function activateCoolDown() : void
      {
         this._requestInCoolDown = true;
         App.utils.scheduler.scheduleTask(this.deactivateCoolDown,COOLDOWN);
      }
      
      private function deactivateCoolDown() : void
      {
         this._requestInCoolDown = false;
      }
      
      private function updatePostProgressionEntryPoint() : void
      {
         var _loc1_:Boolean = this._postProgressionData && this._postProgressionData.state != POSTPROGRESSION_CONSTS.RESEARCH_STATE_HIDDEN;
         if(this._postProgressionEntry)
         {
            this._postProgressionEntry.visible = _loc1_;
         }
         else if(_loc1_)
         {
            this._postProgressionEntry = this._classFactory.getComponent(Linkages.RESEARCH_POST_PROGRESSION_ENTRY_POINT,EntryPoint);
            this.addChild(this._postProgressionEntry);
            this._postProgressionEntry.addEventListener(TechTreeEvent.GO_TO_POST_PROGRESSION,this.onGoToPostProgressionHandler);
            this._postProgressionEntry.addEventListener(MouseEvent.ROLL_OVER,this.onPostProgressionRollOverHandler);
            this._postProgressionEntry.addEventListener(MouseEvent.ROLL_OUT,this.onPostProgressionRollOutHandler);
         }
         if(this._postProgressionEntry && this._postProgressionData)
         {
            this._postProgressionEntry.setData(this._postProgressionData);
         }
      }
      
      private function updatePostProgressionPosition() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vector.<IRenderer> = null;
         var _loc6_:int = 0;
         var _loc7_:IRenderer = null;
         if(this._postProgressionEntry && renderers)
         {
            _loc1_ = int.MAX_VALUE;
            _loc2_ = int.MIN_VALUE;
            _loc3_ = int.MIN_VALUE;
            _loc4_ = int.MIN_VALUE;
            for each(_loc5_ in renderers)
            {
               _loc4_ = Math.max(_loc4_,_loc5_.length);
               for each(_loc7_ in _loc5_)
               {
                  if(_loc7_)
                  {
                     if(!(_loc7_ is FakeNode || _loc7_ == rootRenderer || _loc7_.getID() <= 0))
                     {
                        _loc1_ = Math.min(_loc1_,_loc7_.getInX());
                        _loc2_ = Math.max(_loc2_,_loc7_.getOutX());
                        _loc3_ = Math.max(_loc3_,_loc7_.getY());
                     }
                  }
               }
            }
            _loc6_ = _loc4_ == MAX_ROWS ? int(POST_PROGRESSION_OFFSET_MIN_Y) : int(POST_PROGRESSION_OFFSET_MAX_Y);
            this._postProgressionEntry.width = _loc2_ - _loc1_ + POST_PROGRESSION_MARGIN;
            this._postProgressionEntry.setPosition(rGraphics.x + _loc1_ - POST_PROGRESSION_PADDING,_loc3_ + _loc6_);
         }
      }
      
      private function selectRequiredModules(param1:Boolean) : void
      {
         var _loc3_:IRenderer = null;
         var _loc4_:uint = 0;
         var _loc2_:Vector.<uint> = this._postProgressionData.moduleIds;
         for each(_loc4_ in _loc2_)
         {
            _loc3_ = this.getNodeByID(_loc4_);
            if(_loc3_ is IBorderHighlighted)
            {
               IBorderHighlighted(_loc3_).isBorderHighlighted = param1;
            }
         }
      }
      
      public function set vehicleNodeClass(param1:Class) : void
      {
         if(this._vehicleNodeClass == param1)
         {
            return;
         }
         this._vehicleNodeClass = param1;
         invalidateData();
      }
      
      public function get tradeOffWidget() : TradeOffWidget
      {
         return rootRenderer != null ? ResearchRoot(rootRenderer).tradeOffWidget : null;
      }
      
      public function get xpInfo() : ExperienceBlock
      {
         return rootRenderer != null ? ResearchRoot(rootRenderer).experienceBlock : null;
      }
      
      private function getNodeDataByEvent(param1:TechTreeEvent) : NodeData
      {
         var _loc2_:NodeData = null;
         if(param1.entityType == NodeEntityType.TOP_VEHICLE)
         {
            _loc2_ = _dataProvider.getTopLevelAt(param1.index);
         }
         else
         {
            _loc2_ = _dataProvider.getItemAt(param1.index);
         }
         App.utils.asserter.assertNotNull(_loc2_,NODE_DATA_NOT_FOUND + param1);
         return _loc2_;
      }
      
      private function onRendererClick2OpenHandler(param1:TechTreeEvent) : void
      {
         dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
         if(this.view != null)
         {
            App.utils.asserter.assert(NodeEntityType.isVehicleType(param1.entityType),NODE_IS_NOT_VEHICLE);
            this.view.goToNextVehicleS(this.getNodeDataByEvent(param1).id);
         }
      }
      
      private function onRendererClick2UnlockHandler(param1:TechTreeEvent) : void
      {
         var _loc2_:NodeData = null;
         var _loc3_:UnlockProps = null;
         if(!this._requestInCoolDown && this.view != null)
         {
            _loc2_ = this.getNodeDataByEvent(param1);
            _loc3_ = _loc2_.unlockProps;
            App.utils.asserter.assertNotNull(_loc3_,UNLOCK_INFORMATION_NOT_DEFINED + param1.target);
            this.view.request4UnlockS(_loc2_.id,param1.entityType == NodeEntityType.TOP_VEHICLE);
            this.activateCoolDown();
         }
      }
      
      private function onRendererClick2BuyHandler(param1:TechTreeEvent) : void
      {
         if(!this._requestInCoolDown && this.view != null)
         {
            this.view.request4BuyS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
         }
      }
      
      private function onRendererClick2RentHandler(param1:TechTreeEvent) : void
      {
         if(!this._requestInCoolDown && this.view != null)
         {
            this.view.request4RentS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
         }
      }
      
      private function onRenderer2Click2OpenHandler(param1:TechTreeEvent) : void
      {
         if(!this._requestInCoolDown && this.view != null)
         {
            this.view.request4InfoS(this.getNodeDataByEvent(param1).id,rootRenderer.getID());
            this.activateCoolDown();
         }
      }
      
      private function onRendererOnModuleHoverHandler(param1:TechTreeEvent) : void
      {
         var _loc2_:int = 0;
         if(this.view != null)
         {
            _loc2_ = param1.index != -1 ? int(this.getNodeDataByEvent(param1).id) : int(-1);
            this.view.onModuleHoverS(_loc2_);
         }
      }
      
      private function onRendererGoToVehicleViewHandler(param1:TechTreeEvent) : void
      {
         if(!this._requestInCoolDown && this.view != null && param1.index > -1)
         {
            this.view.goToVehicleViewS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
         }
      }
      
      private function onRendererClickVehicleCompareHandler(param1:TechTreeEvent) : void
      {
         if(!this._requestInCoolDown && this.view != null && param1.index > -1)
         {
            this.view.compareVehicleS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
         }
      }
      
      private function onRendererRestoreVehicleHandler(param1:TechTreeEvent) : void
      {
         if(!this._requestInCoolDown && this.view != null)
         {
            this.view.request4RestoreS(this.getNodeDataByEvent(param1).id);
            this.activateCoolDown();
         }
      }
      
      private function onGoToBlueprintViewHandler(param1:TechTreeEvent) : void
      {
         this.view.goToBlueprintViewS(rootRenderer.getID());
      }
      
      private function onGoToChangeNationViewHandler(param1:TechTreeEvent) : void
      {
         this.view.goToNationChangeViewS(rootRenderer.getID());
      }
      
      private function onGoToPostProgressionHandler(param1:TechTreeEvent) : void
      {
         this.view.goToPostProgressionS(rootRenderer.getID());
      }
      
      private function onRendererGoToShopHandler(param1:TechTreeEvent) : void
      {
         if(this.view != null && param1.index > -1)
         {
            this.view.goToVehicleCollectionS(rootRenderer.container.getNation());
         }
      }
      
      private function onPostProgressionRollOverHandler(param1:MouseEvent) : void
      {
         this.selectRequiredModules(true);
      }
      
      private function onPostProgressionRollOutHandler(param1:MouseEvent) : void
      {
         this.selectRequiredModules(false);
      }
      
      private function onRendererGoToEarlyAccessQuestsViewHandler(param1:TechTreeEvent) : void
      {
         this.view.goToEarlyAccessQuestsViewS();
      }
      
      private function onRendererGoToEarlyAccessBuyViewHandler(param1:TechTreeEvent) : void
      {
         var _loc2_:int = dataProvider.getItemAt(param1.index).id;
         this.view.goToEarlyAccessBuyViewS(_loc2_);
      }
   }
}
