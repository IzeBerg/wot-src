package net.wg.gui.lobby.shop.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class RentalTermSelectionPopoverVO extends DAAPIDataClass
   {
      
      private static const RENTAL_TERM_SLOTS:String = "rentalTermSlots";
       
      
      public var titleLabel:String = "";
      
      private var _rentalTermSlots:DataProvider;
      
      public function RentalTermSelectionPopoverVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(RENTAL_TERM_SLOTS == param1)
         {
            this._rentalTermSlots = new DataProvider();
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,RENTAL_TERM_SLOTS + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_)
            {
               this._rentalTermSlots.push(new RentalTermSlotButtonVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:uint = this._rentalTermSlots.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._rentalTermSlots[_loc2_].dispose();
            _loc2_++;
         }
         this._rentalTermSlots.splice(0,_loc1_);
         this._rentalTermSlots = null;
         super.onDispose();
      }
      
      public function get rentalTermSlots() : IDataProvider
      {
         return this._rentalTermSlots;
      }
   }
}
