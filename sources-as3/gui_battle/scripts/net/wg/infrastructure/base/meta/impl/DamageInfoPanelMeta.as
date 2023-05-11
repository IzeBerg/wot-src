package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class DamageInfoPanelMeta extends BattleDisplayable
   {
       
      
      private var _array:Array;
      
      public function DamageInfoPanelMeta()
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
         super.onDispose();
      }
      
      public final function as_show(param1:Array, param2:int) : void
      {
         var _loc3_:Array = this._array;
         this._array = param1;
         this.show(this._array,param2);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      protected function show(param1:Array, param2:int) : void
      {
         var _loc3_:String = "as_show" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
