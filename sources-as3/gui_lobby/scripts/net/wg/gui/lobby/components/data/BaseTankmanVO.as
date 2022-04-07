package net.wg.gui.lobby.components.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BaseTankmanVO extends DAAPIDataClass
   {
      
      private static const SKILLS:String = "skills";
      
      private static const MAX_SKILL_LEVEL:int = 100;
       
      
      public var lastName:String = "";
      
      public var fullName:String = "";
      
      public var rank:String = "";
      
      public var specializationLevel:int = -1;
      
      public var role:String = "";
      
      public var vehicleType:String = "";
      
      public var iconFile:String = "";
      
      public var rankIconFile:String = "";
      
      public var roleIconFile:String = "";
      
      public var contourIconFile:String = "";
      
      public var nationID:int = -1;
      
      public var typeID:int = -1;
      
      public var inTank:Boolean = false;
      
      public var roleType:String = "";
      
      public var tankType:String = "";
      
      public var compact:String = "";
      
      public var tankmanID:Number = NaN;
      
      public var lastSkillLevel:int = -1;
      
      public var skills:Array;
      
      public var buySkillLevel:int = 0;
      
      public var canBuySkill:Boolean = false;
      
      public var buySkillCount:int = 0;
      
      public function BaseTankmanVO(param1:Object)
      {
         this.skills = [];
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:SkillsVO = null;
         if(param1 == SKILLS)
         {
            if(param2 != null)
            {
               _loc3_ = param2 as Array;
               App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
               _loc4_ = _loc3_.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  _loc6_ = new SkillsVO(_loc3_[_loc5_]);
                  if(_loc6_.buy)
                  {
                     this.canBuySkill = true;
                     this.buySkillCount = _loc6_.buyCount;
                     this.buySkillLevel = _loc6_.level;
                     _loc6_.dispose();
                  }
                  else
                  {
                     if(_loc6_.icon)
                     {
                        _loc6_.icon = RES_ICONS.maps_icons_tankmen_skills_small(_loc6_.icon);
                     }
                     this.skills.push(_loc6_);
                  }
                  _loc5_++;
               }
            }
            return false;
         }
         return true;
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:uint = this.skills.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this.skills[_loc2_].dispose();
            _loc2_++;
         }
         this.skills.splice(0,_loc1_);
         this.skills = null;
         super.onDispose();
      }
      
      public function get lastSkillInProgress() : Boolean
      {
         return this.skills.length > 0 && this.lastSkillLevel != MAX_SKILL_LEVEL;
      }
   }
}
