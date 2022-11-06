package net.wg.gui.lobby.hangar.quests
{
   public class HEADER_QUESTS_CONSTANTS
   {
      
      public static const QUEST_BUTTONS_STEP:int = 60;
      
      public static const QUEST_BUTTON_VISUAL_WIDTH:int = 45;
      
      public static const QUEST_BUTTONS_GROUP_STEP:int = 7;
      
      public static const QUESTS_BUTTON_GAP:int = 15;
      
      public static const QUEST_BUTTONS_MASK_X_SHIFT_EXPAND:int = QUEST_BUTTONS_STEP - QUEST_BUTTONS_GROUP_STEP;
      
      public static const QUEST_BUTTONS_MASK_X_SHIFT_COLLAPSE:int = QUEST_BUTTON_VISUAL_WIDTH - QUEST_BUTTONS_GROUP_STEP;
       
      
      public function HEADER_QUESTS_CONSTANTS()
      {
         super();
      }
      
      public static function anim_delta_x() : int
      {
         return QUEST_BUTTONS_STEP - QUEST_BUTTONS_GROUP_STEP;
      }
   }
}
