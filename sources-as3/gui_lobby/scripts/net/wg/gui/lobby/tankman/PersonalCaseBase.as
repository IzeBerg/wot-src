package net.wg.gui.lobby.tankman
{
   import net.wg.data.VO.TankmanAchievementVO;
   import net.wg.gui.lobby.tankman.crewSkins.model.PersonalCaseCrewSkinsVO;
   import net.wg.infrastructure.base.meta.IPersonalCaseMeta;
   import net.wg.infrastructure.base.meta.impl.PersonalCaseMeta;
   
   public class PersonalCaseBase extends PersonalCaseMeta implements IPersonalCaseMeta
   {
       
      
      protected var isFirtsRun:Boolean = true;
      
      protected var autoSelectTab:int = 0;
      
      protected var data:PersonalCaseModel;
      
      protected var stats:Object;
      
      protected var retrainingData:PersonalCaseRetrainingModel;
      
      protected var skillsModel:Array;
      
      protected var documentsData:PersonalCaseDocsModel;
      
      protected var crewSkinsData:PersonalCaseCrewSkinsVO;
      
      protected var rentainingTabUpdated:Boolean = true;
      
      public function PersonalCaseBase()
      {
         this.skillsModel = [];
         super();
      }
      
      override protected function onDispose() : void
      {
         this.data = null;
         this.stats = null;
         this.retrainingData = null;
         this.skillsModel = null;
         this.documentsData = null;
         this.crewSkinsData = null;
         super.onDispose();
      }
      
      override protected function setCommonData(param1:PersonalCaseModel) : void
      {
         this.autoSelectTab = param1.tabIndex;
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
      
      override protected function setSkillsData(param1:Array) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:PersonalCaseSkillModel = null;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         this.skillsModel = [];
         for each(_loc4_ in param1)
         {
            if(!(!_loc4_.hasOwnProperty("skills") || !_loc4_.skills is Array || _loc4_.skills.length <= 0))
            {
               _loc3_ = new PersonalCaseSkillModel();
               _loc5_ = _loc4_.id;
               _loc3_.rankId = _loc5_;
               _loc3_.title = _loc5_;
               _loc3_.isHeader = true;
               _loc3_.selfSkill = this.data.roleType == _loc5_;
               this.skillsModel.push(_loc3_);
               _loc2_ = _loc4_.skills.length;
               _loc6_ = 0;
               while(_loc6_ < _loc2_)
               {
                  _loc3_ = new PersonalCaseSkillModel();
                  _loc7_ = _loc4_.skills[_loc6_];
                  _loc3_.title = _loc7_.id;
                  _loc3_.isHeader = false;
                  _loc3_.desc = _loc7_.desc;
                  _loc3_.enabled = _loc7_.enabled;
                  _loc3_.name = _loc7_.name;
                  _loc3_.tankmanID = _loc7_.tankmanID;
                  _loc3_.rankId = _loc5_;
                  _loc3_.selfSkill = this.data.roleType == _loc5_;
                  _loc3_.hasNewSkills = this.data.skillsCountForLearn > 0;
                  this.skillsModel.push(_loc3_);
                  _loc6_++;
               }
            }
         }
         this.updateSkillsRelatedElements();
         this.runtimeUpdateByModel(PersonalCaseSkills,new PersonalCaseSkillsModel(this.skillsModel,this.data.isBootcamp));
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
   }
}
