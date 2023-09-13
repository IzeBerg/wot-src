package net.wg.gui.lobby.battleResults.components
{
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IFocusContainer;
   
   public class TeamMemberStatsViewBase extends UIComponentEx implements IFocusContainer
   {
      
      private static const ERROR_STRING:String = "[TeamMemberStatsViewBase] getComponentForFocus";
       
      
      protected var teamMemberItemData:TeamMemberItemVO = null;
      
      public function TeamMemberStatsViewBase()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.teamMemberItemData = null;
         super.onDispose();
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         var _loc1_:String = ERROR_STRING + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc1_);
         return null;
      }
      
      public function invalidateMedalsListData() : void
      {
      }
      
      public function setVehicleIdxInGarageDropdown(param1:int) : void
      {
      }
      
      public function get data() : TeamMemberItemVO
      {
         return this.teamMemberItemData;
      }
      
      public function set data(param1:TeamMemberItemVO) : void
      {
         this.teamMemberItemData = param1;
         invalidateData();
      }
      
      public function get isCloseBtnVisible() : Boolean
      {
         return false;
      }
      
      public function set isCloseBtnVisible(param1:Boolean) : void
      {
      }
   }
}
