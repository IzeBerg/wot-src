package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class CalendarMeta extends BaseDAAPIComponent
   {
       
      
      public var onMonthChanged:Function;
      
      public var onDateSelected:Function;
      
      public var formatYMHeader:Function;
      
      private var _array:Array;
      
      public function CalendarMeta()
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
      
      public function onMonthChangedS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onMonthChanged,"onMonthChanged" + Errors.CANT_NULL);
         this.onMonthChanged(param1);
      }
      
      public function onDateSelectedS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onDateSelected,"onDateSelected" + Errors.CANT_NULL);
         this.onDateSelected(param1);
      }
      
      public function formatYMHeaderS(param1:Number) : String
      {
         App.utils.asserter.assertNotNull(this.formatYMHeader,"formatYMHeader" + Errors.CANT_NULL);
         return this.formatYMHeader(param1);
      }
      
      public final function as_setHighlightedDays(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.setHighlightedDays(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setHighlightedDays(param1:Array) : void
      {
         var _loc2_:String = "as_setHighlightedDays" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
