package net.wg.gui.battle.interfaces
{
   import net.wg.data.VO.daapi.DAAPIInvitationStatusVO;
   import net.wg.data.VO.daapi.DAAPIVehicleUserTagsVO;
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
   }
}
