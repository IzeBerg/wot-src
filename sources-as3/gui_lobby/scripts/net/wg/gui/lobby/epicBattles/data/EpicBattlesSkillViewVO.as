package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIUpdatableDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class EpicBattlesSkillViewVO extends DAAPIUpdatableDataClass
   {
      
      protected static const SKILL_TEXTS_FIELD_NAME:String = "skillInfo";
      
      protected static const SKILL_FIELD_NAME:String = "skills";
       
      
      public var skillPoints:int = -1;
      
      public var skills:DataProvider = null;
      
      public var skillsLabel:String = "";
      
      public var header:String = "";
      
      public var headerBig:String = "";
      
      public var showSkillPoints:Boolean = true;
      
      public var showBackButton:Boolean = true;
      
      public var skillInfo:EpicBattleSkillInitVO = null;
      
      public var backgroundImageSrc:String = "";
      
      public function EpicBattlesSkillViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Vector.<EpicBattleSkillVO> = null;
         var _loc7_:EpicBattleSkillVO = null;
         var _loc8_:EpicBattleSkillVO = null;
         var _loc9_:Array = null;
         switch(param1)
         {
            case SKILL_TEXTS_FIELD_NAME:
               this.skillInfo = new EpicBattleSkillInitVO(param2);
               return false;
            case SKILL_FIELD_NAME:
               if(this.skills)
               {
                  App.utils.asserter.assert(param2 is Array,Errors.INVALID_TYPE);
                  _loc6_ = new Vector.<EpicBattleSkillVO>(0);
                  _loc3_ = param2 as Array;
                  if(_loc3_ != null)
                  {
                     _loc4_ = _loc3_.length;
                     _loc5_ = 0;
                     while(_loc5_ < _loc4_)
                     {
                        _loc6_.push(new EpicBattleSkillVO(_loc3_[_loc5_]));
                        _loc5_++;
                     }
                  }
                  for each(_loc7_ in _loc6_)
                  {
                     for each(_loc8_ in this.skills)
                     {
                        if(_loc7_.skillID == _loc8_.skillID)
                        {
                           _loc8_.update(_loc7_.toHash());
                        }
                     }
                  }
               }
               else
               {
                  App.utils.asserter.assert(param2 is Array,Errors.INVALID_TYPE);
                  _loc9_ = [];
                  _loc3_ = param2 as Array;
                  if(_loc3_ != null)
                  {
                     _loc4_ = _loc3_.length;
                     _loc5_ = 0;
                     while(_loc5_ < _loc4_)
                     {
                        _loc9_.push(new EpicBattleSkillVO(_loc3_[_loc5_]));
                        _loc5_++;
                     }
                  }
                  this.skills = new DataProvider(_loc9_);
               }
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:EpicBattleSkillVO = null;
         if(this.skillInfo)
         {
            this.skillInfo.dispose();
            this.skillInfo = null;
         }
         if(this.skills)
         {
            for each(_loc1_ in this.skills)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
            this.skills.cleanUp();
            this.skills = null;
         }
         super.onDispose();
      }
   }
}
