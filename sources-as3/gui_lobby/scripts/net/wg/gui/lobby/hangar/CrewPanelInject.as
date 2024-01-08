package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.impl.CrewPanelInjectMeta;
   import net.wg.utils.StageSizeBoundaries;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   
   public class CrewPanelInject extends CrewPanelInjectMeta implements IHelpLayoutComponent
   {
      
      private static const OPERATION_HEIGHT:uint = 38;
      
      private static const CREW_ADDITIONAL_WIDTH:int = -50;
      
      private static const START_Y_POS:int = -3;
      
      private static const OPERATION_ID:String = "_crewOperations";
      
      private static const CREW_ID:String = "_crewWidget";
      
      private static const EXTENSIBILITY_DIRECTION:String = "R";
       
      
      public function CrewPanelInject()
      {
         super();
         setManageSize(false);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.utils.helpLayout.registerComponent(this);
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         var _loc1_:int = this.width + Math.min(CREW_ADDITIONAL_WIDTH + (App.appWidth - StageSizeBoundaries.WIDTH_1024 >> 1),0);
         var _loc2_:HelpLayoutVO = new HelpLayoutVO();
         _loc2_.x = 0;
         _loc2_.y = START_Y_POS;
         _loc2_.width = _loc1_;
         _loc2_.height = OPERATION_HEIGHT;
         _loc2_.extensibilityDirection = EXTENSIBILITY_DIRECTION;
         _loc2_.message = LOBBY_HELP.HANGAR_CREWOPERATIONS;
         _loc2_.id = name + OPERATION_ID;
         _loc2_.scope = this;
         var _loc3_:HelpLayoutVO = new HelpLayoutVO();
         _loc3_.x = 0;
         _loc3_.y = START_Y_POS + OPERATION_HEIGHT;
         _loc3_.width = _loc1_;
         _loc3_.height = this.height - OPERATION_HEIGHT;
         _loc3_.extensibilityDirection = EXTENSIBILITY_DIRECTION;
         _loc3_.message = LOBBY_HELP.HANGAR_CREW;
         _loc3_.id = name + CREW_ID;
         _loc3_.scope = this;
         return new <HelpLayoutVO>[_loc2_,_loc3_];
      }
   }
}
