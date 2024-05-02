package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class AbilityBattleRankItemVO extends DAAPIDataClass
   {
      
      private static const ITEMS:String = "items";
       
      
      public var abilityName:String = "";
      
      public var items:Vector.<String> = null;
      
      public function AbilityBattleRankItemVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc3_:Boolean = true;
         if(param1 == ITEMS)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc4_,Errors.INVALID_TYPE + Array);
            this.items = new Vector.<String>(0);
            for each(_loc5_ in _loc4_)
            {
               this.items.push(_loc5_);
            }
            _loc3_ = false;
         }
         return _loc3_;
      }
      
      public function getItemAt(param1:int) : String
      {
         if(param1 > -1 && param1 < this.items.length)
         {
            return this.items[param1];
         }
         return Values.EMPTY_STR;
      }
      
      override protected function onDispose() : void
      {
         this.items.splice(0,this.items.length);
         this.items = null;
         super.onDispose();
      }
   }
}
