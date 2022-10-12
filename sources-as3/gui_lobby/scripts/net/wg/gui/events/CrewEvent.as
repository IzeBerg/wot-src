package net.wg.gui.events
{
   import flash.events.Event;
   
   public class CrewEvent extends Event
   {
      
      public static const OPEN_PERSONAL_CASE:String = "openPersonalCase";
      
      public static const ACT_TANKMAN:String = "actTankman";
      
      public static const SHOW_RECRUIT_WINDOW:String = "showRecruitWindow";
      
      public static const EQUIP_TANKMAN:String = "equipTankman";
      
      public static const SHOW_BERTH_BUY_DIALOG:String = "showBerthBuyDialog";
      
      public static const ON_INVALID_TANK_LIST:String = "onInvalidTankList";
      
      public static const ON_CHANGE_BARRACKS_FILTER:String = "onChangeBarracksFilter";
       
      
      public var initProp:Object;
      
      public var menuEnabled:Boolean;
      
      public var selectedTab:String;
      
      public function CrewEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:String = "stats")
      {
         super(param1,true,true);
         this.initProp = param2;
         this.menuEnabled = param3;
         this.selectedTab = param4;
      }
      
      override public function clone() : Event
      {
         return new CrewEvent(type,this.initProp,this.menuEnabled);
      }
   }
}
