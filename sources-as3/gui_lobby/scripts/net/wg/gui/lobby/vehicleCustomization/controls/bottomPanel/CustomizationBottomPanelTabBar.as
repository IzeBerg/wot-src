package net.wg.gui.lobby.vehicleCustomization.controls.bottomPanel
{
   import flash.geom.Point;
   import net.wg.gui.components.advanced.collapsingBar.CollapsingBar;
   import net.wg.gui.components.advanced.collapsingBar.ResizableButton;
   import net.wg.gui.components.advanced.collapsingBar.data.CollapsingBarButtonVO;
   import net.wg.gui.components.advanced.collapsingBar.interfaces.ICollapseChecker;
   import net.wg.gui.components.containers.GroupLayout;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationTabButtonVO;
   import scaleform.clik.data.DataProvider;
   
   public class CustomizationBottomPanelTabBar extends CollapsingBar implements ICollapseChecker
   {
      
      private static const MIN_WIDTH:int = 60;
      
      private static const BUTTON_HEIGHT:int = 42;
      
      private static const PADDING:int = 20;
      
      private static const ICON_SIZE:int = 20;
      
      private static const OFFSET_FROM_ICON:int = 10;
      
      private static const OVERLAP_SCALE:Number = 0.5;
      
      private static const RESOLUTION_OFFSET:int = -4;
       
      
      private var _barExpandedWith:int = 0;
      
      public function CustomizationBottomPanelTabBar()
      {
         super();
      }
      
      override protected function calculateExpandedSize(param1:ResizableButton) : Point
      {
         var _loc2_:Point = super.calculateExpandedSize(param1);
         this._barExpandedWith += _loc2_.x + GroupLayout(layout).gap;
         return _loc2_;
      }
      
      override protected function removeAllButtons() : void
      {
         super.removeAllButtons();
         this._barExpandedWith = 0;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         setCollapsingButtonSize(MIN_WIDTH,BUTTON_HEIGHT);
         setAutoCollapsed(true,this);
      }
      
      override protected function applyDataToButton(param1:ResizableButton, param2:CollapsingBarButtonVO) : void
      {
         super.applyDataToButton(param1,param2);
         param1.padding = PADDING;
         var _loc3_:CustomizationBottomPanelTabButton = CustomizationBottomPanelTabButton(param1);
         var _loc4_:CustomizationTabButtonVO = CustomizationTabButtonVO(param2);
         _loc3_.iconSource = _loc4_.icon;
         _loc3_.offsetFromIcon = OFFSET_FROM_ICON;
         _loc3_.setIconSize(ICON_SIZE,ICON_SIZE);
      }
      
      override protected function createTabs(param1:DataProvider) : void
      {
         this._barExpandedWith = 0;
         super.createTabs(param1);
         if(buttonGroup.length > 0)
         {
            CustomizationBottomPanelTabButton(buttonGroup.getButtonAt(buttonGroup.length - 1)).last = true;
         }
      }
      
      public function checkCollapsing() : Boolean
      {
         return this._barExpandedWith / App.appWidth > OVERLAP_SCALE;
      }
      
      public function toggleResolutions(param1:Boolean) : void
      {
         buttonGroup.sizeOffset.y = int(param1) * RESOLUTION_OFFSET;
      }
      
      public function setNotificationCounters(param1:Array) : void
      {
         var _loc3_:CustomizationBottomPanelTabButton = null;
         var _loc2_:int = buttonGroup.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = CustomizationBottomPanelTabButton(buttonGroup.getButtonAt(_loc4_));
            _loc3_.setCounter(param1[_loc4_]);
            _loc4_++;
         }
      }
   }
}
