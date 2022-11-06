package net.wg.gui.battle.components
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.interfaces.IBattleUIComponent;
   import net.wg.infrastructure.events.LifeCycleEvent;
   
   public class BattleUIComponent extends MovieClip implements IBattleUIComponent
   {
       
      
      private var _initialized:Boolean = false;
      
      private var _invalidMask:uint = 0;
      
      protected var _invalid:Boolean = false;
      
      protected var _baseDisposed:Boolean = false;
      
      public function BattleUIComponent()
      {
         this.preInitialize();
         super();
         this.initialize();
         this.invalidate();
      }
      
      protected function preInitialize() : void
      {
      }
      
      protected function initialize() : void
      {
      }
      
      public function get initialized() : Boolean
      {
         return this._initialized;
      }
      
      public function invalidate(param1:uint = 4.294967295E9) : void
      {
         this.throwLifeCycleException();
         if(!this._baseDisposed)
         {
            this._invalidMask |= param1;
            if(!this._invalid)
            {
               this._invalid = true;
               if(!stage)
               {
                  addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageHandler,false,0,true);
               }
               else
               {
                  addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler,false,0,true);
                  addEventListener(Event.RENDER,this.onRenderHandler,false,0,true);
                  stage.invalidate();
               }
            }
            else if(stage)
            {
               stage.invalidate();
            }
         }
      }
      
      public function validateNow(param1:Event = null) : void
      {
         if(!this.initialized)
         {
            this._initialized = true;
            this.configUI();
         }
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler,false);
         removeEventListener(Event.RENDER,this.onRenderHandler,false);
         if(this._invalid)
         {
            this.draw();
            this.validate();
         }
      }
      
      protected function isInvalid(param1:uint) : Boolean
      {
         this.throwLifeCycleException();
         if(!this._invalid)
         {
            return false;
         }
         return (this._invalidMask & param1) > 0;
      }
      
      private function validate() : void
      {
         this._invalidMask = InvalidationType.VALID;
         this._invalid = false;
      }
      
      private function onEnterFrameHandler(param1:Event) : void
      {
         this.throwLifeCycleException();
         this.validateNow();
      }
      
      private function onRenderHandler(param1:Event) : void
      {
         this.throwLifeCycleException();
         this.validateNow();
      }
      
      private function onAddedToStageHandler(param1:Event) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageHandler,false);
         addEventListener(Event.RENDER,this.onRenderHandler,false,0,true);
         if(stage)
         {
            stage.invalidate();
         }
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed && App.instance)
         {
            App.utils.asserter.assert(false,name + "(" + getQualifiedClassName(this) + ") already disposed!");
         }
         this._baseDisposed = true;
         this.doBeforeDispose();
         this.doDispose();
         this.onAfterDispose();
      }
      
      private function doBeforeDispose() : void
      {
         this.onBeforeDispose();
      }
      
      protected function onBeforeDispose() : void
      {
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_BEFORE_DISPOSE));
         removeEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageHandler,false);
         removeEventListener(Event.RENDER,this.onRenderHandler);
         removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
      }
      
      private function doDispose() : void
      {
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
      }
      
      private function onAfterDispose() : void
      {
         dispatchEvent(new LifeCycleEvent(LifeCycleEvent.ON_AFTER_DISPOSE));
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
      }
      
      public function invalidateSize() : void
      {
         this.invalidate(InvalidationType.SIZE);
      }
      
      public function invalidateData() : void
      {
         this.invalidate(InvalidationType.DATA);
      }
      
      public function invalidateState() : void
      {
         this.invalidate(InvalidationType.STATE);
      }
      
      public function invalidatePosition() : void
      {
         this.invalidate(InvalidationType.POSITION);
      }
      
      protected function configUI() : void
      {
      }
      
      protected function draw() : void
      {
      }
      
      protected function throwLifeCycleException() : void
      {
         if(this._baseDisposed && App.instance)
         {
            App.utils.asserter.assert(false,"invoking component \'" + this + "\' after dispose!");
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(super.visible != param1)
         {
            super.visible = param1;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
   }
}
