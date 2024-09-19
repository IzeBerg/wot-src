package net.wg.gui.battle.eventBattle.views.teamBasePanel
{
   import net.wg.data.constants.Linkages;
   import net.wg.gui.battle.random.views.teamBasesPanel.TeamCaptureBar;
   import net.wg.infrastructure.base.meta.IEventTeamBasesPanelMeta;
   import net.wg.infrastructure.base.meta.impl.EventTeamBasesPanelMeta;
   
   public class EventTeamBasesPanel extends EventTeamBasesPanelMeta implements IEventTeamBasesPanelMeta
   {
       
      
      public function EventTeamBasesPanel()
      {
         super();
      }
      
      override protected function getBarLinkage() : String
      {
         return Linkages.EVENT_CAPTURE_BAR_LINKAGE;
      }
      
      public function as_updateCapture(param1:Number, param2:Number, param3:Number, param4:String, param5:String, param6:String, param7:String, param8:Boolean) : void
      {
         var _loc10_:EventTeamCaptureBar = null;
         as_updateCaptureData(param1,param2,param3,param4,param5,param6,param7);
         var _loc9_:TeamCaptureBar = getCaptureBarById(param1);
         if(_loc9_ is EventTeamCaptureBar)
         {
            _loc10_ = _loc9_ as EventTeamCaptureBar;
            _loc10_.lockGenerator(param8);
         }
      }
   }
}
