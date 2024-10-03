package net.wg.white_tiger.gui.lobby.battleQueue.data
{
   import net.wg.data.constants.Errors;
   
   public class HunterQuickStartPanelVO extends QuickStartPanelVO
   {
      
      private static const HUNTERS_FIELD:String = "hunters";
       
      
      public var hunters:Vector.<QuickStartPanelHunterInfoVO> = null;
      
      public function HunterQuickStartPanelVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == HUNTERS_FIELD)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(param2 is Array,Errors.INVALID_TYPE + "Array");
            this.hunters = new Vector.<QuickStartPanelHunterInfoVO>(0);
            for each(_loc4_ in _loc3_)
            {
               this.hunters.push(new QuickStartPanelHunterInfoVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:QuickStartPanelHunterInfoVO = null;
         for each(_loc1_ in this.hunters)
         {
            _loc1_.dispose();
         }
         if(this.hunters)
         {
            this.hunters.length = 0;
         }
         this.hunters = null;
      }
   }
}
