package net.wg.gui.lobby.questsWindow.components
{
   import fl.transitions.easing.Strong;
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.events.ResizableBlockEvent;
   import net.wg.gui.lobby.questsWindow.data.BaseResizableContentVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.motion.Tween;
   
   public class AnimResizableContent extends AbstractResizableContent
   {
      
      private static const ANIMATION_DURATION:int = 500;
       
      
      protected var data:BaseResizableContentVO = null;
      
      public var header:BaseResizableContentHeader;
      
      public var contentMask:Sprite;
      
      public var resizableContainer:MovableBlocksContainer;
      
      private var tweens:Vector.<Tween>;
      
      private var fadeTweens:Vector.<Tween>;
      
      private var contentHeight:Number;
      
      private var _sortingFunction:Function = null;
      
      protected var headerYShift:Number = -3;
      
      private var headerHeight:Number;
      
      public function AnimResizableContent()
      {
         this.tweens = new Vector.<Tween>();
         this.fadeTweens = new Vector.<Tween>();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.resizableContainer.verticalPadding = 3;
         this.headerHeight = this.header.height + this.headerYShift | 0;
         this.resizableContainer.sortingFunction = this._sortingFunction;
         this.header.addEventListener(Event.SELECT,this.startAnimation);
         this.resizableContainer.addEventListener(ResizableBlockEvent.READY_FOR_ANIMATION,this.containerAnimationHandler);
         this.resizableContainer.addEventListener(Event.RESIZE,this.resizableContainerResizeHandler);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Tween = null;
         var _loc2_:Tween = null;
         this.resizableContainer.removeEventListener(ResizableBlockEvent.READY_FOR_ANIMATION,this.containerAnimationHandler);
         this.resizableContainer.removeEventListener(Event.RESIZE,this.resizableContainerResizeHandler);
         this.header.removeEventListener(Event.SELECT,this.startAnimation);
         this.contentMask = null;
         this.header.dispose();
         this.header = null;
         this.resizableContainer.dispose();
         this.resizableContainer = null;
         this._sortingFunction = null;
         if(this.data)
         {
            this.data = null;
         }
         for each(_loc1_ in this.tweens)
         {
            _loc1_.onComplete = null;
            _loc1_.onChange = null;
            _loc1_.paused = true;
            _loc1_ = null;
         }
         this.tweens.splice(0,this.tweens.length);
         this.tweens = null;
         for each(_loc2_ in this.fadeTweens)
         {
            _loc2_.onComplete = null;
            _loc2_.onChange = null;
            _loc2_.paused = true;
            _loc2_ = null;
         }
         this.fadeTweens.splice(0,this.fadeTweens.length);
         this.fadeTweens = null;
         super.onDispose();
      }
      
      private function startAnimation(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(isReadyForLayout)
         {
            _loc2_ = !!this.header.selected ? Number(this.contentHeight + this.headerHeight) : Number(this.headerHeight);
            _loc3_ = _loc2_ - this.contentMask.height;
            dispatchEvent(new ResizableBlockEvent(ResizableBlockEvent.READY_FOR_ANIMATION,false,_loc3_));
            this.playResizeAnimation(_loc2_,ANIMATION_DURATION,this.onEndAnimation);
            _loc4_ = !!this.header.selected ? Number(1) : Number(0);
            this.playFadeAnimation(_loc4_,ANIMATION_DURATION);
         }
      }
      
      private function onEndAnimation() : void
      {
         this.layoutComponents();
         dispatchEvent(new ResizableBlockEvent(ResizableBlockEvent.CONTETNT_WAS_CHANGED));
      }
      
      private function playResizeAnimation(param1:Number, param2:Number, param3:Function = null) : void
      {
         var _loc4_:Tween = null;
         var _loc5_:Tween = null;
         for each(_loc4_ in this.tweens)
         {
            _loc4_.onComplete = null;
            _loc4_.paused = true;
            _loc4_ = null;
         }
         this.tweens = Vector.<Tween>([new Tween(param2,this.contentMask,{"height":param1},{
            "paused":false,
            "ease":Strong.easeInOut,
            "onComplete":param3
         })]);
         for each(_loc5_ in this.tweens)
         {
            _loc5_.fastTransform = false;
         }
      }
      
      private function playFadeAnimation(param1:Number, param2:Number, param3:Function = null) : void
      {
         var _loc4_:Tween = null;
         var _loc5_:Tween = null;
         for each(_loc4_ in this.fadeTweens)
         {
            _loc4_.onComplete = null;
            _loc4_.paused = true;
            _loc4_ = null;
         }
         this.fadeTweens = Vector.<Tween>([new Tween(param2,this.resizableContainer,{"alpha":param1},{
            "paused":false,
            "ease":Strong.easeInOut,
            "onComplete":param3
         })]);
         for each(_loc5_ in this.fadeTweens)
         {
            _loc5_.fastTransform = false;
         }
      }
      
      override public function setData(param1:Object) : void
      {
         this.data = this.castData(param1);
         this.resizableContainer.isReadyForLayout = false;
         invalidateData();
      }
      
      protected function castData(param1:Object) : BaseResizableContentVO
      {
         throw new AbstractException("Method must be overridden!");
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this.data)
            {
               this.header.setData(this.data);
               this.header.validateNow();
               this.resizableContainer.setData(this.data.containerElements);
               this.resizableContainer.validateNow();
            }
            else
            {
               this.resizableContainer.cleanContainer();
            }
            this.layoutComponents();
         }
      }
      
      private function layoutComponents() : void
      {
         this.resizableContainer.y = this.headerHeight;
         this.contentHeight = this.resizableContainer.height;
         this.contentMask.height = !!this.header.selected ? Number(this.contentHeight + this.headerHeight) : Number(this.headerHeight);
         var _loc1_:Number = this.headerHeight + this.contentHeight;
         setSize(this.width,!!this.header.selected ? Number(_loc1_) : Number(this.headerHeight));
         isReadyForLayout = true;
      }
      
      private function resizableContainerResizeHandler(param1:Event) : void
      {
         this.checkInitedComponents();
      }
      
      private function checkInitedComponents() : void
      {
         var _loc1_:Boolean = this.resizableContainer.isReadyForLayout;
         if(_loc1_)
         {
            this.layoutComponents();
            dispatchEvent(new ResizableBlockEvent(ResizableBlockEvent.CONTETNT_WAS_CHANGED));
         }
      }
      
      private function containerAnimationHandler(param1:ResizableBlockEvent) : void
      {
         var _loc2_:Number = this.contentMask.height + param1.heightDiff;
         this.playResizeAnimation(_loc2_,ANIMATION_DURATION,this.onEndAnimation);
      }
      
      public function get sortingFunction() : Function
      {
         return this._sortingFunction;
      }
      
      public function set sortingFunction(param1:Function) : void
      {
         this._sortingFunction = param1;
      }
   }
}
