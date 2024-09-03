package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ConsumablesPanelMeta extends BattleDisplayable
   {
       
      
      public var onClickedToSlot:Function;
      
      public var onPanelShown:Function;
      
      public var onPanelHidden:Function;
      
      private var _array:Array;
      
      private var _array1:Array;
      
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
         super.onDispose();
      }
      
      public function onClickedToSlotS(param1:Number, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.onClickedToSlot,"onClickedToSlot" + Errors.CANT_NULL);
         this.onClickedToSlot(param1,param2);
      }
      
      public function onPanelShownS() : void
      {
         App.utils.asserter.assertNotNull(this.onPanelShown,"onPanelShown" + Errors.CANT_NULL);
         this.onPanelShown();
      }
      
      public function onPanelHiddenS() : void
      {
         App.utils.asserter.assertNotNull(this.onPanelHidden,"onPanelHidden" + Errors.CANT_NULL);
         this.onPanelHidden();
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
      
      public final function as_reset(param1:Array) : void
      {
         var _loc2_:Array = this._array1;
         this._array1 = param1;
         this.reset(this._array1);
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
      
      protected function reset(param1:Array) : void
      {
         var _loc2_:String = "as_reset" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
