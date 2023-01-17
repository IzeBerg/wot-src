package net.wg.gui.lobby.tankman
{
   import net.wg.data.VO.TankmanAchievementVO;
   import net.wg.gui.lobby.tankman.crewSkins.model.PersonalCaseCrewSkinsVO;
   import net.wg.infrastructure.base.meta.IPersonalCaseMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalCaseMeta;
   
   public class PersonalCaseBase extends PersonalCaseMeta implements IPersonalCaseMeta
   {
      
      private static const SKILLS:String = "skills";
       
      
      protected var data:PersonalCaseModel;
      
      protected var stats:Object;
      
      protected var retrainingData:PersonalCaseRetrainingModel;
      
      protected var freeSkillsModel:Array;
      
      protected var skillsModel:Array;
      
      protected var documentsData:PersonalCaseDocsModel;
      
      protected var crewSkinsData:PersonalCaseCrewSkinsVO;
      
      protected var rentainingTabUpdated:Boolean = true;
      
      public function PersonalCaseBase()
      {
         this.freeSkillsModel = [];
         this.skillsModel = [];
         super();
      }
      
      override protected function onDispose() : void
      {
         this.data = null;
         this.stats = null;
         this.retrainingData = null;
         this.freeSkillsModel = null;
         this.skillsModel = null;
         this.documentsData = null;
         this.crewSkinsData = null;
         super.onDispose();
      }
      
      override protected function setCommonData(param1:PersonalCaseModel) : void
      {
         this.data = param1;
         this.updateCommonElements();
         this.updateSkillsRelatedElements();
      }
      
      public function as_setDossierData(param1:Object) : void
      {
         var _loc4_:uint = 0;
         var _loc6_:Object = null;
         var _loc2_:Array = [];
         var _loc3_:int = param1.achievements.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            for each(_loc6_ in param1.achievements[_loc5_])
            {
               _loc2_.push(new TankmanAchievementVO(_loc6_));
            }
            _loc4_ = _loc2_.length;
            if(_loc5_ < _loc3_ - 1 && _loc4_ > 0)
            {
               _loc2_[_loc4_ - 1].showSeparator = true;
            }
            _loc5_++;
         }
         _loc4_ = _loc2_.length;
         if(_loc4_ > 0)
         {
            _loc2_[_loc4_ - 1].showSeparator = false;
         }
         this.stats = {};
         this.stats.achievements = _loc2_;
         this.stats.stats = param1.stats;
         this.stats.firstMsg = param1.firstMsg;
         this.stats.secondMsg = param1.secondMsg;
         this.stats.secondIcon = param1.secondIcon;
         this.stats.wotPlusIcon = param1.wotPlusIcon;
         this.stats.wotPlusMsg = param1.wotPlusMsg;
         this.runtimeUpdateByModel(PersonalCaseStats,this.stats);
      }
      
      public function as_setCrewSkinsNewCount(param1:int) : void
      {
         this.updateCrewSkinTabCount(param1);
      }
      
      override protected function setRetrainingData(param1:PersonalCaseRetrainingModel) : void
      {
         this.retrainingData = param1;
         this.retrainingData.updateData(this.data);
         this.runtimeUpdateByModel(CrewTankmanRetraining,this.retrainingData);
      }
      
      override protected function setFreeSkillsData(param1:Array) : void
      {
         this.freeSkillsModel = [];
         this.convertSkillsData(param1,this.freeSkillsModel,true);
         this.runtimeUpdateByModel(PersonalCaseFreeSkills,new PersonalCaseSkillsModel(this.freeSkillsModel,this.data.isBootcamp));
      }
      
      override protected function setSkillsData(param1:Array) : void
      {
         this.skillsModel = [];
         this.convertSkillsData(param1,this.skillsModel,false);
         this.updateSkillsRelatedElements();
         this.runtimeUpdateByModel(PersonalCaseSkills,new PersonalCaseSkillsModel(this.skillsModel,this.data.isBootcamp));
      }
      
      private function convertSkillsData(param1:Array, param2:Array, param3:Boolean) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:PersonalCaseSkillModel = null;
         var _loc6_:Object = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:Object = null;
         for each(_loc6_ in param1)
         {
            if(!(!_loc6_.hasOwnProperty(SKILLS) || !_loc6_.skills is Array || _loc6_.skills.length <= 0))
            {
               _loc5_ = new PersonalCaseSkillModel();
               _loc7_ = _loc6_.id;
               _loc5_.rankId = _loc7_;
               _loc5_.title = _loc7_;
               _loc5_.isHeader = true;
               _loc5_.selfSkill = this.data.roleType == _loc7_;
               param2.push(_loc5_);
               _loc4_ = _loc6_.skills.length;
               _loc8_ = 0;
               while(_loc8_ < _loc4_)
               {
                  _loc5_ = new PersonalCaseSkillModel();
                  _loc9_ = _loc6_.skills[_loc8_];
                  _loc5_.title = _loc9_.id;
                  _loc5_.iconName = _loc9_.iconName;
                  _loc5_.isHeader = false;
                  _loc5_.desc = _loc9_.desc;
                  _loc5_.enabled = _loc9_.enabled;
                  _loc5_.name = _loc9_.name;
                  _loc5_.tankmanID = _loc9_.tankmanID;
                  _loc5_.rankId = _loc7_;
                  _loc5_.selfSkill = this.data.roleType == _loc7_;
                  _loc5_.hasNewSkills = this.data.skillsCountForLearn > 0;
                  _loc5_.isFreeSkill = param3;
                  param2.push(_loc5_);
                  _loc8_++;
               }
            }
         }
      }
      
      override protected function setDocumentsData(param1:PersonalCaseDocsModel) : void
      {
         this.documentsData = param1;
         this.documentsData.originalIconFile = this.data.iconFile;
         this.documentsData.currentTankmanIcon = this.data.iconFile;
         this.runtimeUpdateByModel(PersonalCaseDocs,this.documentsData);
         this.rentainingTabUpdated = true;
      }
      
      override protected function setCrewSkinsData(param1:PersonalCaseCrewSkinsVO) : void
      {
         this.crewSkinsData = param1;
         this.crewSkinsData.tankmanID = this.data.inventoryID;
         this.runtimeUpdateByModel(PersonalCaseCrewSkins,this.crewSkinsData);
         this.updateCrewSkinTabCount(this.crewSkinsData.newSkinsCount);
      }
      
      protected function updateCommonElements() : void
      {
      }
      
      protected function updateSkillsRelatedElements() : void
      {
      }
      
      protected function runtimeUpdateByModel(param1:Class, param2:Object) : void
      {
      }
      
      protected function updateCrewSkinTabCount(param1:int) : void
      {
      }
      
      public function as_setDocumentsIsChangeEnable(param1:Boolean, param2:String) : void
      {
         this.documentsData.changeDocumentsEnable = param1;
         this.documentsData.warning = param2;
         this.runtimeUpdateByModel(PersonalCaseDocs,this.documentsData);
      }
      
      public function as_openTab(param1:String) : void
      {
         this.openTabByID(param1);
      }
      
      protected function openTabByID(param1:String) : void
      {
      }
   }
}
