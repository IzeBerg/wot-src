package net.wg.gui.lobby.techtree
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.ui.Keyboard;
   import net.wg.data.Aliases;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.NODE_STATE_FLAGS;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.miniclient.TechTreeMiniClientComponent;
   import net.wg.gui.lobby.techtree.controls.BlueprintBackground;
   import net.wg.gui.lobby.techtree.controls.BlueprintBalance;
   import net.wg.gui.lobby.techtree.controls.BlueprintsModeSwitchButton;
   import net.wg.gui.lobby.techtree.controls.NationTreeVehicleCollectionBtn;
   import net.wg.gui.lobby.techtree.controls.NationsButtonBar;
   import net.wg.gui.lobby.techtree.controls.TechTreeTitle;
   import net.wg.gui.lobby.techtree.data.BlueprintBalanceVO;
   import net.wg.gui.lobby.techtree.data.state.NodeStateCollection;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.data.vo.TechTreeNationMenuItemVO;
   import net.wg.gui.lobby.techtree.interfaces.ITechTreePage;
   import net.wg.gui.lobby.techtree.sub.NationTree;
   import net.wg.infrastructure.base.meta.impl.TechTreeMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class TechTreePage extends TechTreeMeta implements ITechTreePage
   {
      
      private static const WARNING_VERTICAL_GAP:int = 5;
      
      private static const WARN_VISIBILITY_BORDER:int = 900;
      
      private static const EMPTY_STR:String = "";
      
      private static const NT_TREE_MIN_POSITION_Y:int = 34;
      
      private static const TT_PADDING_BOTTOM:int = 20;
      
      private static const NT_TREE_GRAPHICS_OFFSET_Y:int = 40;
      
      private static const NATION_BUTTON_BAR_WIDTH:int = 100;
      
      private static const NATION_BUTTON_BAR_Y_DEFAULT:int = 28;
      
      private static const BLUEPRINTS_SWITCH_SCALE_NORMAL:int = 1;
      
      private static const BLUEPRINTS_SWITCH_OFFSET_Y_NORMAL:int = 82;
      
      private static const NATION_BUTTON_BAR_OFFSET_Y_NORMAL:int = 160;
      
      private static const BLUEPRINTS_SWITCH_SCALE_DECREASED:Number = 0.7;
      
      private static const BLUEPRINTS_SWITCH_OFFSET_Y_DECREASED:int = 58;
      
      private static const NATION_BUTTON_BAR_OFFSET_Y_DECREASED:int = 120;
      
      private static const VEHICLE_COLLECTOR_BTN_X_OFFSET:int = 20;
      
      private static const VEHICLE_BTN_Y_OFFSET:int = 1;
       
      
      public var title:TechTreeTitle = null;
      
      public var nationTree:NationTree = null;
      
      public var nationsBar:NationsButtonBar = null;
      
      public var scrollBar:ScrollBar = null;
      
      public var vScrollBar:ScrollBar = null;
      
      public var shadowBg:Sprite = null;
      
      public var background:BlueprintBackground = null;
      
      public var footerBg:Sprite = null;
      
      public var blueprintsSwitchButton:BlueprintsModeSwitchButton = null;
      
      public var blueprintBalance:BlueprintBalance = null;
      
      public var vehicleCollectionBtn:NationTreeVehicleCollectionBtn = null;
      
      private var _miniClient:TechTreeMiniClientComponent = null;
      
      private var _vehicleCollectorEnabled:Boolean = true;
      
      public function TechTreePage()
      {
         super();
         _deferredDispose = true;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         setViewSize(param1,param2);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         if(!initialized)
         {
            validateNow();
         }
         requestNationTreeDataS();
      }
      
      override protected function onBeforeDispose() : void
      {
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape);
         this.nationsBar.removeEventListener(IndexEvent.INDEX_CHANGE,this.onNationsBarIndexChangeHandler);
         this.nationsBar.removeEventListener(MouseEvent.MOUSE_OUT,this.onNationsBarMouseOutHandler);
         this.nationsBar.removeEventListener(MouseEvent.MOUSE_OVER,this.onNationsBarMouseOverHandler);
         NodeStateCollection.instance.dispose();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this._miniClient = null;
         this.nationsBar.removeEventListener(Event.COMPLETE,this.onNationsBarCompleteHandler);
         this.nationsBar.dispose();
         this.nationsBar = null;
         this.nationTree.removeEventListener(TechTreeEvent.GO_TO_PREMIUM_SHOP,this.onNationTreeGoToPremiumShopHandler);
         this.nationTree.dispose();
         this.nationTree = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.vScrollBar.dispose();
         this.vScrollBar = null;
         this.title.dispose();
         this.title = null;
         this.shadowBg = null;
         this.footerBg = null;
         this.background.dispose();
         this.background = null;
         this.blueprintsSwitchButton.removeEventListener(Event.SELECT,this.onBlueprintsSwitchCheckboxSelectHandler);
         this.blueprintsSwitchButton.dispose();
         this.blueprintsSwitchButton = null;
         this.blueprintBalance.dispose();
         this.blueprintBalance = null;
         this.vehicleCollectionBtn.removeEventListener(MouseEvent.CLICK,this.onVehicleCollectionBtnClickHandler);
         this.vehicleCollectionBtn.dispose();
         this.vehicleCollectionBtn = null;
         removeEventListener(TechTreeEvent.GO_TO_BLUEPRINT_VIEW,this.goToBlueprintScreen);
         removeEventListener(TechTreeEvent.ON_START_HINT_ANIMATION,this.onOnStartHintAnimationHandler);
         removeEventListener(TechTreeEvent.ON_END_HINT_ANIMATION,this.onOnEndHintAnimationHandler);
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.title.mouseEnabled = this.title.mouseChildren = false;
         this.shadowBg.mouseEnabled = false;
         this.nationsBar.addEventListener(IndexEvent.INDEX_CHANGE,this.onNationsBarIndexChangeHandler,false,0,true);
         this.nationsBar.addEventListener(Event.COMPLETE,this.onNationsBarCompleteHandler);
         this.nationsBar.addEventListener(MouseEvent.MOUSE_OUT,this.onNationsBarMouseOutHandler);
         this.nationsBar.addEventListener(MouseEvent.MOUSE_OVER,this.onNationsBarMouseOverHandler);
         this.nationsBar.focused = 1;
         this.nationsBar.width = NATION_BUTTON_BAR_WIDTH;
         this.nationsBar.tabVAlign = NationsButtonBar.TOP_ALIGN;
         this.nationTree.view = this;
         this.nationTree.addEventListener(TechTreeEvent.GO_TO_PREMIUM_SHOP,this.onNationTreeGoToPremiumShopHandler);
         this.blueprintsSwitchButton.addEventListener(Event.SELECT,this.onBlueprintsSwitchCheckboxSelectHandler);
         this.blueprintsSwitchButton.tooltip = TOOLTIPS.TECHTREEPAGE_BLUEPRINTSSWITCHTOOLTIP;
         this.vehicleCollectionBtn.addEventListener(MouseEvent.CLICK,this.onVehicleCollectionBtnClickHandler);
         addEventListener(TechTreeEvent.GO_TO_BLUEPRINT_VIEW,this.goToBlueprintScreen);
         addEventListener(TechTreeEvent.ON_START_HINT_ANIMATION,this.onOnStartHintAnimationHandler);
         addEventListener(TechTreeEvent.ON_END_HINT_ANIMATION,this.onOnEndHintAnimationHandler);
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.handleEscape,true);
         this.nationTree.invalidatePremiumPanelLabels(getPremiumPanelLabelsS());
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayouts();
         }
      }
      
      override protected function onInitModalFocus(param1:InteractiveObject) : void
      {
         super.onInitModalFocus(param1);
         setFocus(!!this.nationsBar.visible ? this.nationsBar : this.nationTree);
      }
      
      override protected function setAvailableNations(param1:DataProvider) : void
      {
         this.nationsBar.dataProvider = param1;
      }
      
      override protected function setBlueprintBalance(param1:BlueprintBalanceVO) : void
      {
         this.blueprintBalance.setData(param1);
      }
      
      override protected function setInventoryItems(param1:Array) : void
      {
         this.nationTree.setNodesStates(NODE_STATE_FLAGS.IN_INVENTORY,param1);
      }
      
      override protected function setNext2Unlock(param1:Array) : void
      {
         this.nationTree.setNodesStates(NODE_STATE_FLAGS.NEXT_2_UNLOCK,param1,NodeData.UNLOCK_PROPS_FIELD);
      }
      
      override protected function setNodeVehCompareData(param1:Array) : void
      {
         this.nationTree.setItemsField(param1,NodeData.VEH_COMPARE_TREE_NODE_DATA);
      }
      
      override protected function setNodesStates(param1:Number, param2:Array) : void
      {
         this.nationTree.setNodesStates(param1,param2);
      }
      
      override protected function setUnlockProps(param1:Array) : void
      {
         this.nationTree.setItemsField(param1,NodeData.UNLOCK_PROPS_FIELD);
      }
      
      override protected function setVehicleTypeXP(param1:Array) : void
      {
         this.nationTree.setVehicleTypeXP(param1);
      }
      
      public function as_closePremiumPanel() : void
      {
         this.nationTree.closePremiumPanel(true);
      }
      
      public function as_hideNationsBar(param1:Boolean) : void
      {
         this.nationsBar.enabled = this.nationsBar.visible = !param1;
      }
      
      public function as_refreshNationTreeData(param1:String) : void
      {
         var _loc2_:Object = getNationTreeDataS(param1);
         this.nationTree.invalidateNodesData(param1,_loc2_);
      }
      
      public function as_setBlueprintMode(param1:Boolean) : void
      {
         this.switchBlueprintMode(param1);
      }
      
      public function as_setBlueprintsSwitchButtonState(param1:Boolean, param2:Boolean, param3:String, param4:Boolean) : void
      {
         this.blueprintsSwitchButton.enabled = param1;
         this.blueprintsSwitchButton.selected = param2;
         this.blueprintsSwitchButton.tooltip = param3;
         this.blueprintsSwitchButton.visible = param4;
      }
      
      public function as_setSelectedNation(param1:String) : void
      {
         var _loc3_:TechTreeNationMenuItemVO = null;
         var _loc2_:IDataProvider = this.nationsBar.dataProvider;
         var _loc4_:uint = _loc2_.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = TechTreeNationMenuItemVO(_loc2_[_loc5_]);
            if(_loc3_.label == param1)
            {
               this.nationsBar.selectedIndex = _loc5_;
               break;
            }
            _loc5_++;
         }
      }
      
      public function as_setVehicleCollectorState(param1:Boolean) : void
      {
         if(this._vehicleCollectorEnabled != param1)
         {
            this._vehicleCollectorEnabled = param1;
            this.updateVehicleCollectionBtnVisibility();
         }
      }
      
      public function as_showMiniClientInfo(param1:String, param2:String) : void
      {
         this._miniClient = TechTreeMiniClientComponent(App.utils.classFactory.getComponent(Linkages.TECH_TREE_MINI_CLIENT_COMPONENT,TechTreeMiniClientComponent));
         this._miniClient.update(param1,param2);
         addChild(this._miniClient);
         registerFlashComponentS(this._miniClient,Aliases.MINI_CLIENT_LINKED);
         this.updateMiniClientLayouts();
      }
      
      public function getScrollBar() : ScrollBar
      {
         return this.scrollBar;
      }
      
      public function getVScrollBar() : ScrollBar
      {
         return this.vScrollBar;
      }
      
      protected function updateLayouts() : void
      {
         this.title.updateSize(_width,_height);
         this.nationTree.levels.y = this.title.y + this.title.height >> 0;
         this.nationTree.setSize(Math.round(_width - this.nationTree.x),Math.round(_height));
         this.footerBg.width = _width;
         this.shadowBg.height = this.footerBg.y = _height;
         this.background.setSize(_width,_height);
         this.blueprintBalance.x = _width;
         if(this._miniClient)
         {
            this.updateMiniClientLayouts();
         }
         var _loc1_:int = NATION_BUTTON_BAR_Y_DEFAULT;
         if(this.blueprintsSwitchButton && this.blueprintsSwitchButton.visible)
         {
            if(stage.stageHeight < StageSizeBoundaries.HEIGHT_900)
            {
               this.blueprintsSwitchButton.scaleX = this.blueprintsSwitchButton.scaleY = BLUEPRINTS_SWITCH_SCALE_DECREASED;
               this.blueprintsSwitchButton.y = BLUEPRINTS_SWITCH_OFFSET_Y_DECREASED;
               _loc1_ = NATION_BUTTON_BAR_OFFSET_Y_DECREASED;
            }
            else
            {
               this.blueprintsSwitchButton.scaleX = this.blueprintsSwitchButton.scaleY = BLUEPRINTS_SWITCH_SCALE_NORMAL;
               this.blueprintsSwitchButton.y = BLUEPRINTS_SWITCH_OFFSET_Y_NORMAL;
               _loc1_ = NATION_BUTTON_BAR_OFFSET_Y_NORMAL;
            }
         }
         var _loc2_:int = Math.max(_height - NationTree.CONTAINER_HEIGHT >> 1,NT_TREE_MIN_POSITION_Y) + (NationTree.CONTAINER_HEIGHT + NT_TREE_GRAPHICS_OFFSET_Y >> 1);
         var _loc3_:int = this.nationsBar.measureOriginalContentHeight() >> 1;
         _loc3_ = Math.min(_loc2_ - _loc1_,_height - TT_PADDING_BOTTOM - _loc2_,_loc3_);
         this.nationsBar.height = _loc3_ << 1;
         this.nationsBar.y = _loc2_ - _loc3_;
         this.blueprintsSwitchButton.x = this.nationsBar.x + 0.5 * this.nationsBar.width;
         this.updateVehicleCollectorBtnLayout();
      }
      
      private function updateVehicleCollectorBtnLayout() : void
      {
         this.vehicleCollectionBtn.isSmallLayout = stage.stageHeight < StageSizeBoundaries.HEIGHT_900;
         this.vehicleCollectionBtn.x = this.title.x + (this.title.width + this.title.titleWidth >> 1) + VEHICLE_COLLECTOR_BTN_X_OFFSET >> 0;
         this.vehicleCollectionBtn.y = this.title.y + (this.title.height - this.vehicleCollectionBtn.currentHeight >> 1) + VEHICLE_BTN_Y_OFFSET >> 0;
      }
      
      private function updateMiniClientLayouts() : void
      {
         this._miniClient.visible = _height > WARN_VISIBILITY_BORDER;
         this._miniClient.y = this.title.y + this.title.height + WARNING_VERTICAL_GAP >> 0;
         this._miniClient.x = _width - this._miniClient.width >> 1;
      }
      
      private function updateTitle(param1:String) : void
      {
         var _loc2_:String = !!this.nationTree.blueprintModeOn ? MENU.nation_tree_blueprint_title(param1) : MENU.nation_tree_title(param1);
         this.title.updateTitle = Boolean(_loc2_) ? _loc2_ : EMPTY_STR;
         this.updateVehicleCollectorBtnLayout();
      }
      
      private function switchBlueprintMode(param1:Boolean) : void
      {
         this.blueprintsSwitchButton.selected = param1;
         this.nationTree.blueprintModeOn = param1;
         this.blueprintBalance.enabled = param1;
         this.background.enabled = param1;
         this.updateTitle(TechTreeNationMenuItemVO(this.nationsBar.selectedItem).label);
         this.updateVehicleCollectionBtnVisibility();
      }
      
      private function updateVehicleCollectionBtnVisibility() : void
      {
         var _loc1_:Boolean = this.nationTree.blueprintModeOn;
         this.vehicleCollectionBtn.visible = this._vehicleCollectorEnabled && !_loc1_;
      }
      
      private function onOnEndHintAnimationHandler(param1:TechTreeEvent) : void
      {
         onPlayHintAnimationS(false);
      }
      
      private function handleEscape(param1:InputEvent) : void
      {
         onCloseTechTreeS();
      }
      
      private function onNationsBarIndexChangeHandler(param1:IndexEvent) : void
      {
         var _loc2_:String = TechTreeNationMenuItemVO(param1.data).label;
         var _loc3_:Object = getNationTreeDataS(_loc2_);
         this.vehicleCollectionBtn.nation = _loc2_;
         this.updateTitle(_loc2_);
         this.nationTree.invalidateNodesData(_loc2_,_loc3_);
         this.nationTree.closePremiumPanel(true);
         App.contextMenuMgr.hide();
      }
      
      private function onNationsBarMouseOutHandler(param1:MouseEvent) : void
      {
         this.nationTree.closePremiumPanel();
      }
      
      private function onNationsBarMouseOverHandler(param1:MouseEvent) : void
      {
         this.nationTree.hideTreeNodeSelector();
      }
      
      private function onBlueprintsSwitchCheckboxSelectHandler(param1:Event) : void
      {
         this.switchBlueprintMode(this.blueprintsSwitchButton.selected);
         onBlueprintModeSwitchS(this.blueprintsSwitchButton.selected);
      }
      
      private function onNationsBarCompleteHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function goToBlueprintScreen(param1:TechTreeEvent) : void
      {
         goToBlueprintViewS(this.nationTree.dataProvider.getItemAt(param1.index).id);
      }
      
      private function onVehicleCollectionBtnClickHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            goToVehicleCollectionS(this.nationTree.getNation());
         }
      }
      
      private function onNationTreeGoToPremiumShopHandler(param1:TechTreeEvent) : void
      {
         onGoToPremiumShopS(this.nationTree.getNation(),param1.level);
      }
      
      private function onOnStartHintAnimationHandler(param1:TechTreeEvent) : void
      {
         onPlayHintAnimationS(true);
      }
   }
}
