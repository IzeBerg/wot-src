package net.wg.gui.fortBase
{
   public interface IBuildingVO extends IBuildingBaseVO
   {
       
      
      function validate() : void;
      
      function get isInFoundationState() : Boolean;
      
      function get toolTipData() : Vector.<String>;
      
      function get transportTooltipData() : Vector.<String>;
      
      function get isDefenceHour() : Boolean;
      
      function set isDefenceHour(param1:Boolean) : void;
      
      function get orderTime() : String;
      
      function set orderTime(param1:String) : void;
      
      function get direction() : int;
      
      function set direction(param1:int) : void;
      
      function get position() : int;
      
      function set position(param1:int) : void;
      
      function get directionType() : int;
      
      function set directionType(param1:int) : void;
      
      function get cooldown() : String;
      
      function set cooldown(param1:String) : void;
      
      function get progress() : int;
      
      function set progress(param1:int) : void;
      
      function get isAvailable() : Boolean;
      
      function set isAvailable(param1:Boolean) : void;
      
      function get isExportAvailable() : Boolean;
      
      function set isExportAvailable(param1:Boolean) : void;
      
      function get isImportAvailable() : Boolean;
      
      function set isImportAvailable(param1:Boolean) : void;
      
      function get isLevelUp() : Boolean;
      
      function set isLevelUp(param1:Boolean) : void;
      
      function get isOpenCtxMenu() : Boolean;
      
      function set isOpenCtxMenu(param1:Boolean) : void;
      
      function get productionInPause() : Boolean;
      
      function set productionInPause(param1:Boolean) : void;
      
      function get underAttack() : Boolean;
      
      function set underAttack(param1:Boolean) : void;
      
      function get looted() : Boolean;
      
      function set looted(param1:Boolean) : void;
      
      function get isBaseBuildingDamaged() : Boolean;
      
      function set isBaseBuildingDamaged(param1:Boolean) : void;
      
      function get isFortFrozen() : Boolean;
      
      function set isFortFrozen(param1:Boolean) : void;
   }
}
