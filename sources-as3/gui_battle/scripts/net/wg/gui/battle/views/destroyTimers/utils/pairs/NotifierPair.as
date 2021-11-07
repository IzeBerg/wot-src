package net.wg.gui.battle.views.destroyTimers.utils.pairs
{
   import flash.display.DisplayObject;
   import net.wg.gui.battle.views.destroyTimers.components.notifiers.INotifier;
   
   public class NotifierPair
   {
       
      
      private var _normal:INotifier;
      
      private var _collapsed:INotifier;
      
      private var _state:int = 0;
      
      private var _stateChanged:Boolean;
      
      public function NotifierPair(param1:INotifier, param2:INotifier)
      {
         super();
         this._normal = param1;
         this._collapsed = param2;
         param2.visible = false;
         param1.visible = false;
         this._state = NotifierPairState.HIDDEN;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         this._normal.dispose();
         this._normal = null;
         this._collapsed.dispose();
         this._collapsed = null;
      }
      
      protected function draw() : void
      {
         if(this._stateChanged)
         {
            this._collapsed.visible = this._state == NotifierPairState.COLLAPSED;
            this._normal.visible = this._state == NotifierPairState.NORMAL;
            this._stateChanged = false;
         }
      }
      
      public function get normal() : DisplayObject
      {
         return DisplayObject(this._normal);
      }
      
      public function get collapsed() : DisplayObject
      {
         return DisplayObject(this._collapsed);
      }
      
      public function get state() : int
      {
         return this._state;
      }
      
      public function set state(param1:int) : void
      {
         if(this._state != param1)
         {
            this._state = param1;
            this._stateChanged = true;
            this.draw();
         }
      }
   }
}
