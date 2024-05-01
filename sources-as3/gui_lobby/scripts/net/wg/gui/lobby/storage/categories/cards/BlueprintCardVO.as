package net.wg.gui.lobby.storage.categories.cards
{
   import net.wg.data.constants.Errors;
   
   public class BlueprintCardVO extends BaseCardVO
   {
      
      private static const FIELD_FRAGMENTS_COST:String = "fragmentsCost";
       
      
      public var fragmentsProgress:String = "";
      
      public var intelligenceCostText:String = "";
      
      public var fragmentsCost:Vector.<BlueprintCardCostVO> = null;
      
      public var hasDiscount:Boolean = false;
      
      public var availableToUnlock:Boolean = false;
      
      public var convertAvailable:Boolean = false;
      
      public function BlueprintCardVO(param1:Object)
      {
         super(param1);
      }
      
      override public function toString() : String
      {
         return "[BlueprintCardVO > id: " + id + ", image: " + image + "]";
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:BlueprintCardCostVO = null;
         if(param1 == FIELD_FRAGMENTS_COST)
         {
            if(param2 != null)
            {
               _loc3_ = param2 as Array;
               App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
               this.fragmentsCost = new Vector.<BlueprintCardCostVO>(0);
               _loc4_ = _loc3_.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc6_ = new BlueprintCardCostVO(_loc3_[_loc5_]);
                  this.fragmentsCost.push(_loc6_);
                  _loc5_++;
               }
            }
            return false;
         }
         return true;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BlueprintCardCostVO = null;
         for each(_loc1_ in this.fragmentsCost)
         {
            _loc1_.dispose();
         }
         this.fragmentsCost.length = 0;
         this.fragmentsCost = null;
         super.onDispose();
      }
   }
}
