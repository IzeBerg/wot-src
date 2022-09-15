package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.components.BaseMissionDetailsContainerView;
   
   public class PersonalMissionDetailsContainerViewMeta extends BaseMissionDetailsContainerView
   {
       
      
      public var useSheet:Function;
      
      public var startMission:Function;
      
      public var retryMission:Function;
      
      public var discardMission:Function;
      
      public var obtainAward:Function;
      
      public var onPauseClick:Function;
      
      public function PersonalMissionDetailsContainerViewMeta()
      {
         super();
      }
      
      public function useSheetS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.useSheet,"useSheet" + Errors.CANT_NULL);
         this.useSheet(param1);
      }
      
      public function startMissionS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.startMission,"startMission" + Errors.CANT_NULL);
         this.startMission(param1);
      }
      
      public function retryMissionS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.retryMission,"retryMission" + Errors.CANT_NULL);
         this.retryMission(param1);
      }
      
      public function discardMissionS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.discardMission,"discardMission" + Errors.CANT_NULL);
         this.discardMission(param1);
      }
      
      public function obtainAwardS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.obtainAward,"obtainAward" + Errors.CANT_NULL);
         this.obtainAward(param1);
      }
      
      public function onPauseClickS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onPauseClick,"onPauseClick" + Errors.CANT_NULL);
         this.onPauseClick(param1);
      }
   }
}
