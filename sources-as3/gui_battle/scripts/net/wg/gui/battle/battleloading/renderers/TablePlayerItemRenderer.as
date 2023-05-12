package net.wg.gui.battle.battleloading.renderers
{
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.random.battleloading.renderers.RandomPlayerItemRenderer;
   
   public class TablePlayerItemRenderer extends RandomPlayerItemRenderer
   {
       
      
      public function TablePlayerItemRenderer(param1:BaseRendererContainer, param2:int, param3:Boolean)
      {
         super(param1,param2,param3);
      }
      
      override protected function setSelfBG() : void
      {
         if(selfBg != null)
         {
            selfBg.visible = UserTags.isCurrentPlayer(model.userTags);
            if(selfBg.visible)
            {
               selfBg.imageName = BATTLEATLAS.BATTLE_LOADING_SELF_TABLE_BACKGROUND;
            }
         }
      }
   }
}
