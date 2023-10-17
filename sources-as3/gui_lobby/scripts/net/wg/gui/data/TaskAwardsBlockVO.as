package net.wg.gui.data
{
   public class TaskAwardsBlockVO extends BaseAwardsBlockVO
   {
       
      
      public var awardForCompleteText:String = "";
      
      public var awardReceivedText:String = "";
      
      public var awardBonusStrText:String = "";
      
      public var ribbonSource:String = "";
      
      public var isAwardForCompleteVisible:Boolean = false;
      
      public var isAwardsReceivedVisible:Boolean = false;
      
      public var isAwardBonusStrVisible:Boolean = false;
      
      public function TaskAwardsBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}
