package net.wg.gui.lobby.quests.components
{
   import net.wg.gui.components.containers.GroupEx;
   import net.wg.gui.lobby.quests.components.interfaces.IQuestSlotRenderer;
   
   public class SlotsGroup extends GroupEx
   {
       
      
      public function SlotsGroup()
      {
         super();
         layout = new SlotsLayout();
      }
      
      override protected function commitProperties() : void
      {
         var _loc2_:IQuestSlotRenderer = null;
         super.commitProperties();
         var _loc1_:int = numChildren;
         if(_loc1_ > 0)
         {
            _loc2_ = IQuestSlotRenderer(getChildAt(_loc1_ - 1));
            _loc2_.separatorVisible = false;
         }
      }
   }
}
