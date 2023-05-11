package net.wg.gui.lobby.window
{
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.advanced.BadgeSizes;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.controls.ScrollPane;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.gui.components.windows.Window;
   import net.wg.gui.components.windows.WindowEvent;
   import net.wg.infrastructure.base.meta.impl.BattlePassBadgesDemoWindowMeta;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import net.wg.infrastructure.interfaces.IWindow;
   import scaleform.clik.controls.ScrollBar;
   import scaleform.clik.utils.Padding;
   
   public class BattlePassBadgesDemoWindow extends BattlePassBadgesDemoWindowMeta
   {
      
      private static const SIZES:Dictionary = new Dictionary();
      
      private static const SIZES_STR:Array = [BadgeSizes.X24,BadgeSizes.X48,BadgeSizes.X80,BadgeSizes.X220];
      
      private static const SCROLL_WIDTH:int = 13;
      
      private static const OFFSET:int = 50;
      
      private static const WINDOW_OFFSET:int = 88;
      
      private static const TARGET_OFFSET:int = 200;
      
      private static const PADDING:Padding = new Padding(38,13,16,16);
      
      {
         SIZES[BadgeSizes.X24] = 24;
         SIZES[BadgeSizes.X48] = 48;
         SIZES[BadgeSizes.X80] = 80;
         SIZES[BadgeSizes.X220] = 220;
      }
      
      public var scroll:ScrollPane;
      
      public var skinsScrollBar:ScrollBar;
      
      private var _badges:Vector.<BadgeComponent>;
      
      public function BattlePassBadgesDemoWindow()
      {
         this._badges = new Vector.<BadgeComponent>();
         super();
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         if(param1)
         {
            param1.useBottomBtns = true;
            param1.contentPadding = PADDING;
            param1.title = "badges";
            param1.setWindowContent(this);
            param1.invalidate(WindowViewInvalidationType.POSITION_INVALID);
            this.scroll.setSize(param1.width,param1.height);
            this.skinsScrollBar.visible = true;
            this.skinsScrollBar.setSize(13,param1.height);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         updateStage(App.appWidth,App.appHeight);
         window.addEventListener(WindowEvent.SCALE_Y_CHANGED,this.onWindowScaleYChangedHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:BadgeComponent = null;
         super.draw();
         if(geometry && window && isInvalid(WindowViewInvalidationType.POSITION_INVALID))
         {
            window.width = App.appWidth - OFFSET;
            window.height = App.appHeight - OFFSET;
            window.x = OFFSET;
            window.y = 0;
            this.skinsScrollBar.visible = true;
            _loc1_ = window.width - OFFSET;
            _loc2_ = window.height - WINDOW_OFFSET;
            this.scroll.setSize(_loc1_,_loc2_);
            this.skinsScrollBar.setSize(SCROLL_WIDTH,_loc2_);
            this.skinsScrollBar.x = _loc1_;
            _loc3_ = SIZES_STR.length;
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc6_ = 0;
               while(_loc6_ <= 100)
               {
                  _loc7_ = SIZES[SIZES_STR[_loc5_]] + 1;
                  _loc8_ = this._badges[_loc6_ + 101 * _loc5_];
                  _loc8_.x = _loc6_ * _loc7_ % (_loc1_ - TARGET_OFFSET);
                  _loc8_.y = Math.floor(_loc6_ * _loc7_ / (_loc1_ - TARGET_OFFSET)) * _loc7_ + _loc4_;
                  _loc6_++;
               }
               _loc4_ = _loc8_.y + _loc8_.height;
               _loc5_++;
            }
         }
      }
      
      override protected function onPopulate() : void
      {
         var _loc3_:int = 0;
         var _loc4_:BadgeVisualVO = null;
         var _loc5_:BadgeComponent = null;
         var _loc6_:MovieClip = null;
         super.onPopulate();
         var _loc1_:int = SIZES_STR.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = 0;
            while(_loc3_ <= 100)
            {
               _loc4_ = new BadgeVisualVO();
               _loc4_.content = _loc3_.toString();
               _loc4_.isDynamic = true;
               _loc4_.sizeContent = SIZES_STR[_loc2_];
               _loc4_.icon = "../maps/icons/library/badges/" + SIZES_STR[_loc2_] + "/badge_90.png";
               _loc5_ = App.utils.classFactory.getComponent(Linkages.BADGE_COMPONENT,BadgeComponent);
               _loc5_.setData(_loc4_);
               this._badges.push(_loc5_);
               _loc6_ = this.scroll.target as MovieClip;
               _loc6_.addChild(_loc5_);
               _loc4_.dispose();
               _loc3_++;
            }
            _loc2_++;
         }
         window.invalidate(Window.INVALID_SRC_VIEW);
         window.invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }
      
      override protected function onDispose() : void
      {
         var _loc3_:int = 0;
         var _loc4_:BadgeComponent = null;
         var _loc1_:int = SIZES_STR.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = 0;
            while(_loc3_ < 100)
            {
               _loc4_ = this._badges.pop();
               removeChild(_loc4_);
               _loc4_.dispose();
               _loc3_++;
            }
            _loc2_++;
         }
         this._badges = null;
         super.onDispose();
      }
      
      private function onWindowScaleYChangedHandler(param1:WindowEvent) : void
      {
         invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }
   }
}
