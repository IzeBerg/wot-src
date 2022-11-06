package net.wg.gui.battle.epicRandom.battleloading.renderers
{
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class TableEpicRandomPlayerItemRenderer extends EpicRandomBasePlayerItemRenderer
   {
       
      
      public function TableEpicRandomPlayerItemRenderer()
      {
         super();
      }
      
      override protected function setSelfBG() : void
      {
         if(selfBg != null)
         {
            selfBg.visible = UserTags.isCurrentPlayer(model.userTags);
            if(selfBg.visible)
            {
               selfBg.imageName = BATTLEATLAS.EPIC_RANDOM_BATTLE_LOADING_SELF_TABLE_BACKGROUND;
            }
         }
      }
   }
}
