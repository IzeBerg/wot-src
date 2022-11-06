package net.wg.gui.events
{
   import flash.events.Event;
   import net.wg.gui.lobby.tankman.crewSkins.model.CrewSkinVO;
   
   public class PersonalCaseEvent extends Event
   {
      
      public static const APPLY_RETRAINING:String = "applyRetraining";
      
      public static const TRAINING_FREE_SKILL:String = "trainingFreeSkill";
      
      public static const TRAINING_SKILL:String = "trainingSkill";
      
      public static const CHANGE_PASSPORT:String = "changePassport";
      
      public static const CHANGE_TAB:String = "changeTabToSkills";
      
      public static const GET_TANKMAN_ID:String = "getTankmanID";
      
      public static const CHANGE_RETRAIN_VEHICLE:String = "changeRetrainVehicle";
      
      public static const EQUIP_CREW_SKIN:String = "equipCrewSkin";
      
      public static const UNEQUIP_CREW_SKIN:String = "unequipCrewSkin";
      
      public static const TAKE_OFF_NEW_MARK:String = "takeOffNewMark";
      
      public static const UPDATE_SELECTED_CREW_SKIN_INFO:String = "updateSelectedCrewSkinInfo";
      
      public static const INIT_CREW_SKINS_SCROLL:String = "initCrewSkinsScroll";
      
      public static const CHANGE_CREW_SKIN_HISTORICALLY_ACCURATE:String = "changeHistoricallyAccurate";
      
      public static const PLAY_CREW_SKIN_SOUND:String = "playCrewSkinSound";
      
      public static const TEACH_SKILL:String = "teachSkill";
      
      public static const DROP_SKILL:String = "dropSkill";
      
      public static const INFO_BTN_CLICK:String = "infoBtnClick";
      
      public static const SKILLS_LIST_INITED:String = "skillsListInited";
       
      
      public var tankmanIdDelegate:Function;
      
      public var retrainingTankmanData:Object;
      
      public var trainingSkillName:String;
      
      public var newTankmanFirstName:Object;
      
      public var newTankmanLastName:Object;
      
      public var newIcon:Object;
      
      public var vehicleId:int;
      
      public var crewSkinID:int;
      
      public var crewSkinModel:CrewSkinVO;
      
      public var selectedCrewSkinPosY:Number;
      
      public var historicallyAccurate:Boolean;
      
      public var scrollSkillsToLastItem:Boolean = false;
      
      public var relatedTabId:String;
      
      public function PersonalCaseEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         this.newTankmanFirstName = {};
         this.newTankmanLastName = {};
         this.newIcon = {};
         super(param1,param2,param3);
      }
   }
}
