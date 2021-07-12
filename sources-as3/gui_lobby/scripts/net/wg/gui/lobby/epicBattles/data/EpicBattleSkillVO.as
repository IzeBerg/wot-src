package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   
   public class EpicBattleSkillVO extends DAAPIUpdatableDataClass
   {
      
      private static const SKILL_LEVEL_LABELS:String = "skillLevelLabels";
       
      
      public var skillID:uint = 0;
      
      public var level:uint = 0;
      
      public var maxLevel:uint = 0;
      
      public var title:String = "";
      
      public var smallTitle:String = "";
      
      public var desc:String = "";
      
      public var label:String = "";
      
      public var skillLevelLabels:Vector.<String> = null;
      
      public var iconUrl:String = "";
      
      public function EpicBattleSkillVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:String = null;
         switch(param1)
         {
            case SKILL_LEVEL_LABELS:
               App.utils.asserter.assert(param2 is Array,param1 + " must be an Array");
               this.skillLevelLabels = new Vector.<String>();
               for each(_loc3_ in param2)
               {
                  this.skillLevelLabels.push(_loc3_);
               }
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.skillLevelLabels)
         {
            this.skillLevelLabels.splice(0,this.skillLevelLabels.length);
            this.skillLevelLabels = null;
         }
         super.onDispose();
      }
   }
}
