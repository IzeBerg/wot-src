package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.impl.CrewPanelInjectMeta;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   
   public class CrewPanelInject extends CrewPanelInjectMeta implements IHelpLayoutComponent
   {
      
      private static const OPERATION_HEIGHT:uint = 38;
      
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
         var _loc1_:HelpLayoutVO = new HelpLayoutVO();
         _loc1_.x = 0;
         _loc1_.y = 0;
         _loc1_.width = this.width;
         _loc1_.height = OPERATION_HEIGHT;
         _loc1_.extensibilityDirection = EXTENSIBILITY_DIRECTION;
         _loc1_.message = LOBBY_HELP.HANGAR_CREWOPERATIONS;
         _loc1_.id = name + OPERATION_ID;
         _loc1_.scope = this;
         var _loc2_:HelpLayoutVO = new HelpLayoutVO();
         _loc2_.x = 0;
         _loc2_.y = OPERATION_HEIGHT;
         _loc2_.width = this.width;
         _loc2_.height = this.height - OPERATION_HEIGHT;
         _loc2_.extensibilityDirection = EXTENSIBILITY_DIRECTION;
         _loc2_.message = LOBBY_HELP.HANGAR_CREW;
         _loc2_.id = name + CREW_ID;
         _loc2_.scope = this;
         return new <HelpLayoutVO>[_loc1_,_loc2_];
      }
   }
}
