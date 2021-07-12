package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RibbonsPanelMeta extends BattleDisplayable
   {
       
      
      public var onShow:Function;
      
      public var onChange:Function;
      
      public var onHide:Function;
      
      private var _array:Array;
      
      private var _array1:Array;
      
      public function RibbonsPanelMeta()
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
      
      public function onShowS() : void
      {
         App.utils.asserter.assertNotNull(this.onShow,"onShow" + Errors.CANT_NULL);
         this.onShow();
      }
      
      public function onChangeS() : void
      {
         App.utils.asserter.assertNotNull(this.onChange,"onChange" + Errors.CANT_NULL);
         this.onChange();
      }
      
      public function onHideS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onHide,"onHide" + Errors.CANT_NULL);
         this.onHide(param1);
      }
      
      public final function as_setup(param1:Array, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Array) : void
      {
         var _loc7_:Array = this._array;
         this._array = param1;
         var _loc8_:Array = this._array1;
         this._array1 = param6;
         this.setup(this._array,param2,param3,param4,param5,this._array1);
         if(_loc7_)
         {
            _loc7_.splice(0,_loc7_.length);
         }
         if(_loc8_)
         {
            _loc8_.splice(0,_loc8_.length);
         }
      }
      
      protected function setup(param1:Array, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean, param6:Array) : void
      {
         var _loc7_:String = "as_setup" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc7_);
         throw new AbstractException(_loc7_);
      }
   }
}
