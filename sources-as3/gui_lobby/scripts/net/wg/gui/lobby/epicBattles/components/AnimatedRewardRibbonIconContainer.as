package net.wg.gui.lobby.epicBattles.components
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesRewardRibbonVO;
   import net.wg.gui.lobby.eventProgression.components.metaLevel.EpicBattleMetaLevel;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AnimatedRewardRibbonIconContainer extends MovieClip implements IDisposable
   {
       
      
      public var imageIcon:UILoaderAlt = null;
      
      public var epicMetaLevelRegular:EpicBattleMetaLevel = null;
      
      public function AnimatedRewardRibbonIconContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.imageIcon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconLoadingCompleteHandler);
         this.imageIcon.dispose();
         this.imageIcon = null;
         this.epicMetaLevelRegular.dispose();
         this.epicMetaLevelRegular = null;
      }
      
      public function setData(param1:EpicBattlesRewardRibbonVO) : void
      {
         if(param1.epicMetaLevelIconData.seasonLevel)
         {
            this.imageIcon.visible = false;
            this.epicMetaLevelRegular.visible = true;
            this.epicMetaLevelRegular.setData(param1.epicMetaLevelIconData);
         }
         else if(param1.imageSource)
         {
            this.epicMetaLevelRegular.visible = false;
            this.imageIcon.addEventListener(UILoaderEvent.COMPLETE,this.onIconLoadingCompleteHandler,false,0,true);
            this.imageIcon.visible = true;
            this.imageIcon.source = param1.imageSource;
         }
      }
      
      private function onIconLoadingCompleteHandler(param1:UILoaderEvent) : void
      {
         this.imageIcon.x = -this.imageIcon.width >> 1;
         this.imageIcon.y = -this.imageIcon.height >> 1;
      }
   }
}
