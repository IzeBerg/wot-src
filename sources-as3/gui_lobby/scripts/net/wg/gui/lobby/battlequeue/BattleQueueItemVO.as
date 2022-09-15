package net.wg.gui.lobby.battlequeue
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BattleQueueItemVO extends DAAPIDataClass
   {
       
      
      public var type:String = "";
      
      public var icon:String = "";
      
      public var count:Number = NaN;
      
      public var highlight:Boolean = false;
      
      public function BattleQueueItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
