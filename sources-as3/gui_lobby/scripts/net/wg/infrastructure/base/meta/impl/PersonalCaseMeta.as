package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.tankman.PersonalCaseDocsModel;
   import net.wg.gui.lobby.tankman.PersonalCaseModel;
   import net.wg.gui.lobby.tankman.PersonalCaseRetrainingModel;
   import net.wg.gui.lobby.tankman.crewSkins.model.PersonalCaseCrewSkinsVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PersonalCaseMeta extends AbstractWindowView
   {
       
      
      public var dismissTankman:Function;
      
      public var unloadTankman:Function;
      
      public var getCommonData:Function;
      
      public var getDossierData:Function;
      
      public var getRetrainingData:Function;
      
      public var retrainingTankman:Function;
      
      public var getFreeSkillsData:Function;
      
      public var getSkillsData:Function;
      
      public var getDocumentsData:Function;
      
      public var addTankmanSkill:Function;
      
      public var addTankmanFreeSkill:Function;
      
      public var dropSkills:Function;
      
      public var showFreeSkillsInfo:Function;
      
      public var changeTankmanPassport:Function;
      
      public var changeRetrainVehicle:Function;
      
      public var openExchangeFreeToTankmanXpWindow:Function;
      
      public var openChangeRoleWindow:Function;
      
      public var getCrewSkinsData:Function;
      
      public var equipCrewSkin:Function;
      
      public var unequipCrewSkin:Function;
      
      public var takeOffNewMarkFromCrewSkin:Function;
      
      public var changeHistoricallyAccurate:Function;
      
      public var playCrewSkinSound:Function;
      
      public var updateOpenedTabID:Function;
      
      private var _personalCaseModel:PersonalCaseModel;
      
      private var _personalCaseRetrainingModel:PersonalCaseRetrainingModel;
      
      private var _array:Array;
      
      private var _array1:Array;
      
      private var _personalCaseDocsModel:PersonalCaseDocsModel;
      
      private var _personalCaseCrewSkinsVO:PersonalCaseCrewSkinsVO;
      
      public function PersonalCaseMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._personalCaseModel)
         {
            this._personalCaseModel.dispose();
            this._personalCaseModel = null;
         }
         if(this._personalCaseRetrainingModel)
         {
            this._personalCaseRetrainingModel.dispose();
            this._personalCaseRetrainingModel = null;
         }
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         if(this._array1)
         {
            this._array1.splice(0,this._array1.length);
            this._array1 = null;
         }
         if(this._personalCaseDocsModel)
         {
            this._personalCaseDocsModel.dispose();
            this._personalCaseDocsModel = null;
         }
         if(this._personalCaseCrewSkinsVO)
         {
            this._personalCaseCrewSkinsVO.dispose();
            this._personalCaseCrewSkinsVO = null;
         }
         super.onDispose();
      }
      
      public function dismissTankmanS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.dismissTankman,"dismissTankman" + Errors.CANT_NULL);
         this.dismissTankman(param1);
      }
      
      public function unloadTankmanS(param1:int, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.unloadTankman,"unloadTankman" + Errors.CANT_NULL);
         this.unloadTankman(param1,param2);
      }
      
      public function getCommonDataS() : void
      {
         App.utils.asserter.assertNotNull(this.getCommonData,"getCommonData" + Errors.CANT_NULL);
         this.getCommonData();
      }
      
      public function getDossierDataS() : void
      {
         App.utils.asserter.assertNotNull(this.getDossierData,"getDossierData" + Errors.CANT_NULL);
         this.getDossierData();
      }
      
      public function getRetrainingDataS() : void
      {
         App.utils.asserter.assertNotNull(this.getRetrainingData,"getRetrainingData" + Errors.CANT_NULL);
         this.getRetrainingData();
      }
      
      public function retrainingTankmanS(param1:int, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.retrainingTankman,"retrainingTankman" + Errors.CANT_NULL);
         this.retrainingTankman(param1,param2);
      }
      
      public function getFreeSkillsDataS() : void
      {
         App.utils.asserter.assertNotNull(this.getFreeSkillsData,"getFreeSkillsData" + Errors.CANT_NULL);
         this.getFreeSkillsData();
      }
      
      public function getSkillsDataS() : void
      {
         App.utils.asserter.assertNotNull(this.getSkillsData,"getSkillsData" + Errors.CANT_NULL);
         this.getSkillsData();
      }
      
      public function getDocumentsDataS() : void
      {
         App.utils.asserter.assertNotNull(this.getDocumentsData,"getDocumentsData" + Errors.CANT_NULL);
         this.getDocumentsData();
      }
      
      public function addTankmanSkillS(param1:int, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.addTankmanSkill,"addTankmanSkill" + Errors.CANT_NULL);
         this.addTankmanSkill(param1,param2);
      }
      
      public function addTankmanFreeSkillS(param1:int, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.addTankmanFreeSkill,"addTankmanFreeSkill" + Errors.CANT_NULL);
         this.addTankmanFreeSkill(param1,param2);
      }
      
      public function dropSkillsS() : void
      {
         App.utils.asserter.assertNotNull(this.dropSkills,"dropSkills" + Errors.CANT_NULL);
         this.dropSkills();
      }
      
      public function showFreeSkillsInfoS() : void
      {
         App.utils.asserter.assertNotNull(this.showFreeSkillsInfo,"showFreeSkillsInfo" + Errors.CANT_NULL);
         this.showFreeSkillsInfo();
      }
      
      public function changeTankmanPassportS(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : void
      {
         App.utils.asserter.assertNotNull(this.changeTankmanPassport,"changeTankmanPassport" + Errors.CANT_NULL);
         this.changeTankmanPassport(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function changeRetrainVehicleS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.changeRetrainVehicle,"changeRetrainVehicle" + Errors.CANT_NULL);
         this.changeRetrainVehicle(param1);
      }
      
      public function openExchangeFreeToTankmanXpWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.openExchangeFreeToTankmanXpWindow,"openExchangeFreeToTankmanXpWindow" + Errors.CANT_NULL);
         this.openExchangeFreeToTankmanXpWindow();
      }
      
      public function openChangeRoleWindowS() : void
      {
         App.utils.asserter.assertNotNull(this.openChangeRoleWindow,"openChangeRoleWindow" + Errors.CANT_NULL);
         this.openChangeRoleWindow();
      }
      
      public function getCrewSkinsDataS() : void
      {
         App.utils.asserter.assertNotNull(this.getCrewSkinsData,"getCrewSkinsData" + Errors.CANT_NULL);
         this.getCrewSkinsData();
      }
      
      public function equipCrewSkinS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.equipCrewSkin,"equipCrewSkin" + Errors.CANT_NULL);
         this.equipCrewSkin(param1);
      }
      
      public function unequipCrewSkinS() : void
      {
         App.utils.asserter.assertNotNull(this.unequipCrewSkin,"unequipCrewSkin" + Errors.CANT_NULL);
         this.unequipCrewSkin();
      }
      
      public function takeOffNewMarkFromCrewSkinS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.takeOffNewMarkFromCrewSkin,"takeOffNewMarkFromCrewSkin" + Errors.CANT_NULL);
         this.takeOffNewMarkFromCrewSkin(param1);
      }
      
      public function changeHistoricallyAccurateS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.changeHistoricallyAccurate,"changeHistoricallyAccurate" + Errors.CANT_NULL);
         this.changeHistoricallyAccurate(param1);
      }
      
      public function playCrewSkinSoundS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.playCrewSkinSound,"playCrewSkinSound" + Errors.CANT_NULL);
         this.playCrewSkinSound(param1);
      }
      
      public function updateOpenedTabIDS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.updateOpenedTabID,"updateOpenedTabID" + Errors.CANT_NULL);
         this.updateOpenedTabID(param1);
      }
      
      public final function as_setCommonData(param1:Object) : void
      {
         var _loc2_:PersonalCaseModel = this._personalCaseModel;
         this._personalCaseModel = new PersonalCaseModel(param1);
         this.setCommonData(this._personalCaseModel);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setRetrainingData(param1:Object) : void
      {
         var _loc2_:PersonalCaseRetrainingModel = this._personalCaseRetrainingModel;
         this._personalCaseRetrainingModel = new PersonalCaseRetrainingModel(param1);
         this.setRetrainingData(this._personalCaseRetrainingModel);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setFreeSkillsData(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.setFreeSkillsData(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setSkillsData(param1:Array) : void
      {
         var _loc2_:Array = this._array1;
         this._array1 = param1;
         this.setSkillsData(this._array1);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setDocumentsData(param1:Object) : void
      {
         var _loc2_:PersonalCaseDocsModel = this._personalCaseDocsModel;
         this._personalCaseDocsModel = new PersonalCaseDocsModel(param1);
         this.setDocumentsData(this._personalCaseDocsModel);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setCrewSkinsData(param1:Object) : void
      {
         var _loc2_:PersonalCaseCrewSkinsVO = this._personalCaseCrewSkinsVO;
         this._personalCaseCrewSkinsVO = new PersonalCaseCrewSkinsVO(param1);
         this.setCrewSkinsData(this._personalCaseCrewSkinsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setCommonData(param1:PersonalCaseModel) : void
      {
         var _loc2_:String = "as_setCommonData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setRetrainingData(param1:PersonalCaseRetrainingModel) : void
      {
         var _loc2_:String = "as_setRetrainingData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setFreeSkillsData(param1:Array) : void
      {
         var _loc2_:String = "as_setFreeSkillsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setSkillsData(param1:Array) : void
      {
         var _loc2_:String = "as_setSkillsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setDocumentsData(param1:PersonalCaseDocsModel) : void
      {
         var _loc2_:String = "as_setDocumentsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setCrewSkinsData(param1:PersonalCaseCrewSkinsVO) : void
      {
         var _loc2_:String = "as_setCrewSkinsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
