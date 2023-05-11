package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.gui.components.advanced.collapsingBar.ResizableButton;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.lobby.vehicleCustomization.controls.bottomPanel.CustomizationBottomPanelTabBar;
   import net.wg.gui.lobby.vehicleCustomization.controls.bottomPanel.CustomizationBottomPanelTabButton;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationTabNavigatorVO;
   import net.wg.gui.lobby.vehicleCustomization.events.CustomizationTabEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IFocusChainContainer;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.Button;
   
   public class CustomizationTabNavigator extends UIComponentEx implements IFocusChainContainer
   {
      
      private static const BUTTON_LINKAGE:String = "CustomizationBottomPanelTabButtonUI";
      
      private static const MIN_RESOLUTION:int = 900;
       
      
      public var overlay:MovieClip = null;
      
      public var tabBar:CustomizationBottomPanelTabBar = null;
      
      public var selector:MovieClip = null;
      
      public var firstHighlight:MovieClip = null;
      
      public var lastHighlight:MovieClip = null;
      
      private var _selectedId:int = -1;
      
      private var _isMinResolution:Boolean;
      
      public function CustomizationTabNavigator()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.tabBar.layout = new HorizontalGroupLayout(-3,false);
         this.tabBar.buttonLinkage = BUTTON_LINKAGE;
         this.tabBar.allowedKeyboard = false;
         this.tabBar.toggleResolutions(App.appHeight < MIN_RESOLUTION);
      }
      
      override protected function configUI() : void
      {
         var _loc1_:Sprite = null;
         super.configUI();
         this.firstHighlight.mouseEnabled = this.lastHighlight.mouseEnabled = false;
         this.firstHighlight.mouseChildren = this.lastHighlight.mouseChildren = false;
         _loc1_ = new Sprite();
         this.selector.hitArea = _loc1_;
         this.overlay.hitArea = _loc1_;
         addChild(_loc1_);
         this.tabBar.addEventListener(Event.CHANGE,this.onTabBarChangeHandler);
         this.tabBar.addEventListener(Event.RESIZE,this.onTabBarResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         this.tabBar.removeEventListener(Event.CHANGE,this.onTabBarChangeHandler);
         this.tabBar.removeEventListener(Event.RESIZE,this.onTabBarResizeHandler);
         this.tabBar.dispose();
         this.tabBar = null;
         this.firstHighlight = null;
         this.lastHighlight = null;
         this.selector = null;
         this.overlay = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.overlay.width = _width;
         }
      }
      
      public function getFocusChain() : Vector.<InteractiveObject>
      {
         var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
         _loc1_.push(this.tabBar);
         return _loc1_;
      }
      
      public function setData(param1:CustomizationTabNavigatorVO) : void
      {
         this.tabBar.setData(param1.tabsDP,param1.selectedTab);
      }
      
      public function setTabsPluses(param1:Array) : void
      {
         var _loc2_:ResizableButton = null;
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = CustomizationBottomPanelTabButton(this.tabBar.getButtonAt(_loc4_));
            CustomizationBottomPanelTabButton(_loc2_).showPlus(param1[_loc4_]);
            _loc4_++;
         }
      }
      
      public function switchState(param1:Boolean) : void
      {
         this.tabBar.visible = param1;
         this.firstHighlight.visible = param1;
         this.lastHighlight.visible = param1;
         this.selector.visible = param1;
         this.tabBar.focusable = param1;
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this.width = param1;
         var _loc3_:Boolean = param2 < MIN_RESOLUTION;
         var _loc4_:Boolean = this.tabBar.checkCollapsing();
         if(this._isMinResolution != _loc3_ || _loc4_ != this.tabBar.isBarCollapsed)
         {
            this.toggleResolutions(_loc3_);
            this.tabBar.collapseBar(_loc4_);
         }
         else
         {
            this.updateLayout();
         }
      }
      
      public function setNotificationCounters(param1:Array) : void
      {
         this.tabBar.setNotificationCounters(param1);
      }
      
      private function onTabBarChangeHandler(param1:Event) : void
      {
         var _loc2_:Button = this.tabBar.getButtonAt(this.tabBar.selectedIndex);
         if(!_loc2_)
         {
            return;
         }
         if(this._selectedId == _loc2_.data.id)
         {
            return;
         }
         this._selectedId = _loc2_.data.id;
         this.updateSelector(_loc2_);
         dispatchEvent(new CustomizationTabEvent(CustomizationTabEvent.TAB_CHANGED,this._selectedId,true));
      }
      
      private function updateSelector(param1:Button) : void
      {
         if(!param1)
         {
            return;
         }
         param1.validateNow();
         var _loc2_:Point = param1.parent.localToGlobal(new Point(param1.x,param1.y));
         _loc2_ = globalToLocal(_loc2_);
         this.firstHighlight.x = _loc2_.x;
         this.lastHighlight.x = _loc2_.x + param1.width;
         this.firstHighlight.y = this.lastHighlight.y = _loc2_.y;
         this.selector.x = _loc2_.x + (param1.width >> 1);
         this.selector.y = _loc2_.y + param1.height;
      }
      
      private function updateLayout() : void
      {
         this.lastHighlight.height = this.firstHighlight.height = this.tabBar.height;
         this.tabBar.x = _width - this.tabBar.width >> 1;
         this.updateSelector(this.tabBar.getButtonAt(this.tabBar.selectedIndex));
      }
      
      private function toggleResolutions(param1:Boolean) : void
      {
         this._isMinResolution = param1;
         this.tabBar.toggleResolutions(param1);
      }
      
      private function onTabBarResizeHandler(param1:Event) : void
      {
         this.updateLayout();
         dispatchEvent(new Event(Event.RESIZE));
      }
   }
}
