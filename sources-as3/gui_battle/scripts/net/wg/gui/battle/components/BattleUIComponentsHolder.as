package net.wg.gui.battle.components
{
   import flash.display.Stage;
   import flash.events.Event;
   import net.wg.data.constants.InvalidationType;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleUIComponentsHolder implements IDisposable
   {
       
      
      private var _stage:Stage = null;
      
      private var _invalidMask:uint = 0;
      
      private var _invalid:Boolean = false;
      
      private var _isDisposed:Boolean = false;
      
      public function BattleUIComponentsHolder()
      {
         super();
      }
      
      public final function dispose() : void
      {
         if(this._invalid)
         {
            this._stage.removeEventListener(Event.RENDER,this.onRenderHandler);
            this._stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         }
         this._stage = null;
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         if(this._isDisposed && App.instance)
         {
            App.utils.asserter.assert(false,this + " is already disposed!");
         }
         this._isDisposed = true;
      }
      
      protected function invalidate(param1:uint = 4.294967295E9) : void
      {
         this._invalidMask |= param1;
         if(!this._invalid)
         {
            this._invalid = true;
            if(!this._stage)
            {
               this._stage = App.stage;
            }
            this._stage.addEventListener(Event.RENDER,this.onRenderHandler);
            this._stage.addEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
            this._stage.invalidate();
         }
      }
      
      protected function isInvalid(param1:uint) : Boolean
      {
         return this._invalid && uint(this._invalidMask & param1) > 0;
      }
      
      protected function draw() : void
      {
      }
      
      private function onRenderHandler(param1:Event) : void
      {
         this.handleRedrawEvent();
      }
      
      private function onEnterFrameHandler(param1:Event) : void
      {
         this.handleRedrawEvent();
      }
      
      private function handleRedrawEvent() : void
      {
         this._stage.removeEventListener(Event.RENDER,this.onRenderHandler);
         this._stage.removeEventListener(Event.ENTER_FRAME,this.onEnterFrameHandler);
         if(!this._invalid)
         {
            return;
         }
         this.draw();
         this._invalidMask = InvalidationType.VALID;
         this._invalid = false;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}
