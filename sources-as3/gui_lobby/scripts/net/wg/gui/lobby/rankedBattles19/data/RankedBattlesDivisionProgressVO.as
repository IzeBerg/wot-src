package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RankedBattlesDivisionProgressVO extends DAAPIDataClass
   {
      
      private static const FIELD_BLOCKS:String = "blocks";
       
      
      public var blocks:Vector.<DivisionProgressBlockVO> = null;
      
      public var isLocked:Boolean = false;
      
      public var isFirstEnter:Boolean = false;
      
      public function RankedBattlesDivisionProgressVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         if(param1 == FIELD_BLOCKS)
         {
            if(param2 != null)
            {
               this.blocks = new Vector.<DivisionProgressBlockVO>(0);
               for each(_loc3_ in param2)
               {
                  this.blocks.push(new DivisionProgressBlockVO(_loc3_));
               }
            }
            else
            {
               App.utils.asserter.assert(false,param1 + " " + Errors.INVALID_TYPE + Array);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DivisionProgressBlockVO = null;
         for each(_loc1_ in this.blocks)
         {
            _loc1_.dispose();
         }
         this.blocks.splice(0,this.blocks.length);
         this.blocks = null;
         super.onDispose();
      }
   }
}
