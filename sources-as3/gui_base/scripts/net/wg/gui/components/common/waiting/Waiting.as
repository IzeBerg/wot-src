package net.wg.gui.components.common.waiting
{
   import flash.geom.Point;
   import net.wg.data.constants.Linkages;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.base.interfaces.IWaiting;
   import scaleform.clik.constants.InvalidationType;
   
   public class Waiting extends UIComponentEx implements IWaiting
   {
      
      private static const SOFT_SHOW_DELAY:uint = 500;
       
      
      private var _waitingComponent:WaitingComponent = null;
      
      private var _text:String = null;
      
      private var _backgroundVisibility:Boolean = true;
      
      private var _waitingOffset:Point = null;
      
      private var _isComponentShown:Boolean = false;
      
      public function Waiting()
      {
         super();
         visible = false;
      }
      
      override protected function onDispose() : void
      {
         if(this._waitingComponent)
         {
            this._waitingComponent.dispose();
            this._waitingComponent = null;
         }
         this._waitingOffset = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateSize();
         }
      }
      
      public function hide() : void
      {
         if(this._waitingComponent)
         {
            App.utils.scheduler.cancelTask(this.showWaitingComponent);
            this._waitingComponent.setAnimationStatus(true);
            this._waitingComponent.movieVisible = false;
         }
         visible = false;
         this._isComponentShown = false;
      }
      
      public function setMessage(param1:String) : void
      {
         if(this._text != param1)
         {
            this._text = param1;
            this.updateMessage();
         }
      }
      
      public function setWaitingOffset(param1:Point) : void
      {
         this._waitingOffset = param1;
      }
      
      public function show(param1:Boolean = false) : void
      {
         if(visible)
         {
            return;
         }
         visible = true;
         if(!this._waitingComponent)
         {
            this._waitingComponent = App.utils.classFactory.getComponent(Linkages.WAITING_COMPONENT,WaitingComponent);
            this._waitingComponent.movieVisible = false;
            addChild(this._waitingComponent);
            this.updateBackgroundVisibility();
            this.updateSize();
            this.updateMessage();
            this.updateOffset();
            this._waitingComponent.validateNow();
         }
         else
         {
            this._waitingComponent.setAnimationStatus(false);
         }
         if(param1)
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
      
      private function showWaitingComponent() : void
      {
         if(this._waitingComponent)
         {
            this._waitingComponent.movieVisible = true;
         }
      }
      
      private function updateOffset() : void
      {
         if(this._waitingComponent && this._waitingOffset)
         {
            this._waitingComponent.setWaitingOffset(this._waitingOffset);
         }
      }
      
      private function updateMessage() : void
      {
         if(this._waitingComponent)
         {
            this._waitingComponent.setMessage(this._text);
         }
      }
      
      private function updateBackgroundVisibility() : void
      {
         if(this._waitingComponent)
         {
            this._waitingComponent.backgroundVisibility = this._backgroundVisibility;
         }
      }
      
      private function updateSize() : void
      {
         if(this._waitingComponent)
         {
            this._waitingComponent.setSize(_width,_height);
         }
      }
      
      public function set backgroundVisibility(param1:Boolean) : void
      {
         if(this._backgroundVisibility != param1)
         {
            this._backgroundVisibility = param1;
            this.updateBackgroundVisibility();
         }
      }
   }
}
