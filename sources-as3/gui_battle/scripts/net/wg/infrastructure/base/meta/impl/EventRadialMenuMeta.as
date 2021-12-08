package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.views.radialMenu.RadialMenu;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EventRadialMenuMeta extends RadialMenu
   {
       
      
      public var showHandCursor:Function;
      
      public var hideHandCursor:Function;
      
      public var leaveRadialMode:Function;
      
      private var _array:Array;
      
      private var _array1:Array;
      
      public function EventRadialMenuMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         if(this._array1)
         {
            this._array1.splice(0,this._array1.length);
            this._array1 = null;
         }
         super.onDispose();
      }
      
      public function showHandCursorS() : void
      {
         App.utils.asserter.assertNotNull(this.showHandCursor,"showHandCursor" + Errors.CANT_NULL);
         this.showHandCursor();
      }
      
      public function hideHandCursorS() : void
      {
         App.utils.asserter.assertNotNull(this.hideHandCursor,"hideHandCursor" + Errors.CANT_NULL);
         this.hideHandCursor();
      }
      
      public function leaveRadialModeS() : void
      {
         App.utils.asserter.assertNotNull(this.leaveRadialMode,"leaveRadialMode" + Errors.CANT_NULL);
         this.leaveRadialMode();
      }
      
      public final function as_showWithName(param1:String, param2:Array, param3:Array, param4:String) : void
      {
         var _loc5_:Array = this._array;
         this._array = param2;
         var _loc6_:Array = this._array1;
         this._array1 = param3;
         this.showWithName(param1,this._array,this._array1,param4);
         if(_loc5_)
         {
            _loc5_.splice(0,_loc5_.length);
         }
         if(_loc6_)
         {
            _loc6_.splice(0,_loc6_.length);
         }
      }
      
      protected function showWithName(param1:String, param2:Array, param3:Array, param4:String) : void
      {
         var _loc5_:String = "as_showWithName" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc5_);
         throw new AbstractException(_loc5_);
      }
   }
}
