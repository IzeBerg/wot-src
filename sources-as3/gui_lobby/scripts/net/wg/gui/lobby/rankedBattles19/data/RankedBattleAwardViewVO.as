package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RankedBattleAwardViewVO extends DAAPIDataClass
   {
      
      private static const VOS_SEQUENCE_FIELD:String = "vosSequence";
       
      
      public var title:String = "";
      
      public var nextButtonLabel:String = "";
      
      public var vosSequence:Vector.<RankedBattlesCurrentAwardVO> = null;
      
      public function RankedBattleAwardViewVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == VOS_SEQUENCE_FIELD)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,VOS_SEQUENCE_FIELD + Errors.CANT_NULL);
            this.vosSequence = new Vector.<RankedBattlesCurrentAwardVO>(0);
            for each(_loc4_ in param2)
            {
               this.vosSequence.push(new RankedBattlesCurrentAwardVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this.vosSequence)
         {
            _loc1_.dispose();
         }
         this.vosSequence.length = 0;
         this.vosSequence = null;
         super.onDispose();
      }
   }
}
