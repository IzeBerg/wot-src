package net.wg.gui.lobby.hangar
{
   import net.wg.data.constants.Directions;
   import net.wg.infrastructure.base.meta.ICrewXPPanelInjectMeta;
   import net.wg.infrastructure.base.meta.impl.CrewXPPanelInjectMeta;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   
   public class CrewXPPanelInject extends CrewXPPanelInjectMeta implements ICrewXPPanelInjectMeta, IHelpLayoutComponent
   {
      
      private static const HELP_LAYOUT_ID_DELIMITER:String = "_";
       
      
      private var _helpLayoutId:String = "";
      
      public function CrewXPPanelInject()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.utils.helpLayout.registerComponent(this);
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         if(!this._helpLayoutId)
         {
            this._helpLayoutId = name + HELP_LAYOUT_ID_DELIMITER + Math.random();
         }
         var _loc1_:HelpLayoutVO = new HelpLayoutVO();
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc1_.width = actualWidth;
         _loc1_.height = actualHeight;
         _loc1_.extensibilityDirection = Directions.RIGHT;
         _loc1_.message = "QUESTS.DAILYQUESTS_HEADER_TITLE";
         _loc1_.id = this._helpLayoutId;
         _loc1_.scope = this;
         return new <HelpLayoutVO>[_loc1_];
      }
   }
}
