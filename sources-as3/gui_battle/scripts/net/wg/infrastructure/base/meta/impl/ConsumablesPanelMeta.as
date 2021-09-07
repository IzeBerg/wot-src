package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ConsumablesPanelMeta extends BattleDisplayable
   {
       
      
      public var onClickedToSlot:Function;
      
      public var onPopUpClosed:Function;
      
      private var _array:Array;
      
      private var _array1:Array;
      
      private var _array2:Array;
      
      public function ConsumablesPanelMeta()
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
         if(this._array2)
         {
            this._array2.splice(0,this._array2.length);
            this._array2 = null;
         }
         super.onDispose();
      }
      
      public function onClickedToSlotS(param1:Number, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.onClickedToSlot,"onClickedToSlot" + Errors.CANT_NULL);
         this.onClickedToSlot(param1,param2);
      }
      
      public function onPopUpClosedS() : void
      {
         App.utils.asserter.assertNotNull(this.onPopUpClosed,"onPopUpClosed" + Errors.CANT_NULL);
         this.onPopUpClosed();
      }
      
      public final function as_setKeysToSlots(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.setKeysToSlots(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_expandEquipmentSlot(param1:int, param2:Array) : void
      {
         var _loc3_:Array = this._array1;
         this._array1 = param2;
         this.expandEquipmentSlot(param1,this._array1);
         if(_loc3_)
         {
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      public final function as_reset(param1:Array) : void
      {
         var _loc2_:Array = this._array2;
         this._array2 = param1;
         this.reset(this._array2);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setKeysToSlots(param1:Array) : void
      {
         var _loc2_:String = "as_setKeysToSlots" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function expandEquipmentSlot(param1:int, param2:Array) : void
      {
         var _loc3_:String = "as_expandEquipmentSlot" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function reset(param1:Array) : void
      {
         var _loc2_:String = "as_reset" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
