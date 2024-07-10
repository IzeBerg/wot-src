package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class PersonalInfoVO extends DAAPIDataClass
   {
      
      private static const MAIN_CONDITIONS_FIELD_NAME:String = "mainConditions";
      
      private static const ADDITIONAL_CONDITIONS_FIELD_NAME:String = "addConditions";
       
      
      public var mainConditions:Array = null;
      
      public var addConditions:Array = null;
      
      public function PersonalInfoVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         if(param1 == MAIN_CONDITIONS_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            this.mainConditions = [];
            for each(_loc4_ in _loc3_)
            {
               this.mainConditions.push(new PersonalQuestConditionVO(_loc4_));
            }
            return false;
         }
         if(param1 == ADDITIONAL_CONDITIONS_FIELD_NAME)
         {
            _loc5_ = param2 as Array;
            this.addConditions = [];
            for each(_loc6_ in _loc5_)
            {
               this.addConditions.push(new PersonalQuestConditionVO(_loc6_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:PersonalQuestConditionVO = null;
         var _loc2_:PersonalQuestConditionVO = null;
         if(this.mainConditions != null)
         {
            for each(_loc1_ in this.mainConditions)
            {
               _loc1_.dispose();
            }
            this.mainConditions.length = 0;
            this.mainConditions = null;
         }
         if(this.addConditions != null)
         {
            for each(_loc2_ in this.addConditions)
            {
               _loc2_.dispose();
            }
            this.addConditions.length = 0;
            this.addConditions = null;
         }
         super.onDispose();
      }
   }
}
