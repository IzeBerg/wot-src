package net.wg.gui.lobby.fortifications.battleRoom
{
   import net.wg.gui.lobby.fortifications.data.battleRoom.LegionariesSortieVO;
   
   public class JoinSortieDetailsSection extends JoinSortieSection
   {
       
      
      public var alertView:JoinSortieDetailsSectionAlertView = null;
      
      public function JoinSortieDetailsSection()
      {
         super();
         this.alertView.visible = false;
      }
      
      override protected function updateElements() : void
      {
         var _loc1_:LegionariesSortieVO = null;
         var _loc2_:Boolean = false;
         if(model != null)
         {
            _loc1_ = LegionariesSortieVO(model);
            _loc2_ = _loc1_.isShowAlertView;
            if(_loc2_)
            {
               updateNoRallyScreenVisibility(false);
               updateElementsVisibility(false);
               this.alertView.update(_loc1_.alertView);
               this.alertView.visible = true;
               return;
            }
            this.alertView.visible = false;
         }
         super.updateElements();
      }
      
      override protected function onDispose() : void
      {
         this.alertView.dispose();
         this.alertView = null;
         super.onDispose();
      }
   }
}
