package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.missions.MissionsViewBase;
   
   public class MissionsListViewBaseMeta extends MissionsViewBase
   {
       
      
      public var openMissionDetailsView:Function;
      
      public function MissionsListViewBaseMeta()
      {
         super();
      }
      
      public function openMissionDetailsViewS(param1:String, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.openMissionDetailsView,"openMissionDetailsView" + Errors.CANT_NULL);
         this.openMissionDetailsView(param1,param2);
      }
   }
}
