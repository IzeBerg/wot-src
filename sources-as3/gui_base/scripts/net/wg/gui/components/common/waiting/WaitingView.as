package net.wg.gui.components.common.waiting
{
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.meta.impl.WaitingViewMeta;
   import net.wg.infrastructure.events.ChildVisibilityEvent;
   import net.wg.infrastructure.managers.IWaitingView;
   import scaleform.clik.events.InputEvent;
   
   public class WaitingView extends WaitingViewMeta implements IWaitingView
   {
      
      private static const WAITING_COMPONENT_NAME:String = "waitingComponent";
      
      private static const SOFT_SHOW_DELAY:uint = 500;
       
      
      public var waitingComponent:WaitingComponent;
      
      private var _frameOnShow:uint = 0;
      
      private var _stageWidth:int;
      
      private var _stageHeight:int;
      
      private var _isComponentShown:Boolean = false;
      
      public function WaitingView()
      {
         super();
         focusRect = false;
         focusable = false;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         this.waitingComponent.setSize(param1,param2);
         this._stageWidth = param1;
         this._stageHeight = param2;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         assertNotNull(this.waitingComponent,WAITING_COMPONENT_NAME);
         this.waitingComponent.setAnimationStatus(true);
      }
      
      override protected function nextFrameAfterPopulateHandler() : void
      {
         super.nextFrameAfterPopulateHandler();
         this.setAnimationStatus(false);
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.performHide);
         App.utils.scheduler.cancelTask(this.showWaitingComponent);
         if(this.waitingComponent)
         {
            this.waitingComponent.parent.removeChild(this.waitingComponent);
            this.waitingComponent.dispose();
            this.waitingComponent = null;
         }
         super.onDispose();
      }
      
      public function as_hideWaiting() : void
      {
         App.stage.removeEventListener(InputEvent.INPUT,this.handleInput);
         if(this._frameOnShow == this.waitingComponent.waitingMc.currentFrame)
         {
            this.performHide();
         }
         else
         {
            App.utils.scheduler.scheduleOnNextFrame(this.performHide);
         }
         this.waitingComponent.setBackgroundImg(Values.EMPTY_STR);
      }
      
      public function as_showBackgroundImg(param1:String, param2:Boolean) : void
      {
         this.waitingComponent.setBackgroundImg(param1,param2);
      }
      
      public function as_showWaiting(param1:String, param2:Boolean) : void
      {
         this._frameOnShow = this.waitingComponent.waitingMc.currentFrame;
         App.utils.scheduler.cancelTask(this.performHide);
         App.stage.addEventListener(InputEvent.INPUT,this.handleInput,false,int.MAX_VALUE,true);
         assertNotNull(this.waitingComponent,WAITING_COMPONENT_NAME);
         this.waitingComponent.setMessage(param1);
         this.setAnimationStatus(true);
         if(param2)
         {
            if(!this._isComponentShown)
            {
               App.utils.scheduler.scheduleTask(this.showWaitingComponent,SOFT_SHOW_DELAY);
            }
         }
         else
         {
            App.utils.scheduler.cancelTask(this.showWaitingComponent);
            this.showWaitingComponent();
         }
         this._isComponentShown = true;
      }
      
      public function setAnimationStatus(param1:Boolean) : void
      {
         var _loc2_:String = null;
         if(param1 != this.isOnStage && initialized)
         {
            _loc2_ = !!param1 ? ChildVisibilityEvent.CHILD_SHOWN : ChildVisibilityEvent.CHILD_HIDDEN;
            dispatchEvent(new ChildVisibilityEvent(_loc2_));
            assertNotNull(this.waitingComponent,WAITING_COMPONENT_NAME);
            this.waitingComponent.setAnimationStatus(!param1);
            this.waitingComponent.validateNow();
         }
         App.containerMgr.updateFocus();
      }
      
      private function performHide() : void
      {
         App.utils.scheduler.cancelTask(this.showWaitingComponent);
         this._isComponentShown = false;
         this.waitingComponent.movieVisible = false;
         this.setAnimationStatus(false);
      }
      
      private function showWaitingComponent() : void
      {
         this.waitingComponent.movieVisible = true;
      }
      
      public function get isFocusable() : Boolean
      {
         return focusable;
      }
      
      public function get isOnStage() : Boolean
      {
         return stage != null;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
         param1.handled = true;
         super.handleInput(param1);
      }
   }
}
