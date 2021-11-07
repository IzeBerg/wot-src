package net.wg.infrastructure.tutorial.builders.bootcamp
{
   import net.wg.data.constants.generated.HANGAR_HEADER_QUESTS;
   import net.wg.gui.lobby.hangar.Hangar;
   import net.wg.gui.lobby.hangar.HangarHeader;
   import net.wg.gui.lobby.hangar.interfaces.IHeaderQuestsContainer;
   
   public class TutorialQuestVisibilityEffectBuilder extends TutorialVisibilityEffectBuilder
   {
       
      
      public function TutorialQuestVisibilityEffectBuilder()
      {
         super();
      }
      
      override protected function updateComponent() : void
      {
         var _loc2_:IHeaderQuestsContainer = null;
         super.updateComponent();
         var _loc1_:HangarHeader = Hangar(view).header;
         if(_loc1_)
         {
            _loc2_ = _loc1_.getQuestGroupByType(HANGAR_HEADER_QUESTS.QUEST_GROUP_COMMON);
            if(_loc2_)
            {
               _loc2_.x = component.x;
            }
         }
      }
   }
}
