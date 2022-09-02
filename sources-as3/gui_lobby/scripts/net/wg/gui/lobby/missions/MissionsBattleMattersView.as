package net.wg.gui.lobby.missions
{
   import net.wg.infrastructure.base.meta.IBattleMattersViewMeta;
   import net.wg.infrastructure.base.meta.impl.BattleMattersViewMeta;
   
   public class MissionsBattleMattersView extends BattleMattersViewMeta implements IBattleMattersViewMeta
   {
       
      
      public function MissionsBattleMattersView()
      {
         super();
      }
      
      override protected function playFadeInTween() : void
      {
         alpha = 0;
         var _loc1_:int = 0;
         setFadeInTween(_loc1_);
         _hasBeenShownBefore = true;
      }
   }
}
