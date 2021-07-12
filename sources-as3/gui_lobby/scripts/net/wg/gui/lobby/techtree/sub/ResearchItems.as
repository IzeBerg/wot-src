package net.wg.gui.lobby.techtree.sub
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.controls.ExperienceBlock;
   import net.wg.gui.lobby.techtree.controls.NationFlagContainer;
   import net.wg.gui.lobby.techtree.data.ResearchRootVO;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
   import net.wg.gui.lobby.techtree.helpers.ResearchGraphics;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import net.wg.gui.lobby.techtree.interfaces.IResearchPage;
   import net.wg.gui.lobby.techtree.math.MatrixPosition;
   import net.wg.gui.lobby.techtree.nodes.ResearchRoot;
   import net.wg.gui.lobby.tradeIn.TradeOffWidget;
   import net.wg.infrastructure.events.FocusRequestEvent;
   import net.wg.infrastructure.interfaces.ITutorialCustomComponent;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.InvalidationType;
   
   public class ResearchItems extends ModulesTree implements ITutorialCustomComponent
   {
      
      private static const COOLDOWN:int = 250;
      
      private static const SEPARATOR:String = ":";
      
      private static const SMALL_SIZE_SCALE:Number = 0.5;
      
      private static const MEDIUM_SIZE_SCALE:Number = 0.8;
      
      private static const NODE_DATA_NOT_FOUND:String = "Data of node not found by event = ";
      
      private static const NODE_IS_NOT_VEHICLE:String = "Node is not vehicle";
      
      private static const UNLOCK_INFORMATION_NOT_DEFINED:String = "Unlock information is not defined for node = ";
      
      private static const MEDIUM_SIZE_BREAKPOINT:int = 1280;
      
      private static const LARGE_SIZE_BREAKPOINT:int = 1600;
      
      private static const NATION_FLAG_ALPHA:Number = 1.2;
      
      private static const XP_INFO_NAME:String = "xpInfo";
      
      private static const CORNER_X:int = 18;
      
      private static const PREMIUM_ROOT_OUT_X:int = 180;
       
      
      public var view:IResearchPage = null;
      
      public var background:Sprite = null;
      
      public var backgroundCollectible:Sprite = null;
      
      public var nationFlagContainer:NationFlagContainer = null;
      
      private var _requestInCoolDown:Boolean = false;
      
      private var _viewSize:Number = 1280;
      
      private var _topRenderers:Vector.<IRenderer> = null;
      
      private var _vehicleNodeClass:Class = null;
      
      private var _rootRendererData:ResearchRootVO = null;
      
      public function ResearchItems()
      {
         super();
      }
      
      override public function getNodeByID(param1:int) : IRenderer
      {
         var _loc2_:MatrixPosition = positionById[param1];
         var _loc3_:IRenderer = null;
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
         super.removeItemRenderer(param1);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         if(isInvalid(InvalidationType.SIZE))
         {
            rootRenderer.validateNow();
            _loc1_ = 1;
            if(this._viewSize < MEDIUM_SIZE_BREAKPOINT)
            {
               _loc1_ = SMALL_SIZE_SCALE;
            }
            else if(this._viewSize < LARGE_SIZE_BREAKPOINT)
            {
               _loc1_ = MEDIUM_SIZE_SCALE;
            }
            this.background.scaleX = this.background.scaleY = _loc1_;
            this.backgroundCollectible.scaleX = this.backgroundCollectible.scaleY = _loc1_;
            this.nationFlagContainer.scaleX = this.nationFlagContainer.scaleY = _loc1_;
            invalidateLayout();
         }
         super.draw();
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
      
      private function updateBackground() : void
      {
         this.background.visible = !rootRenderer.isCollectible();
         this.backgroundCollectible.visible = rootRenderer.isCollectible();
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
            this.view.showSystemMessageS("Error",App.utils.locale.makeString(SYSTEM_MESSAGES.UNLOCKS_DRAWFAILED));
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
         var _loc3_:int = param1.length;
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
      
      public function setNodesStates(param1:Number, param2:Array, param3:String = null) : void
      {
         var _loc5_:Array = null;
         var _loc6_:Boolean = false;
         var _loc7_:IRenderer = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:int = param2.length;
         var _loc10_:int = 0;
         while(_loc10_ < _loc4_)
         {
            _loc5_ = param2[_loc10_];
            _loc8_ = _loc5_[0];
            _loc7_ = null;
            _loc6_ = false;
            _loc9_ = _dataProvider.getIndexByID(_loc8_);
            if(_loc9_ > -1 && _dataProvider.length > _loc9_)
            {
               if(param3 != null)
               {
                  _dataProvider.setItemField(param3,_loc9_,_loc5_[2]);
               }
               _loc6_ = _dataProvider.setState(_loc9_,param1,_loc5_[1]);
               _loc7_ = this.getNodeByID(_loc8_);
            }
            else
            {
               _loc9_ = _dataProvider.getTopLevelIndexByID(_loc8_);
               if(_loc9_ > -1 && _dataProvider.topLength > _loc9_)
               {
                  if(param3 != null)
                  {
                     _dataProvider.setTopLevelField(param3,_loc9_,_loc5_[2]);
                  }
                  _loc6_ = _dataProvider.setTopLevelState(_loc9_,param1,_loc5_[1]);
                  _loc7_ = this.getNodeByID(_loc8_);
               }
            }
            if(_loc6_ && _loc7_ != null)
            {
               _loc7_.invalidateNodeState();
            }
            _loc10_++;
         }
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
      
      public function setVehicleTypeXP(param1:Array) : void
      {
         var _loc3_:Array = null;
         var _loc4_:IRenderer = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = param1.length;
         var _loc7_:int = 0;
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
      
      public function setViewWidth(param1:Number) : void
      {
         if(this._viewSize == param1)
         {
            return;
         }
         this._viewSize = param1;
         if(param1 >= LARGE_SIZE_BREAKPOINT)
         {
            ResearchRoot(rootRenderer).size = ResearchRoot.LARGE_SIZE;
         }
         else if(param1 >= MEDIUM_SIZE_BREAKPOINT)
         {
            ResearchRoot(rootRenderer).size = ResearchRoot.NORMAL_SIZE;
         }
         else
         {
            ResearchRoot(rootRenderer).size = ResearchRoot.SMALL_SIZE;
         }
         invalidateSize();
      }
      
      public function setXpInfoLinkage(param1:String) : void
      {
         ResearchRoot(rootRenderer).setXpBlockLinkage(param1,XP_INFO_NAME);
      }
      
      public function updateWalletStatus() : void
      {
         if(this.xpInfo != null)
         {
            this.xpInfo.updateWalletStatus();
         }
      }
      
      private function updateTopRenderers() : void
      {
         var _loc2_:IRenderer = null;
         var _loc3_:MatrixPosition = null;
         var _loc4_:NodeData = null;
         var _loc1_:int = _dataProvider.topLength;
         var _loc5_:Boolean = false;
         while(this._topRenderers.length > _loc1_)
         {
            this.removeItemRenderer(this._topRenderers.pop());
         }
         var _loc6_:int = 0;
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
               _loc3_ = new MatrixPosition(_loc6_,-1);
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
      
      private function onRendererGoToShopHandler(param1:TechTreeEvent) : void
      {
         if(this.view != null && param1.index > -1)
         {
            this.view.goToVehicleCollectionS(rootRenderer.container.getNation());
         }
      }
   }
}
