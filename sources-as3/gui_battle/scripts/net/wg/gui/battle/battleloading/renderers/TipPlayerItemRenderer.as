package net.wg.gui.battle.battleloading.renderers
{
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.gui.battle.random.battleloading.renderers.RandomPlayerItemRenderer;
   
   public class TipPlayerItemRenderer extends RandomPlayerItemRenderer
   {
       
      
      public function TipPlayerItemRenderer(param1:BaseRendererContainer, param2:int, param3:Boolean)
      {
         super(param1,param2,param3);
      }
      
      override protected function setSelfBG() : void
      {
         if(selfBg != null && model != null)
         {
            selfBg.visible = UserTags.isCurrentPlayer(model.userTags);
            if(selfBg.visible)
            {
               selfBg.imageName = !!isExtendedLayout ? BATTLEATLAS.BATTLE_LOADING_SELF_TIPS_EXTENDED_BACKGROUND : BATTLEATLAS.BATTLE_LOADING_SELF_TIPS_BACKGROUND;
            }
         }
      }
   }
}
