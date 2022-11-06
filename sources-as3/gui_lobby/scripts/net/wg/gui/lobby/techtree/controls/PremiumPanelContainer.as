package net.wg.gui.lobby.techtree.controls
{
   import net.wg.gui.lobby.techtree.helpers.TweenWrapper;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.motion.Tween;
   
   public class PremiumPanelContainer extends UIComponentEx
   {
      
      protected static const TWEEN_DURATION:int = 300;
      
      public static const MAX_COLUMN_TANK_COUNT:int = 4;
       
      
      protected var tweenWrapper:TweenWrapper = null;
      
      protected var tweens:Vector.<Tween>;
      
      protected var baseY:Number = 0;
      
      protected var contentWidth:int = 0;
      
      protected var contentHeight:int = 0;
      
      protected var isOpen:Boolean = false;
      
      public function PremiumPanelContainer()
      {
         this.tweens = new Vector.<Tween>();
         super();
         this.tweenWrapper = new TweenWrapper(this);
      }
      
      override protected function onDispose() : void
      {
         this.cleanTweens();
         this.tweens = null;
         this.tweenWrapper.dispose();
         this.tweenWrapper = null;
         super.onDispose();
      }
      
      public function hidePanel(param1:int) : void
      {
         this.isOpen = false;
         this.cleanTweens();
      }
      
      public function showPanel(param1:int) : void
      {
         this.isOpen = true;
         this.cleanTweens();
      }
      
      protected function cleanTweens() : void
      {
         var _loc1_:Tween = null;
         for each(_loc1_ in this.tweens)
         {
            _loc1_.paused = true;
            _loc1_.dispose();
         }
         this.tweens.splice(0,this.tweens.length);
      }
      
      public function get defaultY() : int
      {
         return this.baseY;
      }
      
      public function set defaultY(param1:int) : void
      {
         this.baseY = param1;
         this.tweenWrapper.y = this.baseY;
      }
      
      public function set panelWidth(param1:int) : void
      {
         this.contentWidth = param1;
         invalidateSize();
      }
      
      public function set panelHeight(param1:int) : void
      {
         this.contentHeight = param1;
         invalidateSize();
      }
      
      public function get isOpened() : Boolean
      {
         return this.isOpen;
      }
   }
}
