package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class StepsContainerVO extends DAAPIDataClass
   {
      
      private static const STEPS:String = "steps";
       
      
      public var steps:Vector.<String> = null;
      
      public var infoText:String = "";
      
      public function StepsContainerVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         if(param2 != null && param1 == STEPS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,STEPS + Errors.CANT_NULL);
            this.steps = new Vector.<String>(0);
            for each(_loc4_ in _loc3_)
            {
               this.steps.push(_loc4_);
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.steps != null)
         {
            this.steps.splice(0,this.steps.length);
            this.steps = null;
         }
         super.onDispose();
      }
   }
}
