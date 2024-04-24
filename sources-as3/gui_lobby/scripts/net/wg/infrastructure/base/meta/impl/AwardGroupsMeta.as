package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class AwardGroupsMeta extends BaseDAAPIComponent
   {
       
      
      public var showGroup:Function;
      
      private var _array:Array;
      
      private var _array1:Array;
      
      public function AwardGroupsMeta()
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
      
      public function showGroupS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.showGroup,"showGroup" + Errors.CANT_NULL);
         this.showGroup(param1);
      }
      
      public final function as_setData(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.setData(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setTooltips(param1:Array) : void
      {
         var _loc2_:Array = this._array1;
         this._array1 = param1;
         this.setTooltips(this._array1);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setData(param1:Array) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setTooltips(param1:Array) : void
      {
         var _loc2_:String = "as_setTooltips" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
