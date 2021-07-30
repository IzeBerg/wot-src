package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IVehicleCompareConfiguratorViewMeta extends IEventDispatcher
   {
       
      
      function removeDeviceS(param1:String, param2:int) : void;
      
      function selectShellS(param1:String, param2:int) : void;
      
      function camoSelectedS(param1:Boolean) : void;
      
      function showModulesS() : void;
      
      function toggleTopModulesS(param1:Boolean) : void;
      
      function skillSelectS(param1:String, param2:int, param3:Boolean) : void;
      
      function changeCrewLevelS(param1:int) : void;
      
      function as_setDevicesData(param1:Array) : void;
      
      function as_setAmmo(param1:Array) : void;
      
      function as_setSelectedAmmoIndex(param1:int) : void;
      
      function as_setCamo(param1:Boolean) : void;
      
      function as_disableCamo() : void;
      
      function as_setSkillsBlocked(param1:Boolean) : void;
      
      function as_setCrewAttentionIconVisible(param1:Boolean) : void;
      
      function as_setSkills(param1:Array) : void;
      
      function as_setTopModulesSelected(param1:Boolean) : void;
      
      function as_setCrewLevelIndex(param1:int) : void;
      
      function as_setIsPostProgressionEnabled(param1:Boolean) : void;
   }
}
