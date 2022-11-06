package net.wg.gui.components.controls.VO
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.generated.CURRENCIES_CONSTANTS;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CompoundPriceVO extends Array implements IDisposable
   {
       
      
      public var items:Vector.<PriceVO> = null;
      
      private var _disposed:Boolean = false;
      
      public function CompoundPriceVO(param1:Array)
      {
         var _loc4_:Array = null;
         super();
         this.items = new Vector.<PriceVO>(0);
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1[_loc3_];
            this.items.push(new PriceVO(_loc4_));
            _loc3_++;
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         if(this.items != null)
         {
            this.items.splice(0,this.items.length);
            this.items = null;
         }
      }
      
      public function isEqual(param1:CompoundPriceVO) : Boolean
      {
         if(param1 == null || this.items.length != param1.items.length)
         {
            return false;
         }
         var _loc2_:int = this.items.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(!this.items[_loc3_].isEqual(param1.items[_loc3_]))
            {
               return false;
            }
            _loc3_++;
         }
         return true;
      }
      
      public function toString() : String
      {
         var _loc2_:PriceVO = null;
         var _loc1_:String = "";
         for each(_loc2_ in this.items)
         {
            _loc1_ += "\t" + _loc2_ + ",\n";
         }
         return "[CompoundPriceVO\n" + _loc1_ + "]";
      }
      
      public function getPriceVO() : PriceVO
      {
         var _loc1_:PriceVO = null;
         for each(_loc1_ in this.items)
         {
            if(_loc1_.value)
            {
               return _loc1_;
            }
         }
         return new PriceVO([CURRENCIES_CONSTANTS.CREDITS,0]);
      }
      
      public function getPriceValueByName(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc4_:PriceVO = null;
         var _loc3_:int = this.items.length;
         while(_loc2_ < _loc3_)
         {
            _loc4_ = this.items[_loc2_];
            if(_loc4_.name == param1)
            {
               return _loc4_.value;
            }
            _loc2_++;
         }
         App.utils.asserter.assert(true,Errors.WRONG_VALUE);
         return 0;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
