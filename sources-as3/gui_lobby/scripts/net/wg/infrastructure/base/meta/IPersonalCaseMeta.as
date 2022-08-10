package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPersonalCaseMeta extends IEventDispatcher
   {
       
      
      function dismissTankmanS(param1:int) : void;
      
      function unloadTankmanS(param1:int, param2:int) : void;
      
      function getCommonDataS() : void;
      
      function getDossierDataS() : void;
      
      function getRetrainingDataS() : void;
      
      function retrainingTankmanS(param1:int, param2:int) : void;
      
      function getSkillsDataS() : void;
      
      function getDocumentsDataS() : void;
      
      function addTankmanSkillS(param1:int, param2:String) : void;
      
      function dropSkillsS() : void;
      
      function changeTankmanPassportS(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : void;
      
      function changeRetrainVehicleS(param1:int) : void;
      
      function openExchangeFreeToTankmanXpWindowS() : void;
      
      function openChangeRoleWindowS() : void;
      
      function getCrewSkinsDataS() : void;
      
      function equipCrewSkinS(param1:int) : void;
      
      function unequipCrewSkinS() : void;
      
      function takeOffNewMarkFromCrewSkinS(param1:int) : void;
      
      function changeHistoricallyAccurateS(param1:Boolean) : void;
      
      function playCrewSkinSoundS(param1:int) : void;
      
      function as_setCommonData(param1:Object) : void;
      
      function as_setDossierData(param1:Object) : void;
      
      function as_setRetrainingData(param1:Object) : void;
      
      function as_setSkillsData(param1:Array) : void;
      
      function as_setCrewSkinsNewCount(param1:int) : void;
      
      function as_setDocumentsData(param1:Object) : void;
      
      function as_setDocumentsIsChangeEnable(param1:Boolean, param2:String) : void;
      
      function as_setCrewSkinsData(param1:Object) : void;
   }
}
