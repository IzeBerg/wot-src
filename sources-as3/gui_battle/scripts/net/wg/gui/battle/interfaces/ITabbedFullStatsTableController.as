package net.wg.gui.battle.interfaces
{
   import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.VO.daapi.DAAPIVehicleStatsVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface ITabbedFullStatsTableController extends IStatsTableController, IDisposable
   {
       
      
      function setUserTags(param1:Boolean, param2:Vector.<DAAPIVehicleUserTagsVO>) : void;
      
      function updateInvitationsStatuses(param1:Boolean, param2:Vector.<DAAPIInvitationStatusVO>) : void;
      
      function setPlayerStatus(param1:Boolean, param2:Number, param3:uint) : void;
      
      function setInteractive(param1:Boolean, param2:Boolean) : void;
      
      function setIsInviteShown(param1:Boolean, param2:Boolean) : void;
      
      function setSpeaking(param1:Number, param2:Boolean) : void;
      
      function updateColorBlind() : void;
      
      function get isRenderingAvailable() : Boolean;
      
      function set isRenderingAvailable(param1:Boolean) : void;
      
      function addVehiclesInfo(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>, param3:Boolean) : void;
      
      function setVehiclesData(param1:Array, param2:Vector.<Number>, param3:Boolean) : void;
      
      function setDogTagToShow(param1:Number, param2:DogTagVO) : void;
      
      function setVehicleStatus(param1:Boolean, param2:Number, param3:uint, param4:Vector.<Number>) : void;
      
      function updateVehiclesData(param1:Vector.<DAAPIVehicleInfoVO>, param2:Vector.<Number>, param3:Boolean) : void;
      
      function setVehiclesStats(param1:Vector.<DAAPIVehicleStatsVO>, param2:Vector.<DAAPIVehicleStatsVO>) : void;
   }
}
